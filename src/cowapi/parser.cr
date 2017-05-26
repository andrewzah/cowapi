module Cowapi
  alias MixedTypes = Int32 | Float32 | String
  alias MixedHash = Hash(String, MixedTypes)
  alias X2NestedHash = Hash(String, MixedHash)
  alias X3NestedHash = Hash(String, X2NestedHash)
  alias X4NestedHash = Hash(String, X3NestedHash)

  def self.parse_career_stats(node, heroID) : X2NestedHash
    output = X2NestedHash.new

    boxes = xpath_ns(node, ".//div[@data-category-id='#{heroID}']")
    return output if boxes.empty?

    output["general"] = MixedHash.new
    boxes[0].children.each do |box|
      header = make_json_friendly(xpath_ns(box, "./div/table/thead/tr/th/span/text()")[0].content)
      cells = xpath_ns(box, ".//tr")

      cellValues = MixedHash.new
      # each cell (a <tr>) should have 2 <td> elements
      # the first being the name, the second the value
      cells.each do |cell|
        tds = xpath_ns(cell, "./td")
        next if tds.size == 0

        name = make_json_friendly(tds[0].content)
        value = tds[1].content

        cellValues[name] = resolve_value(value)
      end

      output[header] = cellValues
    end

    return output
  end

  def self.parse_hero(parsed, heroID, mode) : X3NestedHash
    output = X3NestedHash.new

    careerStats = xpath_ns(parsed, "//div[@data-js='career-category']")
    careerStats.each do |node|
      if node["id"] == "competitive"
        output["competitive"] = parse_career_stats(node, heroID) unless mode == "quickplay"
      elsif node["id"] == "quickplay"
        output["quickplay"] = parse_career_stats(node, heroID) unless mode == "competitive"
      end
    end

    output
  end

  def self.parse_heroes(input, data, mode)
    # {heroes: { pharah: { competitive: { randostats: {} } } }
    output = Hash(String, Hash(String, Hash(String, Hash(String, MixedTypes)))).new
    parsed = XML.parse_html(data)

    input.each do |name, id|
      output[name] = parse_hero(parsed, id, mode)
    end

    output.to_json
  end

  # Gets random user info from the .masthead class
  def self.parse_misc(parsed)
    output = Hash(String, MixedTypes).new

    masthead = xpath_ns(parsed, "//div[@class='masthead']")
    return output if masthead.empty?

    if portrait = xpath_ns(masthead[0], "./div/img")
      output["portrait"] = portrait[0]["src"]
    end

    if name = xpath_ns(masthead[0], "./div/h1")
      output["tag"] = name[0].content
    end

    if playerLevel = xpath_ns(masthead[0], "./div/div/div[@class='player-level']")
      output["level_portrait"] = playerLevel[0]["style"][21..-2]
      prestigeLevel = playerLevel[0].children[0].content.to_i32
      output["prestige_level"] = prestigeLevel
      # output["level"] = resolve_level(playerLevel[0]["style"][-30..-2]) + prestigeLevel
    end

    if rank = xpath_ns(masthead[0], "./div/div/div[@class='competitive-rank']/*")
      output["tier_portrait"] = rank[0]["src"]
      # output["tier"] = resolve_rank(rank[0]["src"][-10...-1])
      output["rank"] = rank[1].content.to_i32
    end

    if gamesWon = xpath_ns(masthead[0], "./p")
      output["total_games_won"] = gamesWon[0].content[/\d+/].to_i32
    end

    output
  end

  def self.parse_profile(data, mode)
    output = Hash(String, MixedHash | X3NestedHash).new
    parsed = XML.parse_html(data)

    output["heroes"] = parse_hero(parsed, HERO_DIV_IDS["total"], mode)

    output["general"] = parse_misc(parsed)

    gamesPlayed = output["heroes"]["competitive"].as(X2NestedHash)["general"]["games_played"]?
    gamesWon = output["heroes"]["competitive"].as(X2NestedHash)["general"]["games_won"]?
    gamesTied = output["heroes"]["competitive"].as(X2NestedHash)["general"]["games_tied"]?
    gamesLost = output["heroes"]["competitive"].as(X2NestedHash)["general"]["games_lost"]?

    if gamesPlayed && gamesWon && gamesTied && gamesLost
      add = MixedHash.new
      add = {
        "comp_games_won"      => gamesWon,
        "comp_games_tied"     => gamesTied,
        "comp_games_lost"     => gamesLost,
        "comp_games_played"   => gamesPlayed,
        "comp_win_percentage" => gamesWon.as(Int32) / (gamesPlayed.as(Int32) - gamesTied.as(Int32))
      }
      
      output["general"] = output["general"].as(MixedHash).merge!(add)
    end

    output.to_json
  end
end

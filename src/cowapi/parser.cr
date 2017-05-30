module Cowapi
  def self.parse_career_stats(node, heroID) : Array(Stat) | Nil
    boxes = xpath_ns(node, ".//div[@data-category-id='#{heroID}']")
    return nil if boxes.empty?

    output = [] of Stat
    boxes[0].children.each do |box|
      category = make_json_friendly(xpath_ns(box, "./div/table/thead/tr/th/span/text()")[0].content)
      cells = xpath_ns(box, ".//tr")

      cells.each do |cell|
        tds = xpath_ns(cell, "./td")
        next if tds.size == 0 # skip table header

        name = make_json_friendly(tds[0].content)
        value = tds[1].content

        stat = Stat.new(name, resolve_value(value), category)
        output << stat
      end
    end

    output
  end

  def self.parse_hero(parsed : XML::Node, heroID, heroName, mode) : Hero
    comp, qp = nil, nil
    careerStats = xpath_ns(parsed, "//div[@data-js='career-category']")
    careerStats.each do |node|
      if node["id"] == "competitive"
        comp = parse_career_stats(node, heroID) unless mode == "quickplay"
      elsif node["id"] == "quickplay"
        qp = parse_career_stats(node, heroID) unless mode == "competitive"
      end
    end
    Hero.new(heroName, qp, comp)
  end

  def self.parse_heroes(parsed : XML::Node, mode, input = HERO_DIV_IDS)
    output = [] of Hero

    input.each do |name, id|
      output << parse_hero(parsed, id, name, mode)
    end

    output
  end

  # Gets random user info from the .masthead class
  def self.parse_personal_stats(parsed) : ProfileStats
    masthead = xpath_ns(parsed, "//div[@class='masthead']")
    raise Exception.new("No profile stats!") if masthead.empty?

    portrait = xpath_ns(masthead[0], "./div/img")[0]["src"]

    name = xpath_ns(masthead[0], "./div/h1")[0].content

    playerLevelDiv = xpath_ns(masthead[0], "./div/div/div[@class='player-level']")
    borderPortrait = playerLevelDiv[0]["style"][21..-2]
    level = playerLevelDiv[0].children[0].content.to_i32
    prestigeLevel = (PRESTIGE[playerLevelDiv[0]["style"][-30..-13]]? || 0) * 100 + level

		rank, tierPortrait, tier, rank = nil, nil, nil, nil
    if rankDiv = xpath_ns(masthead[0], "./div/div/div[@class='competitive-rank']/*")
	    tierPortrait = rankDiv[0]["src"]
      tier = TIER[rankDiv[0]["src"][-10..-1]]? || "Unknown"
    	rank = rankDiv[1].content.to_i32
    end

    gamesWon = xpath_ns(masthead[0], "./p")[0].content[/\d+/].to_i32 || 0

    ProfileStats.new(portrait, name, prestigeLevel, borderPortrait, rank, tierPortrait, tier, gamesWon)
  end

  def self.parse_profile(parsed, mode)
    profileStats = parse_personal_stats(parsed)
    heroes = parse_heroes(parsed, mode)

    output = Profile.new(profileStats, heroes)
  end
end

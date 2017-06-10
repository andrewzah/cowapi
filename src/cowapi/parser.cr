# Copyright (C) 2017 - Andrew Zah (github.com/azah)

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

module Cowapi
  def self.parse_career_stats(node, heroID) : Array(Stat) | Nil
    boxes = node.css("div[data-category-id='#{heroID}']").to_a
    return nil if boxes.empty?

    output = [] of Stat
    boxes[0].children.each do |box|
      #category = make_json_friendly(box.css("div/table/thead/tr/th/span").to_a[0].inner_text)
      category = make_json_friendly(box.css("div table thead tr th span").to_a[0].inner_text)
      cells = box.css("tr").to_a

      cells.each do |cell|
        tds = cell.css("td").to_a
        next if tds.size == 0 # skip table header

        name = make_json_friendly(tds[0].inner_text)
        value = tds[1].inner_text

        stat = Stat.new(name, resolve_value(value), category)
        output << stat
      end
    end

    output
  end

  def self.parse_hero(parsed, heroID, heroName, mode)
    comp, qp = nil, nil
    careerStats = parsed.css("div[data-js='career-category']").to_a
    puts careerStats
    careerStats.each do |node|
      puts node.inspect
    end
    careerStats.each do |node|
      case node.attribute_by("id")
      when "competitive"
        comp = parse_career_stats(node, heroID) unless mode == "quickplay"
      when "quickplay"
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

module Cowapi
  alias MixedTypes = Int32 | Float32 | String

  class Profile
    def initialize(@profile, @heroes)
    end

    JSON.mapping(
      profile: ProfileStats,
      heroes: Array(Hero)
    )
  end

  class ProfileStats
    def initialize(
                   @avatar,
                   @name,
                   @player_level,
                   @border_portrait,
                   @comp_rank = nil,
                   @tier_portrait = nil,
                   @tier = nil,
                   @games_won = 0)
    end

    JSON.mapping(
      avatar: String,
      name: String,
      player_level: Int32,
      border_portrait: String,
      comp_rank: Int32 | Nil,
      tier_portrait: String | Nil,
      tier: String | Nil,
      games_won: Int32
    )
  end

  class Hero
    def initialize(@name, @quickplay = nil, @comp = nil)
    end

    JSON.mapping(
      name: String,
      quickplay: Array(Stat) | Nil,
      comp: Array(Stat) | Nil
    )
  end

  class Stat
    def initialize(@name, @value, @category)
    end

    JSON.mapping(
      name: String,
      value: MixedTypes,
      category: String
    )
  end
end

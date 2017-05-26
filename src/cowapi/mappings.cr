module Cowapi
  alias MixedTypes = Int32 | Float32 | String

  class StatsValue
    JSON.mapping(
      name: String,
      value: MixedTypes
      category: String
    )
  end
end

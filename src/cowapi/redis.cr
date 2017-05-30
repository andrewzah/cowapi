module Cowapi
  # namespace for app + namespace for regions / platforms
  def self.make_key(battleTag, region, platform)
    "cowapi:#{battleTag}/#{region}/#{platform}"
  end

  # Store for 1 hour (3600s)
  def self.cache_page(battleTag, region, platform, page)
    key = make_key(battleTag, region, platform)
    REDIS.setex(key, 3600, page)
  end

  # if it's already stored don't re-store it
  def self.get_cached_page(battleTag, region, platform)
    key = make_key(battleTag, region, platform)
    REDIS.get(key)
  end
end

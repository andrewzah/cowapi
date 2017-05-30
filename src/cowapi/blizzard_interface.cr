module Cowapi
  # example real url
  # https://playoverwatch.com/en-us/career/pc/us/Dad-12262
  BASE_URL="https://playoverwatch.com/en-us/"
  PAGE_URL = BASE_URL + "career/"
  # HEROES_URL = BASE_URL + "heroes"

  AVAILABLE_REGIONS = ["/us", "/eu", "kr"]

  def self.build_url(battleTag, region, platform) : String
    url = String.build do |url|
     url << PAGE_URL
     url << platform + "/"
     url << region + "/"
     url << battleTag
    end
  end

  def self.get_page_body(url : String) : HTTP::Client::Response
    response = HTTP::Client.get(url)
  end

  def self.fetch_profile(battleTag : String, region : String, platform : String)
    url = build_url(battleTag, region, platform)

    if store = get_cached_page(battleTag, region, platform)
      LOG.info("Getting cached page for #{battleTag}")
      return 200, store
    else
      LOG.info(url)
      response = get_page_body(url)
      cache_page(battleTag, region, platform, response.body)
      return response.status_code, response.body
    end
  end
end



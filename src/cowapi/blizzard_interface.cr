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
  # example real url
  # https://playoverwatch.com/en-us/career/pc/us/Dad-12262
  BASE_URL = "https://playoverwatch.com/en-us/"
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

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

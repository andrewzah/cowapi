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

require "json"
require "xml"
require "logger"
require "http/client"

require "kemal"
require "redis"

require "./cowapi/logger.cr"
require "./cowapi/data"
require "./cowapi/blizzard_interface.cr"
require "./cowapi/util"
require "./cowapi/mappings"
require "./cowapi/redis"
require "./cowapi/middlewares"
require "./cowapi/parser"
require "./cowapi/routes"

module Cowapi
  CONFIG = CowapiConfig.from_json(File.read("config.json"))
  REDIS = ::Redis.new(CONFIG.redis_host, CONFIG.redis_port)
  Kemal.run(CONFIG.port)
end

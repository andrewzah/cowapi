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
  REDIS = ::Redis.new
  Kemal.run
end

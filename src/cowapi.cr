require "json"
require "xml"
require "logger"

require "kemal"
require "redis"

require "./cowapi/mappings"
require "./cowapi/middlewares"
require "./cowapi/logger.cr"
require "./cowapi/blizzard_interface.cr"
require "./cowapi/data"
require "./cowapi/util"
require "./cowapi/parser"
require "./cowapi/routes"

module Cowapi
  REDIS = ::Redis.new
  Kemal.run
end

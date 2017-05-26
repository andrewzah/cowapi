module Cowapi
  class JsonHandler < Kemal::Handler
    # This sets all responses to be JSON, removing repetition
    # in routes.cr endpoints
    def call(env)
      env.response.headers["Content-Type"] = "application/json"

      call_next(env)
    end
  end

  add_handler(JsonHandler.new)

  class ParamsHandler < Kemal::Handler
    # This simplifies code that would otherwise be repeated
    # in routes.cr endpoints
    def call(env)
      LOG.debug("Running Params Handler")

      env.set("region", env.params.query["region"]? || "us")
      env.set("platform", env.params.query["platform"]? || "pc")

      case env.params.query["mode"]?
      when "quickplay"
        mode = "quickplay"
      when "competitive"
        mode = "competitive"
      else
        mode = "both"
      end

      env.set("mode", mode)

      call_next(env)
    end
  end

  add_handler(ParamsHandler.new)
end

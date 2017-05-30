# These middlewares are for reducing repetition in routes.cr
# and handling stuff that happens on most requests (redis/ratelimit/xml)
module Cowapi
  DATA_ROUTES = ["/api/u/:battleTag", "/api/u/:battleTag/heroes", "/api/u/:battleTag/heroes/:hero"]
  HERO_ROUTES = DATA_ROUTES[-1..-1]

  class JsonHandler < Kemal::Handler
    def call(env)
      LOG.debug("[Middleware] Running JSON Handler.")
      env.response.headers["Content-Type"] = "application/json"
      call_next(env)
    end
  end
  add_handler(JsonHandler.new)

  class BattleTagHandler < Kemal::Handler
    only DATA_ROUTES

    def call(env)
      LOG.debug("[Middleware] Running BattleTag Handler.")
      return call_next(env) unless only_match?(env)
      env.set("battleTag", env.params.url["battleTag"])
      call_next(env)
    end
  end
  add_handler BattleTagHandler.new

  class ParamsHandler < Kemal::Handler
    only DATA_ROUTES
    exclude HERO_ROUTES

    def call(env)
      return call_next(env) unless only_match?(env)
      LOG.debug("[Middleware] Running Params Handler")

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

      hero = env.params.url["hero"] if exclude_match?(env)
      call_next(env)
    end
  end
  add_handler(ParamsHandler.new)

  class DataFetcher < Kemal::Handler
    only DATA_ROUTES 

    def call(env)
      LOG.debug("[Middleware] Running Data Fetcher")
      return call_next(env) unless only_match?(env)

      statusCode, data = Cowapi.fetch_profile(
        env.get("battleTag").to_s,
        env.get("region").to_s,
        env.get("platform").to_s
      )
      return Cowapi.jsonify_error("User profile not found. Did you set the region and platform?") unless statusCode == 200

      env.set("data", data)
      
      LOG.debug("[Middlewares] All handlers have completed running.")

      call_next(env)
    end
  end
  add_handler(DataFetcher.new)
end

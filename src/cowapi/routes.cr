module Cowapi
  get "/" do |env|
    {
      author: "Andrew Zah",
      github: "https://github.com/azah/cowapi",
      twitter: "@andrew_zah"
    }.to_json
  end

  get "/api/u/:battleTag" do |env|
    battleTag = env.params.url["battleTag"]

    statusCode, data = fetch_profile(battleTag, env.get("region").to_s, env.get("platform").to_s)
    next jsonify_error("User profile not found. Did you set the region and platform?") unless statusCode == 200

    parse_profile(data, env.get("mode"))
  end

  get "/api/u/:battleTag/heroes" do |env|
    battleTag = env.params.url["battleTag"]
    
    statusCode, data = fetch_profile(battleTag, env.get("region").to_s, env.get("platform").to_s)
    next jsonify_error("User profile not found. Did you set the region and platform?") unless statusCode == 200
    
    parse_heroes(HERO_DIV_IDS, data, env.get("mode"))
  end

  get "/api/u/:battleTag/heroes/:hero" do |env|
    battleTag = env.params.url["battleTag"]

    heroParamsCount, heroes = split_hero_params(env.params.url["hero"]) # allow lucio+reaper
    next jsonify_error("One or more hero names not found! Double check your spelling.") unless heroes.size == heroParamsCount

    statusCode, data = fetch_profile(battleTag, env.get("region").to_s, env.get("platform").to_s)
    next jsonify_error("User profile not found. Did you set the region and platform?") unless statusCode == 200

    parse_heroes(heroes, data, env.get("mode"))
  end

  error 404 do |env|
    env.response.status_code = 404
    jsonify_error("404 Page Not Found.")
  end
end

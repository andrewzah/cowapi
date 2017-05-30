module Cowapi
  get "/" do |env|
    {
      "author": "Andrew Zah",
      "twitter": "twitter.com/andrew_zah",
      "discord": "https://Andrei#8263",
      "github": "https://github.com/azah/cowapi",
      "error_reporting": "https://github.com/azah/cowapi/issues",
    }.to_json
  end

  get "/api/u/:battleTag" do |env|
    parsed = XML.parse_html(env.get("data").as(String))
    parse_profile(parsed, env.get("mode")).to_json
  end

  get "/api/u/:battleTag/heroes" do |env|
    parsed = XML.parse_html(env.get("data").as(String))
    parse_heroes(parsed, env.get("mode")).to_json
  end

  get "/api/u/:battleTag/heroes/:hero" do |env|
    heroParamsCount, heroes = Cowapi.split_hero_params(env.params.url["hero"])
    next jsonify_error("One or more hero names not found! Check your spelling.") unless heroes.size == heroParamsCount

    parsed = XML.parse_html(env.get("data").as(String))
    if heroes.size == 1
      parse_hero(parsed, heroes.first_value, heroes.first_key, env.get("mode")).to_json
    else
      parse_heroes(parsed, env.get("mode"), heroes).to_json
    end
  end

  error 404 do |env|
    env.response.status_code = 404
    jsonify_error("404 Page Not Found.")
  end
end

# cowapi

This is a Crystal implementation of [OWAPI](https://github.com/SunDwarf/OWAPI).

It utilizes the [Kemal](http://kemalcr.com/) framework & [Redis](https://redis.io/) for caching.

## Roadmap
See [the Roadmap](roadmap.md)

## Using the API
### URL Parameters
#### Region & Platform
By default, the region is `us` and platform is `pc`.  
You can set these with `region` and `platform` parameters, respectively.
```
https://apis.andrewzah.com/cowapi/v1/u/Dad-12262/heroes/lucio?region=eu&platform=xbox
```

Currently you cannot specify multiple regions/platforms in 1 request. That feature is on the roadmap.

#### Mode: Comp, Quickplay, or Both
By default, cowapi will return both competitive & quickplay stats.  
However you can specify one or the other via the `mode` parameter:
```
https://apis.andrewzah.com/cowapi/v1/u/Dad-12262/heroes?mode=competitive
```

### Heroes/Hero
```
https://apis.andrewzah.com/cowapi/v1/u/:battleTag/heroes/:hero
```
```
https://apis.andrewzah.com/cowapi/v1/u/Dad-12262/heroes/lucio
```
**Singular Hero Request**
```json
{
	"name": "lucio",
	"quickplay": [
		{
		"name": "sound_barriers_provided",
		"value": 65,
		"category": "hero_specific"
		},
		{
		"name": "sound_barriers_provided_most_in_game",
		"value": 15,
		"category": "hero_specific"
		},
		{ ... }
	],
	"comp": [ ... ]
}
```
### Heroes/Hero+Hero
Multiple heroes can be specified! 
```
https://apis.andrewzah.com/cowapi/v1/u/:battleTag/heroes/:hero1+:hero2+:heroN
```
```
https://apis.andrewzah.com/cowapi/v1/u/Dad-12262/heroes/lucio+pharah
```
**Multiple Heroes Request**:
```json
[
	{
		"name": "lucio",
		"quickplay": [
			{
			"name": "sound_barriers_provided",
			"value": 65,
			"category": "hero_specific"
			},
			{
			"name": "sound_barriers_provided_most_in_game",
			"value": 15,
			"category": "hero_specific"
			},
			{ ... }
		],
		"comp": [ ... ]
	},
	{
		"name": "pharah",
		"quickplay": [
			{
			"name": "rocket_direct_hits",
			"value": 2598,
			"category": "hero_specific"
			},
			{
			"name": "barrage_kills",
			"value": 169,
			"category": "hero_specific"
			},
			{ ... }
		],
		"comp": [ ... ]
	},
]
```

### Heroes
The same as Heroes/Hero+Hero, but with all heroes + **total**.
```
https://apis.andrewzah.com/cowapi/v1/u/:battleTag/heroes
```
```
https://apis.andrewzah.com/cowapi/v1/u/Dad-12262/heroes
```

### Profile
Miscellaneous Profile Info + the same reponse as Heroes.
```
https://apis.andrewzah.com/cowapi/v1/u/:battleTag/heroes
```
```
https://apis.andrewzah.com/cowapi/v1/u/Dad-12262/heroes
```
**Profile result**: Comp stats will only return if they have values. 
```json
{
	"profile": {
		"avatar": "https://blzgdapipro-a.akamaihd.net/game/unlocks/0x0250000000000776.png",
		"name": "Dad",
		"player_level": 288,
		"border_portrait": "https://blzgdapipro-a.akamaihd.net/game/playerlevelrewards/0x025000000000092A_Border.png",
		"comp_rank": 2288,
		"tier_portrait": "https://blzgdapipro-a.akamaihd.net/game/rank-icons/season-2/rank-4.png",
		"tier": "Platinum",
		"games_won": 662
	},
	"heroes": [ ... ]
}
```

## Installation for Self Hosting

Clone this repo. Run `crystal make --release src/cowapi.cr` to build it.

## Usage for Self Hosting

Simply run `./cowapi` to run the server. To use a port other than 3000, use the `--port` flag.

cowapi doesn't have inbuilt rate-limiting, so I recommend using nginx's rate limiting.

## Contributing

Submitting issues with ideas for features is recommended! If you want to contribute with code:

1. Fork it ( https://github.com/azah/cowapi/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [your-github-name](https://github.com/azah) Andrew Zah - creator, maintainer

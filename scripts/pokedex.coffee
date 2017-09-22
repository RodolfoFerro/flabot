# Description:
#   Script that comsumes the Pokéapi to return Pokémon info.
#
# Author:
#   https://github.com/RodolfoFerro/

module.exports = (robot) ->

  robot.hear /tacos/i, (res) ->
    res.send "TACOS?! YAAAS! WHEN?! WHERE?! 🌮🌮🌮"

  robot.respond /pokedex (.*)/i, (res) ->
    pokemon = res.match[1]
    res.reply "Pokémon requested: #{pokemon}."
    robot.http("http://pokeapi.co/api/v2/pokemon/#{pokemon}")
      .get() (err, res, body) ->
        result = JSON.parse(body)
        if result.status == "success"
          res.reply "Alright!"
        else
          msres.reply "ERROR. :("

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

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
    # res.send "Requested Pokémon: #{pokemon.toLowerCase()}"
    res.http("http://pokeapi.co/api/v2/pokemon/#{pokemon.toLowerCase()}")
      .get() (err, msg, body) ->
        try
          res.send "HERE!"
          json = JSON.parse(body)
          res.send "   Pokémon: #{json.name}\n
            Height: #{json.height/10} meters\n
            Weight: #{json.weight/10} kilograms\n"
        catch err
          res.send "That might not be a Pokémon..."

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

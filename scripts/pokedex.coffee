# Description:
#   Script that comsumes the Pokéapi to return Pokémon info.
#
# Author:
#   https://github.com/RodolfoFerro/

module.exports = (robot) ->

  robot.hear /tacos/i, (res) ->
    res.send "TACOS?! YAAAS! WHEN?! WHERE?! 🌮🌮🌮"

  robot.respond /pokedex (.*)/i, (msg) ->
    pokemon = msg.match[1]
    # res.send "Requested Pokémon: #{pokemon.toLowerCase()}"
    msg.http("http://pokeapi.co/api/v2/pokemon/#{pokemon.toLowerCase()}")
      .get() (err, res, body) ->
        try
          msg.send "HERE!"
          json = JSON.parse(body)
          msg.send "   Pokémon: #{json.name}\n
     Height: #{json.height/10} meters\n
     Weight: #{json.weight/10} kilograms\n"
        catch error
          msg.send "That might not be a Pokémon..."

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

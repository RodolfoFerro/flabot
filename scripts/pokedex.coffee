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
    res.http("https://pokeapi.co/api/v2/pokemon/#{pokemon.toLowerCase()}")
      .get() (err, msg, body) ->
        res.send "#{msg.statusCode}"
        switch msg.statusCode
          when 200
            info = JSON.parse(body)
            res.send "#{info}"
            res.send "Pokémon: #{info.name}\nHeight: #{info.height/10} meters\nWeight: #{info.weight/10} kilograms\n"
          else
            res.send "That might not be a Pokémon..."

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

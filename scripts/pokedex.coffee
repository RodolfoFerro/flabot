# Description:
#   Script that comsumes the Pokéapi to return Pokémon info.
#
# Commands:
#   hubot pokedex <pokemon> - Looks for that Pokémon's info.
#   hubot pokedex <id> - Looks for that Pokémon's info.
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   RodolfoFerro

module.exports = (robot) ->

  robot.hear /tacos/i, (res) ->
    res.send "TACOS?! YAAAS! WHEN?! WHERE?! 🌮🌮🌮"

  robot.respond /pokedex (.*)/i, (res) ->
    pokemon = res.match[1]
    res.send "Pokerequest: #{pokemon.toLowerCase()}"
    robot.http("https://pokeapi.co/api/v2/pokemon/#{pokemon.toLowerCase()}/")
      .get() (err, msg, body) ->
        res.send "#{err}"
        res.send "#{msg.statusCode}"
        switch msg.statusCode
          when 200
            info = JSON.parse(body)
            res.send "Pokémon: #{info.name}\nHeight: #{info.height/10} meters\nWeight: #{info.weight/10} kilograms\nImage: #{info.forms[0].url}\n"
            # ['sprites']['front_default']
          else
            res.send "That might not be a Pokémon..."

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

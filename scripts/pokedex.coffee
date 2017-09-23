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
    robot.http("https://pokeapi.co/api/v2/pokemon/#{pokemon.toLowerCase()}/")
      .get() (err, msg, body) ->
        switch msg.statusCode
          when 200
            info = JSON.parse(body)
            robot.http("#{info.forms[0].url}")
              .get() (err2, msg2, body2) ->
                switch msg.statusCode
                  when 200
                    img_var = JSON.parse(body2)
                    img = img_var.sprites.front_default
                  else
                    img = "Image not available by now. Sorry! :("
                res.send "Pokémon: #{info.name}\nHeight: #{info.height/10} meters\nWeight: #{info.weight/10} kilograms\nImage: #{img}\n"
          else
            res.send "That might not be a Pokémon..."

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

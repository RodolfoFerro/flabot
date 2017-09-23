# Description:
#   Script that comsumes the Pokéapi to return Pokémon info.
#
# Commands:
#   hubot pokedex <pokemon> - Looks for that Pokémon's info.
#   hubot pokedex <id> - Looks for that Pokémon's info.
#   hubot repos <user> - Lists all repos from a user.
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   RodolfoFerro

module.exports = (robot) ->

  # Function that activates whenever somebody mentions the word "tacos"
  robot.hear /tacos/i, (res) ->
    res.send "TACOS?! YAAAS! WHEN?! WHERE?! 🌮🌮🌮"

  # Function that activates when you mention yout bot, it consumes
  # the Pokeapi looking for Pokémon's info
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
            res.send "That might not be a Pokémon... "

  # Function that activates when you mention yout bot, it lists
  # the Github's repos from a user
  robot.respond /repos (.*)/i, (res) ->
    gh_user = res.match[1]
    robot.http("https://api.github.com/users/#{gh_user}/repos")
      .get() (err, msg, body) ->
        switch msg.statusCode
          when 200
            info = JSON.parse(body)
            res.send "Number of public repos: #{Object.keys(info).length}\nWanna list them all? (y/n)"
            robot.respond /(.*)/i, (res2) ->
              ans = res2.match[1]
            res.send "You answered #{ans.toLowerCase()}."
            if ans.toLowerCase() is "yes" or ans.toLowerCase() is "y"
              res2.send "Imma list them!"
            else if ans.toLowerCase() is "no" or ans.toLowerCase() is "n"
              res2.send "Okay!"
            else
              res2.send "Sorry, I didn't understand that answer. Please try again."
          else
            res.send "Couldn't find a thing. Did you spell correctly that username? 🤔"

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

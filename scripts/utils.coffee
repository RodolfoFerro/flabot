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

  # Function that activates whenever somebody mentions the word "xkcd"
  # robot.hear /xkcd/i, (res) ->
  #   robot.http("https://xkcd.com/info.0.json")
  #     .get() (err, msg, body) ->
  #       switch msg.statusCode
  #         when 200
  #           info = JSON.parse(body)
  #           res.send "Title: #{info.title}\nDescription: #{info.alt}\nImage: #{info.img}"
  #         else
  #           res.send "There was an error with xkcd. Try again later?"

  # Function that activates when you mention the bot, it consumes
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

  # Function that activates when you mention the bot, it returns
  # the number of Github's repos from a user
  robot.respond /repos list (.*)/i, (res) ->
    gh_user = res.match[1]
    robot.http("https://api.github.com/users/#{gh_user}/repos")
      .get() (err, msg, body) ->
        switch msg.statusCode
          when 200
            info = JSON.parse(body)
            res.send "info.name"
            # for key in info
            #   res.send "#{info.key.toDict('name')}"
          else
            res.send "Couldn't find a thing. Did you spell correctly that username? 🤔"

  # Function that activates when you mention the bot, it returns
  # the number of Github's repos from a user
  robot.respond /repos (.*)/i, (res) ->
    gh_user = res.match[1]
    robot.http("https://api.github.com/users/#{gh_user}/repos")
      .get() (err, msg, body) ->
        switch msg.statusCode
          when 200
            info = JSON.parse(body)
            res.send "Number of public repos: #{Object.keys(info).length}"
          else
            res.send "Couldn't find a thing. Did you spell correctly that username? 🤔"

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

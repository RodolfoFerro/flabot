# Description:
#   Flabot's functionalities.
#
# Author:
#   https://github.com/RodolfoFerro/

module.exports = (robot) ->

  robot.hear /tacos/i, (res) ->
    res.send "¿TACOS? Sí, ¿cuándo y dónde? 🌮🌮🌮"

  robot.respond /dile a (.*) que es (.*)/i, (res) ->
    room = res.match[1]
    text = res.match[2]
    robot.messageRoom room, "Eres #{doorType}."

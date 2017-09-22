# Description:
#   Flabot's functionalities.
#
# Author:
#   https://github.com/RodolfoFerro/

module.exports = (robot) ->

  robot.hear /tacos/i, (res) ->
    res.send "¿TACOS? Sí, ¿cuándo y dónde? 🌮🌮🌮"

# Description:
#   Gives the current value of a crypto currency in USD
#
# Commands:
#   hubot crypto value <coin> - Returns value of coin in USD

module.exports = (robot) ->
  robot.respond /crypto value (.*)/i, (msg) ->
    msg.http("https://www.bitstamp.net/api/v2/ticker/#{msg.match[1]}usd").get() (err, res, body) ->
      json = JSON.parse(body)
      if json.last
        msg.send "Current Value: $#{json.last}"
      else
        msg.send "Didn't find your currency."
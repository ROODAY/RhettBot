# Description:
#   Gives the current value of a crypto currency in USD
#
# Commands:
#   hubot crypto value <coin> - Returns value of coin in USD

module.exports = (robot) ->
  robot.respond /crypto value (.*)/i, (res) ->
    res.http("https://www.bitstamp.net/api/v2/ticker/#{res.match[1]}usd").get() (error, response, body) ->
      if err
        res.reply "ERROR: #{err}"
      else
        json = JSON.parse(body)
        if json.last
          res.reply "Current Value: $#{json.last}"
        else
          res.reply "Didn't find your currency."
# Description:
#   Gives the current value of a crypto currency in USD
#
# Commands:
#   hubot crypto value <coin> - Returns value of coin in USD

module.exports = (robot) ->
  robot.respond /crypto value (.*)/i, (res) ->
    res.http("https://www.bitstamp.net/api/v2/ticker/#{res.match[1]}usd").get() (error, response, body) ->
      if error
        res.reply "ERROR: #{error}"
      else
        try
          json = JSON.parse(body)
          if json.last
            res.reply "Current Value: $#{json.last}"
          else
            res.reply "Didn't find your currency."
        catch jsonError
          res.reply "Didn't find your currency."
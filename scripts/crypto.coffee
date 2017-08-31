# Description:
#   Gives the current value of a crypto currency in the desired currency
#   EX: LTC/USD would give us the current usd value of litecoin
#
# Commands:
#   hubot crypto value <coin/fiat>  - Returns a string stating the value of the currency wanted
#
# Author: jonwjones 

module.exports = (robot) ->
  robot.respond /crypto value (\w+)/i, (msg) ->
		msg = msg.toUpperCase()
    dividend = msg.match[1].split('/')[0]
    divisor = msg.match[1].split('/')[1]
    
    msg.http('http://api.bitcoincharts.com/v1/weighted_prices.json').get() (err, res, body) ->
      json = JSON.parse(body)
      if json[dividend] and json[divisor]
        msg.send "#{dividend} / #{divisor} #{json[dividend]['24h'] / json[divisor]['24h']}"
      else
        msg.send "Didn't find your currency."


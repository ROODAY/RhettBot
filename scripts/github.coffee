# Description:
#   Show open issues from a Github repository
#
# Commands:
#   hubot issues <user/repo> - Shows open issues for the specified repository.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /issues (.*)/i, (res) ->
    github.handleErrors (response) ->
      res.reply "ERROR: #{response.error}"

    repo = res.match[1].split("/")[1]

    if !repo
      repo = res.match[1].split("/")[0]
      user = process.env.HUBOT_GITHUB_USER 
    else
      user = res.match[1].split("/")[0]

    res.reply("#{user}/#{repo}")

    query_params = state: "open", sort: "created"
    query_params.per_page=100

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    github.get "#{base_url}/repos/#{user}/#{repo}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          labels = ("`##{label.name}`" for label in issue.labels).join(" ")
          res.reply "> [`#{issue.number}`] *#{issue.title} #{labels}* #{issue.html_url}"
      else
        res.reply "Congratulations! No open issues!"
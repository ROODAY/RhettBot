# Description:
#   Show open issues from a Github repository
#
# Commands:
#   hubot issues - Shows all issues to follow up.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /issues (.*)/i, (res) ->
    repo = res.match[1]

    query_params = state: "open", sort: "created"
    query_params.per_page=100

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{repo}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          labels = ("`##{label.name}`" for label in issue.labels).join(" ")
          res.reply "> [`#{issue.number}`] *#{issue.title} #{labels}* #{issue.html_url}"
      else
        res.reply "Congratulations! No open issues!"
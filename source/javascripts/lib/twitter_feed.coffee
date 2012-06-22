# Depends on jQuery, jQuery.timeago and underscore

class TwitterFeed

  apiURL     = 'http://api.twitter.com/1'
  tweetsTmpl = """
    <ul>
      <% _.each(tweets, function(tweet) { %>
        <li>
          <%= tweet.text %>
          <a href="<%= 'https://twitter.com/' + tweet.user.name + '/status/' + tweet.id_str %>" title="View on Twitter">
            <%= $.timeago(tweet.created_at) %>
          </a>
        </li>
      <% }); %>
    </ul>
  """
  errorTmpl  = '<p class="failed">Tweets could not be loaded.</p>'

  constructor: (user, el) ->
    @user = user
    @$el  = $(el)
    @fetch()

  fetch: ->
    $.ajax
      url     : @_userTimelineURL()
      dataType: 'jsonp'
      success : @_renderTweets
      error   : @_renderError

  #

  _renderTweets: (tweets) =>
    @$el.html _.template(tweetsTmpl, tweets: tweets)

  _renderError: =>
    @$el.html errorTmpl

  _userTimelineURL: ->
    "#{apiURL}/statuses/user_timeline.json?screen_name=#{@user}"


window['TwitterFeed'] = TwitterFeed

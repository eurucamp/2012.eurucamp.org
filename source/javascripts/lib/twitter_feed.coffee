# Depends on jQuery, jQuery.timeago and underscore

class TwitterFeed

  apiURL     = 'http://api.twitter.com/1'
  tweetsTmpl = """
    <ul>
      <% _.each(tweets, function(tweet) { %>
        <li>
          <span><%= tweet.text %></span>
          <a href="<%= 'https://twitter.com/' + user + '/status/' + tweet.id_str %>" title="View on Twitter">
            &mdash;<%= $.timeago(tweet.created_at) %>
          </a>
        </li>
      <% }); %>
    </ul>
    <p class="more">
      <a href="https://twitter.com/<%= user %>" title="View on twitter">More tweets on Twitter</a>
    </p>
  """
  errorTmpl  = '<p class="failed">Tweets could not be loaded.</p>'

  constructor: (user, el) ->
    @user  = user
    @$el   = $(el)
    @count = 5
    @fetch()

  fetch: ->
    $.ajax
      url     : @_userTimelineURL()
      dataType: 'jsonp'
      success : @_renderTweets
      error   : @_renderError

  #

  _renderTweets: (tweets) =>
    data =
      tweets: _.map(tweets, (tweet) =>
        tweet.text = @_parseTweet(tweet.text)
        tweet)
      user: @user
    @$el.html _.template(tweetsTmpl, data)

  _renderError: =>
    @$el.html errorTmpl

  _userTimelineURL: ->
    "#{apiURL}/statuses/user_timeline.json?screen_name=#{@user}&count=#{@count}&include_rts=1"

  _findAndConvertUsers: (tweet) ->
    tweet.replace(/(^|\s)@(\w+)/g, "$1@<a href=\"https://www.twitter.com/$2\">$2</a>")

  _findAndConvertHashTags: (tweet) ->
    tweet.replace(/(^|\s)#(\w+)/g, "$1#<a href=\"https://search.twitter.com/search?q=%23$2\">$2</a>")

  _findAndConvertLinks: (tweet) ->
    url_pattern = /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig
    tweet.replace url_pattern, "<a href='$1'>$1</a>"

  _parseTweet: (tweet) ->
    tweet = @_findAndConvertLinks(tweet)
    tweet = @_findAndConvertUsers(tweet)
    tweet = @_findAndConvertHashTags(tweet)
    tweet


window['TwitterFeed'] = TwitterFeed

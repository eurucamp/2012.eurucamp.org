BG_OPTIONS =
  centeredX: true
  centeredY: true
  speed    : 500

BG_PATH = '/images/layout/background.jpg'

$ ->

  # if no theme cookie is set, select by time of day
  if !$.cookie('theme') && ((time = (new Date).getHours()) > 18 || time < 6)
     setTheme 'night'
  else
    setTheme($.cookie 'theme')

  # Responsive images
  $('img.resp').responsiveImages()

  # Twitter
  if $('body').hasClass 'index'
    new TwitterFeed 'eurucamp', $('.twitter-feed .tweets')

  # Theme toggle
  $('a.theme-toggle').on 'click', ->
    setTheme()
    false

  # Random speakers video on home page
  if $('body').hasClass 'index'
    randomID = _.first(_.shuffle(SPEAKER_VIDEO_IDS))
    $video   = $ '<div />',
      class: 'resp-video-wrapper'
      html: SPEAKER_VIDEO_TEMPLATE.replace('[VIDEO_ID]', randomID)
    $('section.speakers ul').before($video)

  # Sticky speakers nav
  if $('body').hasClass 'speakers'
    $window       = $(window)
    $article      = $('article')
    $aside        = $article.find('aside')
    $nav          = $aside.find('nav')
    threshold     = null
    articleOffset = null

    # make sure that the nav is always visible while scrolling
    positionSpeakersNav = ->
      threshold     ||= $aside.offset().top
      articleOffset ||= $article.offset().top + $article.height()
      scrollTop       = $window.scrollTop()
      windowHeight    = $window.height()
      $aside.toggleClass('fixed', scrollTop > threshold)
      if (articleBottom = articleOffset - scrollTop) < windowHeight
        $nav.css('bottom': "#{windowHeight - articleBottom}px")
      else
        $nav.css('bottom': '')


    positionSpeakersNavDelayed = _.throttle(positionSpeakersNav, 100)
    $window.on('scroll', positionSpeakersNavDelayed)

    setTimeout positionSpeakersNav, 500

    # highlight the current speaker
    $window.hashchange ->
      $aside
        .find('li.active')
        .removeClass('active')
        .end()
        .find("a[href='#{window.location.hash}']")
        .parent('li')
        .addClass('active')
    $window.hashchange()


  # Map
  if $('body').hasClass 'venue'
    hotelLocation = new google.maps.LatLng(52.4263816315, 13.6408942908)
    options =
      center          : hotelLocation
      zoom            : 15
      mapTypeId       : google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
    map = new google.maps.Map $('section.map').get(0), options

    icon   = '/images/layout/venue/marker.png'
    size   = new google.maps.Size(37, 37)
    origin = new google.maps.Point(0, 0)
    anchor = new google.maps.Point(11, 36)
    image  = new google.maps.MarkerImage icon, size, origin, anchor

    new google.maps.Marker
      position: hotelLocation
      map     : map
      icon    : image


  # ----------------------------------------------------------------------------
  # development
  if /\?dev/.test window.location.search
    $size = $('<div />').appendTo('body')
    $size.css
      position: 'fixed'
      background: 'rgba(0,0,0,0.9)'
      bottom: 0
      right: 0
      padding: '0.25em'
      color: 'white'

    $(window)
      .on('resize', -> $size.text $(window).width())
      .trigger('resize')

    $('a:not(.theme-toggle)').on 'click', ->
      href = $(@).attr 'href'
      if href == '/' || /\.html?/.test(href)
        window.location = "#{href}?dev"
      else if /^#/.test(href)
        window.location.hash = href
      else if !/^http/.test(href)
        window.location = "#{href}.html?dev"
      false

toggleBGImage = ->
  if Modernizr.mq('only all')
    if $(@).width() > 1024
      $.backstretch BG_PATH, BG_OPTIONS
    else
      $.backstretch 'destroy'

window.setTheme = (theme) ->
  current = $.cookie 'theme'
  if !theme
    theme = if current == 'day' then 'night' else 'day'
  if theme in ['day', true]
    $('html').removeClass('night')
    $(window)
      .on('resize.bgimage', _.debounce(toggleBGImage, 500))
      .trigger('resize')
  else
    $('html').addClass('night')
    $(window).off 'resize.bgimage'
    $.backstretch 'destroy'
  $.cookie 'theme', theme

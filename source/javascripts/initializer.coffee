$ ->

  setTheme($.cookie 'theme')

  # Responsive images
  $('img.resp').responsiveImages()

  # BG image
  $.backstretch '/images/layout/background.jpg'

  # Twitter
  if $('body').hasClass 'index'
    new TwitterFeed 'eurucamp', $('.twitter-feed .tweets')

  # Theme toggle
  $('a.theme-toggle').on 'click', -> setTheme()

  # Map
  if $('body').hasClass 'venue'
    address = 'Mügglheimer Damm 145, 12559 Berlin'

    geocoder = new google.maps.Geocoder()
    geocoder.geocode 'address': address, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        hotelLocation = results[0].geometry.location
        options =
          center          : hotelLocation
          zoom            : 12
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
      if href == '/'
        window.location = "#{href}?dev"
        false
      else if !/^http/.test href
        window.location = "#{href}.html?dev"
        false


window.setTheme = (theme) ->
  current = $.cookie 'theme'
  if !theme
    theme = if current == 'day' then 'night' else 'day'
  if theme in ['day', true]
    $('html').removeClass('night')
  else
    $('html').addClass('night')
  $.cookie 'theme', theme

$ ->

  # Responsive images
  $('img.resp').responsiveImages()

  # Twitter
  if $('body').hasClass 'index'
    new TwitterFeed 'eurucamp', $('.twitter-feed > div')


  # ----------------------------------------------------------------------------
  # development
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

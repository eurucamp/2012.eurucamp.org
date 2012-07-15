# Depends on jQuery, underscore, colorthief and quantize

class TrixelArt

  # 0 = black, 1 = white
  PATTERN = [
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0
    1, 1, 1, 1, 0, 0, 1, 1, 1, 1
    1, 1, 1, 0, 0, 0, 0, 1, 1, 1
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    1, 1, 1, 0, 0, 0, 0, 0, 0, 0
    1, 1, 1, 1, 0, 0, 1, 1, 1, 0
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0
  ]
  PALLETTE_WIDTH = 15

  constructor: (elements) ->
    $(elements).each (index, element) ->
      $element = $(@)

      palette  = createPalette(@, PALLETTE_WIDTH).sort(_byBrightness)
      color    = if !!PATTERN[index] then _.last(palette) else _.first(palette)

      $pixel = $('<div />', class: 'pixel')
        .css('backgroundColor', _color2String(color))
        .insertBefore($element)

  #

  _color2String = (color) ->
    "rgb(#{color[0]}, #{color[1]}, #{color[2]})"

  _RGB2Brightness = (r, g, b) ->
    r /= 255
    g /= 255
    b /= 255
    max = Math.max(r, g, b)
    min = Math.min(r, g, b)
    Math.floor((max + min) / 2 * 100)

  _byBrightness = (a, b) ->
    l1 = _RGB2Brightness(a[0], a[1], a[2])
    l2 = _RGB2Brightness(b[0], b[1], b[2])
    l1 - l2


window['TrixelArt'] = TrixelArt

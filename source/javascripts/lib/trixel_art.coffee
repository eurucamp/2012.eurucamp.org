# Depends on jQuery, underscore, colorthief and quantize

class Trixel

  PALLETTE_WIDTH = 15

  constructor: (type, $el) ->
    @image   = $el.get(0)
    @width   = $el.width()
    @height  = $el.height()
    @$canvas = $('<canvas />')
      .attr
        width: @width
        height: @height
      .insertBefore($el)
    @context = @$canvas.get(0).getContext('2d')

    mainColors     = createPalette(@image, PALLETTE_WIDTH).sort(_byBrightness)
    darkestColor   = _.first(mainColors)
    brightestColor = _.last(mainColors)

    switch type
      when 0
        @_drawRectangle(darkestColor)
      when 1
        @_drawRectangle(brightestColor)
      when 2
        @_drawAscendingTriangles(brightestColor, darkestColor)
      when 3
        @_drawAscendingTriangles(darkestColor, brightestColor)
      when 4
        @_drawDescendingTriangles(brightestColor, darkestColor)
      when 5
        @_drawDescendingTriangles(darkestColor, brightestColor)

  #

  _drawRectangle: (color) ->
    @_setFillStyle(color)
    @context.fillRect(0, 0, @width, @height)

  _drawAscendingTriangles: (upperColor, lowerColor) ->
    upperPoints = [
      { x: 0,      y: 0       }
      { x: @width, y: 0       }
      { x: 0,      y: @height }
    ]
    @_drawTriangle(upperPoints, upperColor)

    lowerPoints = [
      { x: 0,      y: @height }
      { x: @width, y: 0       }
      { x: @width, y: @height }
    ]
    @_drawTriangle(lowerPoints, lowerColor)


  _drawDescendingTriangles: (upperColor, lowerColor) ->
    upperPoints = [
      { x: 0,      y: 0       }
      { x: @width, y: 0       }
      { x: @width, y: @height }
    ]
    @_drawTriangle(upperPoints, upperColor)

    lowerPoints = [
      { x: 0,      y: 0       }
      { x: @width, y: @height }
      { x: 0,      y: @height }
    ]
    @_drawTriangle(lowerPoints, lowerColor)


  _drawTriangle: (points, color) ->
    @_setFillStyle(color)
    @context.beginPath()
    @context.moveTo(points[0].x, points[0].y)
    @context.lineTo(points[1].x, points[1].y)
    @context.lineTo(points[2].x, points[2].y)
    @context.lineTo(points[0].x, points[0].y)
    @context.fill()


  _setFillStyle: (color) ->
    @context.fillStyle = "rgb(#{color[0]}, #{color[1]}, #{color[2]})"

  #

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


class TrixelArt

  # 0 = black
  # 1 = white
  # 2 = ascending, lower dark
  # 3 = ascending, upper dark
  # 4 = descending, lower dark
  # 5 = descending, upper dark
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

  constructor: (elements) ->
    $(elements).each (index, element) ->
      new Trixel PATTERN[index] || 0, $(element)


window['TrixelArt'] = TrixelArt

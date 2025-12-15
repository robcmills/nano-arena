local g = require('g')
local draw_canvas = require('draw/draw_canvas')
local draw_map = require('draw/draw_map')

function love.draw()
  love.graphics.setCanvas(g.canvas)
  love.graphics.clear()
  draw_map()
  love.graphics.setBlendMode('alpha')
  love.graphics.setCanvas()
  love.graphics.clear(0, 0, 0)
  draw_canvas()
end

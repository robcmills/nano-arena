local draw_editor = require('draw/draw_editor')
local g = require('g')

function love.draw()
  love.graphics.setCanvas(g.canvas)
  love.graphics.clear()
  love.graphics.setBlendMode('replace')
  draw_editor()
  love.graphics.setBlendMode('alpha')
  love.graphics.setCanvas()
  love.graphics.clear(0, 0, 0)
  love.graphics.draw(g.canvas, 0, 0, 0, g.scale_x, g.scale_y)
end

local draw_editor = require('draw/draw_editor')
local g = require('g')

function love.draw()
  -- draw game to canvas
  love.graphics.setCanvas(g.canvas)
  love.graphics.clear()
  -- disable blending to prevent overlap artifacts
  love.graphics.setBlendMode('replace')
  -- drawing code here
  draw_editor()
  -- restore default blend mode and color
  love.graphics.setBlendMode('alpha')
  -- reset canvas
  love.graphics.setCanvas()
  -- clear with black bars
  love.graphics.clear(0, 0, 0)
  -- draw canvas scaled and centered
  love.graphics.draw(g.canvas, g.offset_x, g.offset_y, 0, g.scale, g.scale)
end

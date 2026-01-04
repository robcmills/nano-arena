local g = require('g')
local draw_canvas = require('draw/draw_canvas')
local draw_debug = require('draw/draw_debug')
local draw_editor = require('editor/draw_editor')
local draw_game = require('draw/draw_game')
local test = require('test')

function love.draw()
  love.graphics.setCanvas(g.canvas)
  love.graphics.clear()
  if g.state == 'game' then
    draw_game()
  elseif g.state == 'editor' then
    draw_editor()
  end
  if g.debug then
    draw_debug()
  end
  love.graphics.setBlendMode('alpha')
  love.graphics.setCanvas()
  love.graphics.clear(0, 0, 0)
  draw_canvas()
  if g.is_test then test:update_post() end
end

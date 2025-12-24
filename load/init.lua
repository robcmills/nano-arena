local g = require('g')
local load_canvas = require('load/load_canvas')
local load_editor = require('load/load_editor')
local load_fonts = require('load/load_fonts')
local load_game = require('load/load_game')

function love.load()
  love.window.setMode(0, 0, { fullscreen = true })
  love.keyboard.setKeyRepeat(true)
  love.mouse.setVisible(false)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  load_canvas()
  load_fonts()
  if g.state == 'game' then
    load_game()
  elseif g.state == 'editor' then
    load_editor()
  end
end

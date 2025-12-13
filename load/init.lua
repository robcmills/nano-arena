local g = require('g')
local load_canvas = require('load/load_canvas')
-- local load_editor = require('load/load_editor')
local load_fonts = require('load/load_fonts')
local load_game = require('load/load_game')

-- Draw canvas scaled to fill the window
local function update_scale()
  local window_width, window_height = love.graphics.getDimensions()
  g.scale_x = window_width / g.canvas:getWidth()
  g.scale_y = window_height / g.canvas:getHeight()
end

function love.load()
  love.keyboard.setKeyRepeat(true)
  love.mouse.setVisible(false)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  load_canvas()
  load_game()
  load_fonts()
  -- load_editor()
  love.window.setMode(0, 0)
  update_scale()
end

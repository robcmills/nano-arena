local g = require('g')
local load_editor = require('load/load_editor')
local load_fonts = require('load/load_fonts')
local load_game = require('load/load_game')
local settings = require('settings')

local function update_scale()
  local window_width, window_height = love.graphics.getDimensions()
  g.scale = math.floor(math.min(
    window_width / settings.resolution,
    window_height / settings.resolution
  ))
  -- Center the canvas in the window
  g.offset_x = (window_width - settings.resolution * g.scale) / 2
  g.offset_y = (window_height - settings.resolution * g.scale) / 2
end

function love.load()
  love.keyboard.setKeyRepeat(true)
  love.mouse.setVisible(false)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  load_game()
  load_fonts()
  load_editor()
  love.window.setMode(0, 0)
  update_scale()
end

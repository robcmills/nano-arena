local g = require('g')
local settings = require('settings')

local function load_initial_game_state()
  g.canvas = love.graphics.newCanvas(settings.resolution, settings.resolution)
end

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

local function load_font()
  g.font = love.graphics.newImageFont(
    'assets/monogram-font.png',
    ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!"#$%&\'()*+,-./:;<=>?[\\]^_{|}~`@'
  )
  g.font:setFilter('nearest', 'nearest')
  love.graphics.setFont(g.font)
end

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  load_font()
  load_initial_game_state()
  love.window.setMode(0, 0)
  update_scale()
end

local g = require('g')
local settings = require('settings')

local function load_initial_game_state()
  g.canvas = love.graphics.newCanvas(settings.resolution, settings.resolution)
  g.editor = {
    opened_menu = nil,
  }
  g.fonts = {}
  g.offset_x = 0
  g.offset_y = 0
  g.scale = 1
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

local function load_fonts()
  g.fonts = {}
  g.fonts.monogram = love.graphics.newImageFont(
    'assets/monogram-font.png',
    ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!"#$%&\'()*+,-./:;<=>?[\\]^_{|}~`@'
  )
  g.fonts.monogram:setFilter('nearest', 'nearest')
  g.fonts.p8 = love.graphics.newImageFont(
    'assets/pico8-font.png',
    ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,"\'?!@_*#$%()+-/:;<=>[\\]^{|}~'
  )
  g.fonts.p8:setFilter('nearest', 'nearest')
  love.graphics.setFont(g.fonts.p8)
end

function love.load()
  love.keyboard.setKeyRepeat(true)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  load_initial_game_state()
  load_fonts()
  love.window.setMode(0, 0)
  update_scale()
end

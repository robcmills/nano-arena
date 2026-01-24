local g = require('g')
local load_canvas = require('load/load_canvas')
local load_editor = require('load/load_editor')
local load_fonts = require('load/load_fonts')
local load_game = require('load/load_game')
local load_palette = require('load/load_palette')
local test = require('test')

function love.load()
  love.filesystem.setIdentity("nano-arena")

  local width, height = love.window.getDesktopDimensions()
  love.window.setMode(width, height, {
    borderless = false,
    resizable = false,
    vsync = true,
    x = 0,
    y = 0
  })

  love.keyboard.setKeyRepeat(true)
  love.mouse.setVisible(false)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  load_canvas()
  load_fonts()
  g.palette = load_palette('assets/palette.pal')
  if g.state == 'game' then
    if g.is_test then test:load() else load_game() end
  elseif g.state == 'editor' then
    load_editor()
  end
end

local g = require('g')
local load_menu_bar = require('load/load_menu_bar')
local load_menus = require('load/load_menus')
local settings = require('settings')

local function load_editor()
  g.editor = {}
  g.editor.spritesheet = love.graphics.newImage("assets/editor-spritesheet.png")

  local tile_x = 0
  local tile_y = 0
  local tile_size = settings.tile_size

  g.editor.cursor_quad = love.graphics.newQuad(
    tile_x * tile_size,
    tile_y * tile_size,
    tile_size,
    tile_size,
    g.editor.spritesheet:getDimensions()
  )

  load_menu_bar()
  load_menus()
end

return load_editor

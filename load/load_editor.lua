local g = require('g')
local load_menu_bar = require('load/load_menu_bar')
local load_menus = require('load/load_menus')
local settings = require('settings')

local function load_editor()
  local editor_spritesheet = love.graphics.newImage("assets/editor-spritesheet.png")
  local tile_size = settings.tile_size
  g.editor = {
    char_width = 0,
    cursor_quad = love.graphics.newQuad(
      0,
      0,
      tile_size,
      tile_size,
      editor_spritesheet:getDimensions()
    ),
    menu_bar_colored_text = nil,
    menu_bar_height = nil,
    menu_bar_items = nil,
    menu_bar_order = nil,
    menu_padding = nil,
    menus = nil,
    opened_menu = nil,
    spritesheet = editor_spritesheet,
  }

  load_menu_bar()
  load_menus()
end

return load_editor

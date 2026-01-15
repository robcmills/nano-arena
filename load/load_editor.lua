local editor = require('editor')
local g = require('g')
local load_menu_bar = require('load/load_menu_bar')
local load_menus = require('load/load_menus')
local settings = require('settings')

local function load_editor()
  editor.font = g.fonts.future
  local editor_spritesheet = love.graphics.newImage("assets/editor-spritesheet.png")
  local tile_size = settings.tile_size
  editor.cursor_quad = love.graphics.newQuad(
    0,
    0,
    tile_size,
    tile_size,
    editor_spritesheet:getDimensions()
  )
  editor.spritesheet = editor_spritesheet
  editor.windows = {}

  load_menu_bar()
  load_menus()
  g.state = 'editor'
end

return load_editor

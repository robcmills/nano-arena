local editor = require('editor')
local g = require('g')
local load_editor_sprites = require('load/load_editor_sprites')
local load_menu_bar = require('load/load_menu_bar')
local load_menus = require('load/load_menus')

local function load_editor()
  editor.font = g.fonts.future
  editor.windows = {}
  load_editor_sprites()
  load_menu_bar()
  load_menus()
  g.state = 'editor'
end

return load_editor

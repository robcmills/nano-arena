local g = require('g')
local load_menu_bar = require('load/load_menu_bar')
local load_menus = require('load/load_menus')

local function load_editor()
  g.editor = {}
  load_menu_bar()
  load_menus()
end

return load_editor

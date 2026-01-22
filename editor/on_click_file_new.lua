local close_opened_menu = require('editor/close_opened_menu')
local editor = require('editor')
local g = require('g')
local stringify = require('util/stringify')

local function on_click_file_new()
  close_opened_menu()
  ---@type Arena
  local new_arena = {
    name = "Njw arena",
  }
  table.insert(editor.arenas, new_arena)
  editor.active_arena = #editor.arenas

  g.debug = stringify(editor.arenas)
end

return on_click_file_new

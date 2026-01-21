local close_opened_menu = require('editor/close_opened_menu')
local editor = require('editor')

local function on_click_file_new()
  close_opened_menu()
  ---@type Arena
  local new_arena = {
    name = "New arena",
  }
  table.insert(editor.arenas, new_arena)
  editor.active_arena = #editor.arenas
end

return on_click_file_new

local close_opened_menu = require('editor/close_opened_menu')
local editor = require('editor')
local update_tabs = require('editor/update_tabs')

local function on_click_file_new()
  close_opened_menu()
  ---@type Arena
  local new_arena = {
    name = '' .. os.date("%Y-%m-%d-%H:%M:%S"),
  }
  table.insert(editor.arenas, new_arena)
  editor.active_arena = #editor.arenas
  update_tabs()
end

return on_click_file_new

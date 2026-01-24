local close_opened_menu = require('editor/close_opened_menu')
local editor = require('editor')
local update_tabs = require('editor/update_tabs')

local i = 1
local names = {
  "a1",
  "arena2",
  "arena3tniresnfktien13ntenvkies",
}

local function on_click_file_new()
  close_opened_menu()

  local name = i <= #names and names[i] or '' .. os.date("%Y-%m-%d-%H:%M:%S")
  i = i + 1

  ---@type Arena
  local new_arena = {
    name = name,
  }
  table.insert(editor.arenas, new_arena)
  editor.active_arena = #editor.arenas
  update_tabs()
end

return on_click_file_new

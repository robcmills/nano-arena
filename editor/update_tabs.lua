local editor = require('editor')

local function update_tabs()
  editor.tabs = {}
  local x = 0
  local y = editor.menu_bar_height
  for _, arena in ipairs(editor.arenas) do
    local tab_width = editor.menu_padding_x * 2 + (#arena.name + 3) * editor.font.char_width
    ---@type TabState
    local tab_state = {
      tab_rect = {
        x = x,
        y = y,
        width = tab_width,
        height = editor.menu_bar_height,
      },
      close_button_rect = {
        x = x + tab_width - editor.menu_padding_x - 7,
        y = y + 5,
        width = 7,
        height = 7,
      },
    }
    table.insert(editor.tabs, tab_state)
    x = x + tab_width + editor.tab_gap
  end
end

return update_tabs

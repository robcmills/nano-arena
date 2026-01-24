local editor = require('editor')
local get_tab_text = require('editor/get_tab_text')
local utf8 = require('utf8')

local function update_tabs()
  editor.tabs = {}
  local x = 0
  local y = editor.menu_bar_height
  for _, arena in ipairs(editor.arenas) do
    local tab_text = get_tab_text(arena.name)
    -- Lua's `#` operator counts **bytes**, not characters.
    -- The ellipsis `…` is 3 bytes in UTF-8 encoding.
    -- So to get an accurate char count, we need to use `utf8.len`.
    local tab_char_count = utf8.len(tab_text)
    local tab_width = editor.menu_padding_x * 2 + (tab_char_count + 2) * editor.font.char_width
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

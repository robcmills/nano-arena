local editor = require('editor')
local g = require('g')
local theme = require('theme')

local function load_menu_bar()
  editor.char_width = g.fonts.p8.char_width
  editor.menu_padding = 2
  editor.menu_bar_height = g.fonts.p8.char_height + editor.menu_padding * 2

  editor.menu_bar_items = {
    file = { key = "F", label = "ILE" },
    edit = { key = "E", label = "DIT" },
    grid = { key = "G", label = "RID" },
    help = { key = "H", label = "ELP" },
  }
  editor.menu_bar_order = { "file", "edit", "grid", "help" }

  -- calculate offsets
  local x_offset = 0
  for _, key in ipairs(editor.menu_bar_order) do
    local item = editor.menu_bar_items[key]
    item.width = (#item.key + #item.label) * editor.char_width + editor.menu_padding * 2
    item.height = editor.menu_bar_height
    item.x = x_offset
    item.y = 0
    x_offset = x_offset + item.width - editor.menu_padding * 2 + (2 * editor.char_width) -- 2 spaces between items
  end

  -- colored menu bar text
  local highlight = theme.menu_bar_text_highlight_color
  local normal = theme.menu_bar_text_normal_color
  local colored_text = {}
  for _, id in ipairs(editor.menu_bar_order) do
    local is_open = (editor.opened_menu == id)
    local key_color = is_open and normal or highlight
    local text_color = normal
    local item = editor.menu_bar_items[id]
    table.insert(colored_text, key_color)
    table.insert(colored_text, item.key)
    table.insert(colored_text, text_color)
    table.insert(colored_text, item.label)
    if id ~= 'help' then
      table.insert(colored_text, normal)
      table.insert(colored_text, "  ")
    end
  end
  editor.menu_bar_colored_text = colored_text
end

return load_menu_bar

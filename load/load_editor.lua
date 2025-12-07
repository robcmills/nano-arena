local colors = require('colors')
local g = require('g')

local function load_editor()
  g.editor = {
    char_width = g.fonts.p8.char_width,
    menu_bar_color = colors.dark_grey,
    menu_padding = 2,
    opened_menu = nil,
  }
  g.editor.menu_bar_height = g.fonts.p8.char_height + g.editor.menu_padding * 2

  g.editor.menu_bar_items = {
    file = { key = "F", label = "ILE" },
    edit = { key = "E", label = "DIT" },
    grid = { key = "G", label = "RID" },
    settings = { key = "S", label = "ETTINGS" },
    help = { key = "H", label = "ELP" },
  }
  g.editor.menu_bar_order = { "file", "edit", "grid", "settings", "help" }

  -- calculate offsets
  local x_offset = 0
  for _, item in ipairs(g.editor.menu_bar_items) do
    item.width = (#item.key + #item.label) * g.editor.char_width + g.editor.menu_padding * 2
    item.x = x_offset
    x_offset = x_offset + item.width + (2 * g.editor.char_width) -- 2 spaces between items
  end

  -- colored menu bar text
  local highlight = colors.p8.blue -- highlight color
  local normal = colors.white -- normal color
  local colored_text = {}
  for _, id in ipairs(g.editor.menu_bar_order) do
    local is_open = (g.editor.opened_menu == id)
    local key_color = is_open and colors.white or highlight
    local text_color = is_open and colors.white or normal
    local item = g.editor.menu_bar_items[id]
    table.insert(colored_text, key_color)
    table.insert(colored_text, item.key)
    table.insert(colored_text, text_color)
    table.insert(colored_text, item.label)
    if id ~= 'help' then
      table.insert(colored_text, normal)
      table.insert(colored_text, "  ")
    end
  end
  g.editor.menu_bar_text = colored_text
end

return load_editor

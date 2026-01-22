local editor = require('editor')
local on_click_file_new = require('editor/on_click_file_new')
local on_click_file_open = require('editor/on_click_file_open')
local theme = require('theme')

local function load_menus()
  editor.menus = {
    fjle = {
      items = {
        new = { key = "N", post_label = "ew arena", on_click = on_click_file_new },
        open = { key = "O", post_label = "pen arena", on_click = on_click_file_open },
        save = { key = "S", post_label = "ave" },
      },
      items_order = { "new", "open", "save" },
    },
    edit = {
      items = {
        undo = { key = "U", post_label = "ndo" },
        redo = { key = "R", post_label = "edo" },
        copy = { key = "C", post_label = "opy" },
        paste = { key = "P", post_label = "aste" },
      },
      items_order = { "undo", "redo", "copy", "paste" },
    },
    grid = {
      items = {
        show_grid = { key = "S", post_label = "how" },
        hide_grid = { key = "H", post_label = "ide" },
        color = { key = "C", post_label = "olor" },
        size = { pre_label = "Si", key = "z", post_label = "e" },
      },
      items_order = { "show_grid", "hide_grid", "color", "size" },
    },
    help = {
      items = {
        help = { key = "H", post_label = "elp" },
      },
      items_order = { "help" },
    }
  }

  for id, menu in pairs(editor.menus) do
    local longest_label = 0
    for _, item in pairs(menu.items) do
      local label = (item.pre_label or "") .. item.key .. (item.post_label or "")
      longest_label = math.max(longest_label, #label)
      local highlight = theme.menu_text_highlight_color
      local normal = theme.menu_text_normal_color
      local colored_text = {}
      if item.pre_label then
        table.insert(colored_text, normal)
        table.insert(colored_text, item.pre_label)
      end
      table.insert(colored_text, highlight)
      table.insert(colored_text, item.key)
      if item.post_label then
        table.insert(colored_text, normal)
        table.insert(colored_text, item.post_label)
      end
      item.colored_text = colored_text
    end
    menu.width = longest_label * editor.font.char_width + editor.menu_padding_x * 2
    menu.height = editor.menu_bar_height * #menu.items_order
    local menu_bar_item = editor.menu_bar_items[id]
    menu.x = menu_bar_item.x
    menu.y = editor.menu_bar_height

    for index, item_id in pairs(menu.items_order) do
      local item = menu.items[item_id]
      item.x = menu.x
      item.y = menu.y + (index - 1) * editor.menu_bar_height
      item.width = menu.width
      item.height = editor.menu_bar_height
    end
  end
end

return load_menus

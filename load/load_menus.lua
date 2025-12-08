local g = require('g')
local keys = require('util/keys')
local theme = require('theme')

local function load_menus()
  g.editor.menus = {
    file = {
      items = {
        new = { key = "N", post_label = "EW" },
        open = { key = "O", post_label = "PEN" },
        save = { key = "S", post_label = "AVE" },
      },
      items_order = { "new", "open", "save" },
    },
    edit = {
      items = {
        undo = { key = "U", post_label = "NDO" },
        redo = { key = "R", post_label = "EDO" },
        copy = { key = "C", post_label = "OPY" },
        paste = { key = "P", post_label = "ASTE" },
      },
      items_order = { "undo", "redo", "copy", "paste" },
    },
    grid = {
      items = {
        show_grid = { key = "S", post_label = "HOW" },
        hide_grid = { key = "H", post_label = "IDE" },
        color = { key = "C", post_label = "OLOR" },
        size = { pre_label = "SI", key = "Z", post_label = "E" },
      },
      items_order = { "show_grid", "hide_grid", "color", "size" },
    },
    help = {
      items = {
        help = { key = "H", post_label = "ELP" },
      },
      items_order = { "help" },
    }
  }

  for id, menu in pairs(g.editor.menus) do
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
    menu.width = longest_label * g.editor.char_width + g.editor.menu_padding * 2
    menu.height = g.editor.menu_bar_height * #menu.items_order
    local menu_bar_item = g.editor.menu_bar_items[id]
    menu.x = menu_bar_item.x
    menu.y = g.editor.menu_bar_height

    for index, item_id in pairs(menu.items_order) do
      local item = menu.items[item_id]
      item.x = menu.x
      item.y = menu.y + (index - 1) * g.editor.menu_bar_height
      item.width = menu.width
      item.height = g.editor.menu_bar_height
    end
  end
end

return load_menus

local g = require('g')
local keys = require('util/keys')

local function load_menus()
  g.editor.menus = {
    file = {
      new = { key = "N", post_label = "EW" },
      open = { key = "O", post_label = "PEN" },
      save = { key = "S", post_label = "AVE" },
    },
    edit = {
      undo = { key = "U", post_label = "NDO" },
      redo = { key = "R", post_label = "EDO" },
      copy = { key = "C", post_label = "OPY" },
      paste = { key = "P", post_label = "ASTE" },
    },
    grid = {
      show_grid = { key = "S", post_label = "HOW" },
      hide_grid = { key = "H", post_label = "IDE" },
      color = { key = "C", post_label = "OLOR" },
      size = { pre_label = "SI", key = "Z", post_label = "E" },
    },
    settings = {},
    help = {
      help = { key = "H", post_label = "ELP" },
    }
  }

  for id, menu in pairs(g.editor.menus) do
    local longest_label = 0
    for _, item in pairs(menu) do
      local label = (item.pre_label or "")..item.key..(item.post_label or "")
      longest_label = math.max(longest_label, #label)
    end
    menu.width = longest_label * g.editor.char_width + g.editor.menu_padding * 2
    menu.height = g.editor.menu_bar_height * #keys(menu)
    local menu_bar_item = g.editor.menu_bar_items[id]
    menu.x = menu_bar_item.x
    menu.y = g.editor.menu_bar_height
  end
end

return load_menus

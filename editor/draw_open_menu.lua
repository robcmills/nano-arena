local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local theme = require('theme')

local function draw_open_menu()
  if editor.opened_menu == nil then return end

  local menu = editor.menus[editor.opened_menu]

  -- background
  draw_rect({
    color = theme.menu_background_color,
    height = menu.height,
    width = menu.width,
    x = menu.x,
    y = menu.y,
  })
  -- border
  draw_rect({
    color = theme.menu_bar_highlight_background_color,
    fill = false,
    height = menu.height,
    width = menu.width,
    x = menu.x + 1,
    y = menu.y,
  })

  -- draw menu items
  for i, item_id in ipairs(menu.items_order) do
    local item = menu.items[item_id]
    if item.is_hovered then
      draw_rect({
        color = theme.menu_bar_highlight_background_color,
        height = item.height,
        width = item.width,
        x = item.x,
        y = item.y,
      })
    end
    draw_text({
      text = item.colored_text,
      x = menu.x + editor.menu_padding_x,
      y = menu.y + editor.menu_padding_y + (i-1) * editor.menu_bar_height,
    })
  end
end

return draw_open_menu

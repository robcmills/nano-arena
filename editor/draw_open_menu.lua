local editor = require('editor')
local theme = require('theme')

local function draw_open_menu()
  if editor.opened_menu == nil then return end

  local menu = editor.menus[editor.opened_menu]
  love.graphics.setColor(theme.menu_background_color)
  love.graphics.rectangle('fill', menu.x, menu.y, menu.width, menu.height)
  love.graphics.setColor(1, 1, 1)

  -- draw menu items
  for i, item_id in ipairs(menu.items_order) do
    local item = menu.items[item_id]
    if item.is_hovered then
      love.graphics.setColor(theme.menu_bar_highlight_background_color)
      love.graphics.rectangle('fill', item.x, item.y, item.width, item.height)
      love.graphics.setColor(1, 1, 1)
    end
    local x = menu.x + editor.menu_padding_x
    local y = menu.y + editor.menu_padding_y + (i-1) * editor.menu_bar_height
    love.graphics.print(item.colored_text, x, y)
  end
end

return draw_open_menu

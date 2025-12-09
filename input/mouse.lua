local g = require('g')

function love.mousemoved(screen_x, screen_y)
  local x = screen_x / g.scale_x
  local y = screen_y / g.scale_y

  -- menu bar hover
  for _, key in ipairs(g.editor.menu_bar_order) do
    local item = g.editor.menu_bar_items[key]
    item.is_hovered = y < g.editor.menu_bar_height and x >= item.x and x < item.x + item.width
    if item.is_hovered and g.editor.opened_menu ~= nil then
      g.editor.opened_menu = key
    end
  end

  -- menu hover
  if g.editor.opened_menu then
    local menu = g.editor.menus[g.editor.opened_menu]
    for _, item_id in ipairs(menu.items_order) do
      local item = menu.items[item_id]
      item.is_hovered = x >= item.x and x < item.x + item.width and y >= item.y and y < item.y + item.height
    end
  end
end

function love.mousepressed(x, y, button)
  if button == 1 then
    -- menu bar
    for _, key in ipairs(g.editor.menu_bar_order) do
      local item = g.editor.menu_bar_items[key]
      if item.is_hovered then
        g.editor.opened_menu = key
        return
      end
    end

    g.editor.opened_menu = nil
  end
end

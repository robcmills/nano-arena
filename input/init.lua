local g = require('g')

function love.keypressed(key)
  if key == 'f' then
    g.editor.opened_menu = 'file'
  elseif key == 'e' then
    g.editor.opened_menu = 'edit'
  elseif key == 'g' then
    g.editor.opened_menu = 'grid'
  elseif key == 'h' then
    g.editor.opened_menu = 'help'
  elseif key == 'escape' then
    g.editor.opened_menu = nil
  elseif key == 'q' then
    love.event.quit()
  end
end

function love.mousemoved(screen_x, screen_y)
  local x = (screen_x - g.offset_x) / g.scale
  local y = (screen_y - g.offset_y) / g.scale

  -- menu bar hover
  for _, key in ipairs(g.editor.menu_bar_order) do
    local item = g.editor.menu_bar_items[key]
    item.is_hovered = y < g.editor.menu_bar_height and x >= item.x and x < item.x + item.width
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

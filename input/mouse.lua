local editor = require('editor')
local g = require('g')

function love.mousemoved(screen_x, screen_y)
  if g.state ~= 'editor' then return end

  local x = screen_x / g.canvas_scale
  local y = screen_y / g.canvas_scale

  -- menu bar hover
  for _, key in ipairs(editor.menu_bar_order) do
    local item = editor.menu_bar_items[key]
    item.is_hovered = y < editor.menu_bar_height and x >= item.x and x < item.x + item.width
    if item.is_hovered and editor.opened_menu ~= nil then
      editor.opened_menu = key
    end
  end

  -- menu hover
  if editor.opened_menu then
    local menu = editor.menus[editor.opened_menu]
    for _, item_id in ipairs(menu.items_order) do
      local item = menu.items[item_id]
      item.is_hovered = x >= item.x and x < item.x + item.width and y >= item.y and y < item.y + item.height
    end
  end
end

function love.mousepressed(x, y, button)
  if g.state ~= 'editor' then return end

  if button == 1 then
    -- menu bar
    for _, key in ipairs(editor.menu_bar_order) do
      local item = editor.menu_bar_items[key]
      if item.is_hovered then
        editor.opened_menu = key
        return
      end
    end

    -- open menu
    if editor.opened_menu then
      local menu = editor.menus[editor.opened_menu]
      for _, item in pairs(menu.items) do
        if item.is_hovered and item.on_click then
          item.on_click()
        end
      end
    end

    editor.opened_menu = nil
  end
end

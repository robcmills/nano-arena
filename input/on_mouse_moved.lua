local editor = require('editor')
local g = require('g')
local screen_to_canvas = require('util/screen_to_canvas')

---@param screen_x number
---@param screen_y number
local function on_mouse_moved(screen_x, screen_y)
  if g.state ~= 'editor' then return end

  local x = screen_to_canvas(screen_x)
  local y = screen_to_canvas(screen_y)

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

return on_mouse_moved

local editor = require('editor')
local g = require('g')
local screen_to_canvas = require('util/screen_to_canvas')

---@param screen_x number
---@param screen_y number
---@param button number
local function on_mouse_pressed(screen_x, screen_y, button)
  if g.state ~= 'editor' then return end

  local x = screen_to_canvas(screen_x)
  local y = screen_to_canvas(screen_y)

  if button == 1 then
    -- windows

    -- open arena window
    local window = editor.windows.open
    if window and window.state == 'open' then
      -- if outside of window, close it
      if x < window.x or x > window.x + window.width or
         y < window.y or y > window.y + window.height then
        editor.windows.open.state = 'closed'
        return
      end
    end

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

return on_mouse_pressed

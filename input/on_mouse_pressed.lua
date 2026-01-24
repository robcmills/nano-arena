local close_file_open_window = require('editor/close_file_open_window')
local editor = require('editor')
local g = require('g')
local is_inside = require('collision/is_inside')
local on_click_in_file_open_window = require('editor/on_click_in_file_open_window')
local on_click_tabs = require('editor/on_click_tabs')
local screen_to_canvas = require('util/screen_to_canvas')

---@param screen_x number
---@param screen_y number
---@param button number
local function on_mouse_pressed(screen_x, screen_y, button)
  if g.state ~= 'editor' then return end

  local x = screen_to_canvas(screen_x)
  local y = screen_to_canvas(screen_y)

  -- windows

  -- open arena window
  local window = editor.windows.open
  if window and window.state == 'open' then
    -- if outside of window, close it
    local rect = { x = window.x, y = window.y, width = window.width, height = window.height }
    if not is_inside({ x = x, y = y, rect = rect }) then
      if button == 1 then
        close_file_open_window()
      end
    else
      on_click_in_file_open_window({ button = button, x = x, y = y })
    end
    return
  end

  if button == 1 then
    -- menu bar
    if not editor.opened_menu then
      for _, key in ipairs(editor.menu_bar_order) do
        local item = editor.menu_bar_items[key]
        if item.is_hovered then
          editor.opened_menu = key
          return
        end
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
      editor.opened_menu = nil
      return
    end

    -- tabs
    on_click_tabs({ x = x, y = y, button = button })
  end
end

return on_mouse_pressed

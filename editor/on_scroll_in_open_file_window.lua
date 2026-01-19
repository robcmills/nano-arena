local editor = require('editor')
local get_mouse_canvas_position = require('input/get_mouse_canvas_position')
local is_inside = require('collision/is_inside')

local function on_scroll_in_open_file_window(dx, dy)
  local open_window = editor.windows.open
  if not open_window or open_window.state ~= 'open' then
    return
  end

  local mouse_x, mouse_y = get_mouse_canvas_position()
  local rect = {
    height = open_window.height,
    width = open_window.width,
    x = open_window.x,
    y = open_window.y,
  }
  if not is_inside({ x = mouse_x, y = mouse_y, rect = rect }) then
    return
  end

  open_window.scroll_velocity_x = open_window.scroll_velocity_x + dx * 64
  open_window.scroll_velocity_y = open_window.scroll_velocity_y - dy * 64
end

return on_scroll_in_open_file_window

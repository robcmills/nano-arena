local editor = require('editor')
local settings = require('settings')

local function update_open_file_window(dt)
  local open_window = editor.windows.open
  if not open_window or open_window.state ~= 'open' then
    return
  end

  open_window.scroll_offset_x = open_window.scroll_offset_x + open_window.scroll_velocity_x * dt
  open_window.scroll_offset_y = open_window.scroll_offset_y + open_window.scroll_velocity_y * dt

  local max_scroll_y = math.max(
    0,
    #open_window.files * open_window.item_height - open_window.height + settings.tile_size + 1
  )
  -- clamp vertical scroll
  open_window.scroll_offset_y = math.max(
    0,
    math.min(open_window.scroll_offset_y, max_scroll_y)
  )

  -- Gradually reduce the velocity to create smooth scrolling effect.
  open_window.scroll_velocity_x =
      open_window.scroll_velocity_x -
      open_window.scroll_velocity_x *
      math.min(dt * 8, 1)
  open_window.scroll_velocity_y =
      open_window.scroll_velocity_y -
      open_window.scroll_velocity_y *
      math.min(dt * 8, 1)
end

return update_open_file_window

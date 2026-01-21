local editor = require('editor')

local function close_file_open_window()
  local window = editor.windows.open
  if not window then return end
  window.files = {}
  window.scroll_offset_x = 0
  window.scroll_offset_y = 0
  window.scroll_velocity_x = 0
  window.scroll_velocity_y = 0
  window.state = 'closed'
end

return close_file_open_window

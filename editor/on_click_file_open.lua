local create_new_window = require('editor/create_new_window')
local editor = require('editor')
local get_file_list = require('editor/get_file_list')
local settings = require('settings')

local function on_click_file_open()
  if editor.windows.open then
    editor.windows.open.state = 'open'
  else
    local window = create_new_window({
      height = 256,
      placement = 'center',
      title = 'Select arena',
      width = 256,
    })
    editor.windows.open = {
      directory = "",
      files = get_file_list(""),
      full_screen = false,
      height = window.height,
      item_height = settings.tile_size,
      scroll_offset = 0,
      state = 'open',
      title = 'Select arena',
      width = window.width,
      x = window.x,
      y = window.y,
    }
  end
end

return on_click_file_open

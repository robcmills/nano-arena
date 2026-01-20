local create_new_window = require('editor/create_new_window')
local editor = require('editor')
local get_arena_files = require('editor/get_arena_files')
local settings = require('settings')

local function on_click_file_open()
  if editor.windows.open then
    editor.windows.open.state = 'open'
    editor.windows.open.files = get_arena_files()
  else
    local window = create_new_window({
      height = 256 + 2,
      placement = 'center',
      title = 'Select arena',
      width = 256,
    })
    editor.windows.open = {
      files = get_arena_files(),
      full_screen = false,
      height = window.height,
      item_height = settings.tile_size,
      scroll_offset_x = 0,
      scroll_offset_y = 0,
      scroll_velocity_x = 0,
      scroll_velocity_y = 0,
      state = 'open',
      title = 'Select arena',
      width = window.width,
      x = window.x,
      y = window.y,
    }
  end
end

return on_click_file_open

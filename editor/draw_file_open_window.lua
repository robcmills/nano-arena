local draw_files_list = require('editor/draw_files_list')
local draw_sprite_window = require('editor/draw_sprite_window')
local editor = require('editor')
local settings = require('settings')

local function draw_file_open_window()
  local window = editor.windows.open
  assert(window, 'editor.windows.open is nil')

  draw_sprite_window({
    full_screen = window.full_screen,
    height = window.height,
    title = window.title,
    width = window.width,
    x = window.x,
    y = window.y,
  })

  draw_files_list({
    files = window.files,
    height = window.height - settings.tile_size * 2,
    item_height = window.item_height,
    scroll_offset_x = window.scroll_offset_x,
    scroll_offset_y = window.scroll_offset_y,
    width = window.width - 2,
    x = window.x + 1,
    y = window.y + settings.tile_size,
  })
end

return draw_file_open_window

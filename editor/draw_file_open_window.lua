local colors = require('colors')
local draw_files_list = require('editor/draw_files_list')
local draw_rect = require('draw/draw_rect')
local draw_sprite_window = require('editor/draw_sprite_window')
local draw_text = require('draw/draw_text')
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

  -- draw current directory
  draw_rect({
    color = colors.grey33,
    height = settings.tile_size,
    width = window.width - 2,
    x = window.x + 1,
    y = window.y + settings.tile_size,
  })
  draw_text({
    color = colors.white,
    text = "/" .. window.directory,
    x = window.x + 6,
    y = window.y + settings.tile_size + 2,
  })

  draw_files_list({
    files = window.files,
    height = window.height - settings.tile_size * 3,
    item_height = window.item_height,
    scroll_offset_x = window.scroll_offset_x,
    scroll_offset_y = window.scroll_offset_y,
    width = window.width - 2,
    x = window.x + 1,
    y = window.y + settings.tile_size * 2,
  })
end

return draw_file_open_window

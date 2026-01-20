local colors = require('colors')
local draw_files_list = require('editor/draw_files_list')
local draw_rectangular_window = require('draw/draw_rectangular_window')
local editor = require('editor')
local get_files_list_scroll_container = require('editor/get_files_list_scroll_container')

local function draw_file_open_window()
  local window = editor.windows.open
  assert(window, 'editor.windows.open is nil')

  draw_rectangular_window({
    full_screen = window.full_screen,
    height = window.height,
    title = window.title,
    width = window.width,
    x = window.x,
    y = window.y,
  })

  local scroll_container = get_files_list_scroll_container(window)
  draw_files_list({
    files = window.files,
    height = scroll_container.height,
    item_height = window.item_height,
    scroll_offset_x = window.scroll_offset_x,
    scroll_offset_y = window.scroll_offset_y,
    width = scroll_container.width,
    x = scroll_container.x,
    y = scroll_container.y,
  })
end

return draw_file_open_window

local draw_sprite_window = require('editor/draw_sprite_window')
local editor = require('editor')

local function draw_file_open_window()
  local window = editor.windows.open
  assert(window, 'editor.windows.open is nil')

  draw_sprite_window({
    height = window.height,
    title = window.title,
    width = window.width,
    x = window.x,
    y = window.y,
  })
end

return draw_file_open_window

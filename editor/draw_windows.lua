local draw_file_open_window = require('editor/draw_file_open_window')
local editor = require('editor')

local function draw_windows()
  if editor.windows.open and editor.windows.open.state == 'open' then
    draw_file_open_window()
  end
end

return draw_windows

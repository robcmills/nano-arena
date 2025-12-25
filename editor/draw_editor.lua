local draw_background = require('editor/draw_background')
local draw_cursor = require('editor/draw_cursor')
local draw_menu = require('editor/draw_menu')

local function draw_editor()
  draw_background()
  draw_menu()
  draw_cursor()
end

return draw_editor

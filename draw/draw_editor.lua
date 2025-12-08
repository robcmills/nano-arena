local draw_cursor = require('draw/draw_cursor')
local draw_menu = require('draw/draw_menu')

local function draw_editor()
  draw_menu()
  draw_cursor()
end

return draw_editor

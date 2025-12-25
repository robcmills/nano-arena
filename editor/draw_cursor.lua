local editor = require('editor')
local g = require('g')

local function draw_cursor()
  local mouse_x, mouse_y = love.mouse.getPosition()
  -- Transform window to canvas coords
  local canvas_x = mouse_x / g.canvas_scale
  local canvas_y = mouse_y / g.canvas_scale
  love.graphics.draw(editor.spritesheet, editor.cursor_quad, canvas_x, canvas_y)
end

return draw_cursor

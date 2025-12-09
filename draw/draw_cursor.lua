local g = require('g')

local function draw_cursor()
  local mouse_x, mouse_y = love.mouse.getPosition()
  -- Transform window to canvas coords
  local canvas_x = mouse_x / g.scale_x
  local canvas_y = mouse_y / g.scale_y
  love.graphics.draw(g.editor.spritesheet, g.editor.cursor_quad, canvas_x, canvas_y)
end

return draw_cursor

local g = require('g')

local function draw_cursor()
  local mouse_x, mouse_y = love.mouse.getPosition()
  -- Transform from window coords to canvas coords
  local canvas_mouse_x = (mouse_x - g.offset_x) / g.scale
  local canvas_mouse_y = (mouse_y - g.offset_y) / g.scale
  love.graphics.draw(g.editor.spritesheet, g.editor.cursor_quad, canvas_mouse_x, canvas_mouse_y)
end

return draw_cursor

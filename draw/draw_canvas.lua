local g = require('g')

local function draw_canvas()
  local window_width, window_height = love.graphics.getDimensions()
  local canvas_width, canvas_height = g.canvas:getDimensions()

  -- Calculate scale to fit canvas in window
  local scale_x = window_width / canvas_width
  local scale_y = window_height / canvas_height
  local scale = math.min(scale_x, scale_y)  -- Use min to ensure it fits

  -- Center the canvas
  local offset_x = (window_width - canvas_width * scale) / 2
  local offset_y = (window_height - canvas_height * scale) / 2

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(g.canvas, offset_x, offset_y, 0, scale, scale)
end

return draw_canvas

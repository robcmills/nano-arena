local g = require('g')

--- Draws centered axis lines on the canvas
local function draw_screen_center(options)
  options = options or {}

  local x_color = options.x_color or { 1, 0, 0, 1 }
  local y_color = options.y_color or { 0, 1, 0, 1 }

  local x_length = options.x_length or 1
  local y_length = options.y_length or 1

  local canvas_width, canvas_height = g.canvas:getDimensions()
  local center_x = math.floor(canvas_width / 2)
  local center_y = math.floor(canvas_height / 2)

  local h_half = math.floor((canvas_width * x_length) / 2)
  local v_half = math.floor((canvas_height * y_length) / 2)

  -- x axis
  love.graphics.setColor(x_color)
  love.graphics.rectangle("fill", center_x - h_half, center_y, h_half * 2, 1)

  -- y axis
  love.graphics.setColor(y_color)
  love.graphics.rectangle("fill", center_x, center_y - v_half, 1, v_half * 2)
end

return draw_screen_center

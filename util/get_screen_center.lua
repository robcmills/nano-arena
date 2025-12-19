local g = require('g')

local function get_screen_center()
  local window_width, window_height = love.graphics.getDimensions()
  return window_width / 2 / g.canvas_scale, window_height / 2 / g.canvas_scale
end

return get_screen_center

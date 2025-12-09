local g = require('g')
local round = require('util/round')

local function get_screen_center()
  local window_width, window_height = love.graphics.getDimensions()
  return round(window_width / 2 / g.scale_x), round(window_height / 2 / g.scale_y)
end

return get_screen_center

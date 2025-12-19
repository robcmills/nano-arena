local g = require('g')
local settings = require('settings')

local function load_canvas()
  local window_width, window_height = love.graphics.getDimensions()
  local canvas_width, canvas_height

  if window_width < window_height then
    canvas_width = settings.resolution
    canvas_height = settings.resolution * (window_height / window_width)
  else
    canvas_height = settings.resolution
    canvas_width = settings.resolution * (window_width / window_height)
  end

  -- Calculate scale to fit canvas in window
  local scale_x = window_width / canvas_width
  local scale_y = window_height / canvas_height
  g.canvas_scale = math.min(scale_x, scale_y)  -- Use min to ensure it fits

  g.canvas = love.graphics.newCanvas(canvas_width, canvas_height)
end

return load_canvas

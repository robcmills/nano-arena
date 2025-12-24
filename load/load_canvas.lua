local g = require('g')
local settings = require('settings')

local function load_canvas()
  local window_width, window_height = love.graphics.getDimensions()

  -- Find the largest integer scale that fits (floats will distort pixel art)
  g.canvas_scale = math.floor(math.min(
    window_width / settings.resolution,
    window_height / settings.resolution
  ))

  -- Size canvas to exactly fill window at integer scale
  local canvas_width = math.ceil(window_width / g.canvas_scale)
  local canvas_height = math.ceil(window_height / g.canvas_scale)

  g.canvas = love.graphics.newCanvas(canvas_width, canvas_height)
end

return load_canvas

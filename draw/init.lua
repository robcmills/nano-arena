local g = require('g')
local get_screen_center = require('util/get_screen_center')
local round = require('util/round')
local settings = require('settings')

local function draw_grid(x, y, tile_size, grid_size, grid_color)
  -- default parameters
  local center_x, center_y = get_screen_center()
  tile_size = tile_size or settings.tile_size
  grid_color = grid_color or settings.grid_color
  grid_size = grid_size or settings.grid_size
  x = x or center_x - tile_size * (round(grid_size / 2))
  y = y or center_y - tile_size * (round(grid_size / 2))
  -- disable blending to prevent overlap artifacts
  love.graphics.setBlendMode("replace")
  love.graphics.setLineStyle("rough")  -- crisp pixel-perfect lines
  love.graphics.setColor(grid_color)
  -- vertical lines
  for i = 0, grid_size do
    local line_x = x + (i * tile_size) + 0.5
    love.graphics.line(line_x, y, line_x, y + (grid_size * tile_size) + 1)
  end
  -- horizontal lines
  for i = 0, grid_size do
    local line_y = y + (i * tile_size) + 0.5
    love.graphics.line(x, line_y, x + (grid_size * tile_size) + 1, line_y)
  end
  -- restore default blend mode and color
  love.graphics.setBlendMode("alpha")
  love.graphics.setColor(1, 1, 1)
end

function love.draw()
  -- draw game to canvas
  love.graphics.setCanvas(g.canvas)
  love.graphics.clear()
  -- drawing code here
  draw_grid()
  -- reset canvas
  love.graphics.setCanvas()
  -- clear with black bars
  love.graphics.clear(0, 0, 0)
  -- draw canvas scaled and centered
  love.graphics.draw(g.canvas, g.offset_x, g.offset_y, 0, g.scale, g.scale)
end

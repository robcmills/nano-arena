local g = require('g')
local get_screen_center = require('util/get_screen_center')
local settings = require('settings')

local function draw_grid(x, y, tile_size, grid_size, grid_color)
  -- default parameters
  local center_x, center_y = get_screen_center()
  tile_size = tile_size or settings.tile_size
  grid_color = grid_color or settings.grid_color
  grid_size = grid_size or settings.grid_size
  x = x or center_x - tile_size * (grid_size / 2)
  y = y or center_y - tile_size * (grid_size / 2)
  love.graphics.setColor(grid_color)
  -- vertical lines
  for i = 0, grid_size do
    local lineX = x + (i * tile_size)
    love.graphics.line(lineX, y, lineX, y + (grid_size * tile_size))
  end
  -- horizontal lines
  for i = 0, grid_size do
    local lineY = y + (i * tile_size)
    love.graphics.line(x, lineY, x + (grid_size * tile_size), lineY)
  end
  -- reset color to white
  love.graphics.setColor(1, 1, 1)
end

function love.draw()
  -- draw game to canvas
  love.graphics.setCanvas(g.canvas)
  love.graphics.clear()
  love.graphics.setDefaultFilter("nearest", "nearest")
  -- drawing code here
  draw_grid()
  -- reset canvas
  love.graphics.setCanvas()
  -- clear with black bars
  love.graphics.clear(0, 0, 0)
  -- draw canvas scaled and centered
  love.graphics.draw(g.canvas, g.offset_x, g.offset_y, 0, g.scale, g.scale)
end

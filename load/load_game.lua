local g = require('g')
local settings = require('settings')

local function load_game()
  g.canvas = love.graphics.newCanvas(settings.resolution, settings.resolution)
  g.offset_x = 0
  g.offset_y = 0
  g.scale = 1
end

return load_game

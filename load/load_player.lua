local g = require('g')
local settings = require('settings')

local function load_player()
  g.player = {}
  g.player.sprite = love.graphics.newImage("assets/player.png")
  g.player.x = settings.resolution / 2
  g.player.y = settings.resolution / 2
end

return load_player

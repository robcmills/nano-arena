local g = require('g')

local function draw_player()
  local x, y = g.player.x, g.player.y
  love.graphics.draw(g.player.sprite, x, y)
end

return draw_player

local g = require('g')
local get_screen_center = require('util/get_screen_center')

local function draw_player()
  local x, y = get_screen_center()
  local offset = g.player.sprite_size / 2

  local quad = g.player.sprites.right
  if g.player.dir == 'up' then
    quad = g.player.sprites.up
  elseif g.player.dir == 'down' then
    quad = g.player.sprites.down
  elseif g.player.dir == 'left' then
    quad = g.player.sprites.left
  end

  love.graphics.draw(
    g.player.sprite_sheet,
    quad,
    x - offset,
    y - offset
  )
end

return draw_player

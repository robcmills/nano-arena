local g = require('g')

local function set_player_direction(direction)
  g.player.dir = direction
  if direction == 'right' then g.player.flip_x = false end
  if direction == 'left' then g.player.flip_x = true end
end

return set_player_direction

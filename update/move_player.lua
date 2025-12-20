local g = require('g')
local settings = require('settings')

local function move_player(p, dir)
  if dir == 'right' then p.flip_x = false end
  if dir == 'left' then p.flip_x = true end

  local dx = dir == 'right' and 1 or dir == 'left' and -1 or 0
  local dy = dir == 'down' and 1 or dir == 'up' and -1 or 0
  local to_x = p.tile_x + dx
  local to_y = p.tile_y + dy

  p.last_move_time = g.now
  p.to_tile_x = to_x
  p.to_tile_y = to_y
  p.from_tile_x = p.tile_x
  p.from_tile_y = p.tile_y
  p.dir = dir
  p.speed = settings.player_move_speed
end

return move_player

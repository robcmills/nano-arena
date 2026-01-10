local g = require('g')
local is_void = require('map/is_void')
local is_wall = require('map/is_wall')
local settings = require('settings')

-- move player one tile in the given direction
local function player_move(p, dir)
  p.dir = dir
  if dir == 'right' then p.flip_x = false end
  if dir == 'left' then p.flip_x = true end

  local dx = dir == 'right' and 1 or dir == 'left' and -1 or 0
  local dy = dir == 'down' and 1 or dir == 'up' and -1 or 0
  local to_x = p.tile_x + dx
  local to_y = p.tile_y + dy

  -- prevent movement into walls
  if is_wall(to_x, to_y) then
    -- todo: play invalid movement sound
    return
  end

  -- prevent movement into void
  if not settings.allow_void_suicide and is_void(to_x, to_y) then
    -- todo: play invalid movement sound
    return
  end

  p.last_move_time = g.now
  p.to_tile_x = to_x
  p.to_tile_y = to_y
  p.from_tile_x = p.tile_x
  p.from_tile_y = p.tile_y
  p.speed = settings.player_move_speed
end

return player_move

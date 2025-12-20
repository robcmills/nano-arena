local g = require('g')
local settings = require('settings')

local function update_player_movement(p)
  if p.last_move_time == nil then return end

  local dir = p.from_tile_x < p.to_tile_x and 'right' or
      p.from_tile_x > p.to_tile_x and 'left' or
      p.from_tile_y < p.to_tile_y and 'down' or 'up'
  local delta_move_time = g.now - p.last_move_time
  local total_tiles = (dir == 'right' or dir == 'left') and
      p.to_tile_x - p.from_tile_x or p.to_tile_y - p.from_tile_y
  local total_pixels = total_tiles * settings.tile_size
  local total_move_time = math.abs(total_pixels) / p.speed
  local interpolation = math.min(delta_move_time / total_move_time, 1)
  local delta_pixels = math.floor(total_pixels * interpolation)

  if dir == 'right' or dir == 'left' then
    p.map_pixel_x = p.from_tile_x * settings.tile_size + delta_pixels
    -- if existing perpendicular partially interpolated movement then
    -- cancel it by "snapping" to new movement direction
    p.map_pixel_y = p.to_tile_y * settings.tile_size
  elseif dir == 'down' or dir == 'up' then
    p.map_pixel_y = p.from_tile_y * settings.tile_size + delta_pixels
    p.map_pixel_x = p.to_tile_x * settings.tile_size
  end

  -- update current tile position based on pixel position
  p.tile_x = math.floor((p.map_pixel_x + settings.tile_size / 2) / settings.tile_size)
  p.tile_y = math.floor((p.map_pixel_y + settings.tile_size / 2) / settings.tile_size)

  -- end movement
  if interpolation == 1 then
    p.last_move_time = nil
    p.map_pixel_x = p.to_tile_x * settings.tile_size
    p.map_pixel_y = p.to_tile_y * settings.tile_size
    p.from_tile_x = nil
    p.from_tile_y = nil
    p.to_tile_x = nil
    p.to_tile_y = nil
    p.speed = 0
  end
end

return update_player_movement

local is_wall = require('map/is_wall')

local function update_player_collisions(p)
  -- check collisions with walls map layer
  if is_wall(p.tile_x, p.tile_y) then
    -- cancel and revert last player movement
    local temp_x = p.from_tile_x
    local temp_y = p.from_tile_y
    p.from_tile_x = p.to_tile_x
    p.from_tile_y = p.to_tile_y
    p.to_tile_x = temp_x
    p.to_tile_y = temp_y
  end
end

return update_player_collisions

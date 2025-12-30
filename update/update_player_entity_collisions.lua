local get_map_tile = require('map/get_map_tile')
local spawn_player = require('load/spawn_player')

local function update_player_entity_collisions(p)
  local entity_tile = get_map_tile(p.tile_x, p.tile_y, 'entities')
  if not entity_tile then return end

  if entity_tile.properties.type == 'goal' and p.speed == 0 then
    spawn_player() -- todo: replace
  end
end

return update_player_entity_collisions

local update_player_entity_collisions = require('update/update_player_entity_collisions')

local function update_player_collisions(p)
  update_player_entity_collisions(p)
end

return update_player_collisions

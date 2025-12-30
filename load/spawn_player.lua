local get_map_spawns = require('map/get_map_spawns')
local set_player_position = require('map/set_player_position')

local function spawn_player()
  local spawns = get_map_spawns()
  local spawn = spawns[math.random(#spawns)]
  set_player_position(spawn.x, spawn.y)
end

return spawn_player

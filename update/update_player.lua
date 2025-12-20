local update_player_input = require('update/update_player_input')
local update_player_movement = require('update/update_player_movement')

local function update_player(p, input)
  update_player_input(p, input)
  update_player_movement(p)
end

return update_player

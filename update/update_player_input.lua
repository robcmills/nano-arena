local player_can_move = require('update/player_can_move')
local player_can_shoot = require('update/player_can_shoot')
local player_move = require('update/player_move')
local player_shoot = require('update/player_shoot')

local function update_player_input(p, input)
  if input.shoot and player_can_shoot(p) then
    player_shoot(p)
  end

  if player_can_move(p) then
    if input.left then
      player_move(p, 'left')
    elseif input.right then
      player_move(p, 'right')
    elseif input.up then
      player_move(p, 'up')
    elseif input.down then
      player_move(p, 'down')
    end
  end
end

return update_player_input

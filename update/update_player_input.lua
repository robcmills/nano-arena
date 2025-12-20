local g = require('g')
local move_player = require('update/move_player')

local function update_player_input(p, input)
  if g.player.last_move_time ~= nil then return end

  if input.left then
    move_player(p, 'left')
  elseif input.right then
    move_player(p, 'right')
  elseif input.up then
    move_player(p, 'up')
  elseif input.down then
    move_player(p, 'down')
  end
end

return update_player_input

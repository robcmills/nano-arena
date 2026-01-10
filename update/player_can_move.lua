---@param p PlayerState
local function player_can_move(p)
  return p.last_move_time == nil
end

return player_can_move

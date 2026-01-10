local g = require('g')

---@param p PlayerState
local function player_shoot(p)
  p.last_shoot_time = g.now
  g.debug = "SHOOT!"
end

return player_shoot

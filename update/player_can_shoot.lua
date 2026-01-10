local g = require('g')

---@param p PlayerState
local function player_can_shoot(p)
  return p.last_shoot_time == nil or
    (p.weapon ~= nil and g.now - p.last_shoot_time > p.weapon.cooldown)
end

return player_can_shoot

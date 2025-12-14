local g = require('g')

local function update_map(dt)
  g.map.sti:update(dt)
end

return update_map

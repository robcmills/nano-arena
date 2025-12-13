local g = require('g')

local function draw_map()
  if g.map ~= nil then
    g.map:draw()
  end
end

return draw_map

local g = require('g')

local function draw_debug()
  if g.debug then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(g.debug, 32, 32)
  end
end

return draw_debug

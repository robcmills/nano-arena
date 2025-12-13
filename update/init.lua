local g = require('g')

function love.update(dt)
  if g.map ~= nil then
    g.map:update(dt)
  end
end

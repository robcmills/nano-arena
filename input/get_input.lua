local g = require('g')

local function get_input()
  if g.is_test then
    -- return get_test_input() -- todo
  else
    return {
      down = love.keyboard.isDown('down'),
      left = love.keyboard.isDown('left'),
      right = love.keyboard.isDown('right'),
      up = love.keyboard.isDown('up'),
    }
  end
end

return get_input

local g = require('g')
local test = require('test')

local function get_input()
  if g.is_test then
    return test.current.input()
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

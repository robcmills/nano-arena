local g = require('g')
local inputs = require('test/inputs')
local load_game = require('load/load_game')

---@type Test
local test = {
  name = 'test1',
  load = function()
    load_game({ map = 'tiled/arena-map-2.lua' })
  end,
  update_pre = function()
    -- todo
  end,
  input = function()
    if g.frame == 1 then
      return inputs.right
    else
      return inputs.none
    end
  end,
  update_post = function()
    -- todo
  end,
}

return test

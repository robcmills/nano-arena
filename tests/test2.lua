local create_test_input_sequence = require('test/create_test_input_sequence')
local inputs = require('test/inputs')
local load_game = require('load/load_game')

local input_sequence = create_test_input_sequence({
  'left',
  'down',
})

local test_state = 'loading'

---@type Test
local test = {
  name = 'test2',
  load = function()
    load_game({ map = 'tiled/arena-map-3.lua' })
    test_state = 'running'
  end,
  update_pre = function()
    -- todo
  end,
  input = function()
    local input = input_sequence()
    if input then
      return input
    else
      test_state = 'done'
      return inputs.none
    end
  end,
  update_post = function()
    return test_state == 'done'
  end,
}

return test

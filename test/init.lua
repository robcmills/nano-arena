---@class Test
---@field name string Test name
---@field load function Called once before the test is run
---@field update_pre function Called each frame in update function after g.now and g.frame are updated but before everything else
---@field input function Called once per frame to get player input
---@field update_post function Called each frame after all updates and rendering are done

local test_state = {
  current = require('tests/test1'),
}

return test_state

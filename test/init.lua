local g = require('g')
local gif = require('util/gif')

---@class Test
---@field name string Test name
---@field load function Called once before the test is run
---@field update_pre function Called each frame in update function after g.now and g.frame are updated but before everything else
---@field input function Called once per frame to get player input
---@field update_post function Called each frame after all updates and rendering are done. Returns false if test is still running, true if test is finished.

---@class TestState
---@field current Test
---@field record boolean Whether to record video of test
---@field update_post function

---@type TestState
local test_state = {
  current = require('tests/test2'),
  load = function(self)
    self.current.load()
    if self.record then
      gif:start(g.canvas)
    end
  end,
  record = true,
  update_pre = function(self)
    self.current.update_pre()
  end,
  update_post = function(self)
    if self.current.update_post() then
      if self.record then
        gif:stop(self.current.name)
      end
      love.event.quit()
    else
      if self.record then
        gif:captureFrame()
      end
    end
  end,
}

return test_state

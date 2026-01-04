local g = require('g')
local get_gif_recorder = require('gif/get_gif_recorder')

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
  gif_recorder = get_gif_recorder(),
  load = function(self)
    self.current.load()
    if self.record then
      self.gif_recorder.init({
        canvas = g.canvas,
        filename = self.current.name,
        palette = g.palette,
      })
      self.gif_recorder.start()
    end
  end,
  record = true,
  update_pre = function(self)
    self.current.update_pre()
  end,
  update_post = function(self)
    if self.current.update_post() then
      if self.record then
        self.gif_recorder.stop()
      end
      love.event.quit()
    else
      if self.record then
        self.gif_recorder.captureFrame()
      end
    end
  end,
}

return test_state

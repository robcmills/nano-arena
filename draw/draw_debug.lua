local colors = require('colors')
local draw_text = require('draw/draw_text')
local g = require('g')
local settings = require('settings')
-- local draw_screen_center = require('draw/draw_screen_center')

local function draw_debug()
  if g.debug and g.draw_debug then
    draw_text({
      color = colors.white,
      limit = 256,
      text = g.debug,
      x = settings.debug_x,
      y = settings.debug_y,
    })
  end
  -- draw_screen_center()
end

return draw_debug

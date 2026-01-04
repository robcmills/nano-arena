local g = require('g')
local settings = require('settings')
-- local draw_screen_center = require('draw/draw_screen_center')

local function draw_debug()
  if g.debug then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(g.debug, settings.debug_x, settings.debug_y)
  end
  -- draw_screen_center()
end

return draw_debug

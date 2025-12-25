local g = require('g')
local theme = require('theme')

local function draw_background()
  love.graphics.setColor(theme.editor_background_color)
  love.graphics.rectangle('fill', 0, 0, g.canvas_width, g.canvas_height)
end

return draw_background

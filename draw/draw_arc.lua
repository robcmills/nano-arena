local reset_graphics = require('draw/reset_graphics')

---@class DrawArcOptions
---@field color RGB
---@field end_angle number
---@field fill? boolean
---@field radius number
---@field segments? number
---@field start_angle number
---@field type? 'pie' | 'open' | 'closed'
---@field x number
---@field y number

---@param options DrawArcOptions
local function draw_arc(options)
  local color = options.color
  local end_angle = options.end_angle
  local fill = options.fill == false and 'line' or 'fill'
  local radius = options.radius
  local segments = options.segments or 8
  local start_angle = options.start_angle
  local type = options.type or 'pie'
  local x = options.x
  local y = options.y

  love.graphics.setBlendMode('replace')
  love.graphics.setLineStyle('rough')
  love.graphics.setColor(color)
  love.graphics.arc(fill, type, x, y, radius, start_angle, end_angle, segments)

  reset_graphics()
end

return draw_arc

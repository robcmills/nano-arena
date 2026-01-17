---@class DrawLineOptions
---@field color RGB
---@field x1 number
---@field y1 number
---@field x2 number
---@field y2 number

---@param options DrawLineOptions
local function draw_line(options)
  local color = options.color
  local x1 = options.x1
  local y1 = options.y1
  local x2 = options.x2
  local y2 = options.y2

  love.graphics.setBlendMode('replace')
  love.graphics.setLineStyle('rough')  -- crisp pixel-perfect lines
  love.graphics.setColor(color)
  love.graphics.line(x1, y1, x2, y2)

  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
end

return draw_line

---@param options {color: RGB, fill?: boolean, height: number, width: number, x: number, y: number}
local function draw_rect(options)
  local color = options.color
  local fill = options.fill == false and 'line' or 'fill'
  local height = options.height
  local width = options.width
  local x = options.x
  local y = options.y

  love.graphics.setBlendMode('replace')
  love.graphics.setLineStyle('rough')  -- crisp pixel-perfect lines
  love.graphics.setColor(color)
  love.graphics.rectangle(fill, x, y, width, height)

  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
end

return draw_rect

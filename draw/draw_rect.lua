---@class DrawRectOptions
---@field color RGB
---@field fill? boolean
---@field height number
---@field rx? number The x-axis radius of each round corner. Cannot be greater than half the rectangle's width.
---@field ry? number The y-axis radius of each round corner. Cannot be greater than half the rectangle's height.
---@field segments? number The number of segments to use for drawing the arc. Defaults to 8.
---@field width number
---@field x number
---@field y number

---@param options DrawRectOptions
local function draw_rect(options)
  local color = options.color
  local fill = options.fill == false and 'line' or 'fill'
  local height = options.height
  local rx = options.rx or 0
  local ry = options.ry or 0
  local segments = options.segments
  local width = options.width
  local x = options.x
  local y = options.y

  love.graphics.setBlendMode('replace')
  love.graphics.setLineStyle('rough')  -- crisp pixel-perfect lines
  love.graphics.setColor(color)
  love.graphics.rectangle(fill, x, y, width, height, rx, ry, segments)

  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
end

return draw_rect

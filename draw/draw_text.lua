---@alias AlignMode 'center' | 'justify' | 'left' | 'right'

---@class DrawTextOptions
---@field align AlignMode?
---@field color RGB
---@field limit number? Wrap the line after this many horizontal pixels
---@field text string
---@field x number
---@field y number

---@param options DrawTextOptions
local function draw_text(options)
  local align = options.align or 'left'
  local color = options.color
  local limit = options.limit
  local text = options.text
  local x = options.x
  local y = options.y

  love.graphics.setColor(color)
  if limit then
    love.graphics.printf(text, x, y, limit, align)
  else
    love.graphics.print(text, x, y)
  end

  love.graphics.setColor(1, 1, 1)
end

return draw_text

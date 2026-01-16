---@param options {color: RGB, text: string, x: number, y: number}
local function draw_text(options)
  local color = options.color
  local text = options.text
  local x = options.x
  local y = options.y

  love.graphics.setColor(color)
  love.graphics.print(text, x, y)

  love.graphics.setColor(1, 1, 1)
end

return draw_text

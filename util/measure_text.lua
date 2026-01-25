---@class MeasureTextArgs
---@field text string
---@field max_width number Maximum width in pixels

---@param args MeasureTextArgs
---@return number, number Width and height of text
local function measure_text(args)
  local font = love.graphics.getFont()
  local width, lines = font:getWrap(args.text, args.max_width)
  local height = #lines * font:getHeight() * font:getLineHeight()
  return width, height
end

return measure_text

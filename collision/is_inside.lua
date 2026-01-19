---@class Rect
---@field height number
---@field width number
---@field x number
---@field y number

---@param options { x: number, y: number, rect: Rect }
local function is_inside(options)
  local x = options.x
  local y = options.y
  local rect = options.rect

  return x >= rect.x and x <= rect.x + rect.width and
         y >= rect.y and y <= rect.y + rect.height
end

return is_inside

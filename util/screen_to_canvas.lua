local g = require('g')

---@param screen_coord number
local function screen_to_canvas(screen_coord)
  return screen_coord / g.canvas_scale
end

return screen_to_canvas

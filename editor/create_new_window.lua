local get_canvas_dimensions = require('util/get_canvas_dimensions')
local round = require('util/round')

---@alias WindowPlacement "center" | "fullscreen"
---@param options {placement: WindowPlacement, width: number, height: number, title: string}
---@return WindowState
local function create_new_window(options)
  local x, y
  local w = options.width
  local h = options.height
  local canvas_w, canvas_h = get_canvas_dimensions()

  if options.placement == "center" then
    x = round((canvas_w - w) / 2)
    y = round((canvas_h - h) / 2)
  elseif options.placement == "fullscreen" then
    x = 0
    y = 0
    w = canvas_w
    h = canvas_h
  else
    -- Default to top-left
    x = 0
    y = 0
  end

  ---@type WindowState
  local window = {
    height = h,
    state = 'open',
    title = options.title,
    width = w,
    x = x,
    y = y,
  }

  return window
end

return create_new_window

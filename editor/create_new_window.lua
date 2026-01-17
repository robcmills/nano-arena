local get_canvas_dimensions = require('util/get_canvas_dimensions')
local editor = require('editor')
local round = require('util/round')

---@alias WindowPlacement "center" | "fullscreen"

---@class CreateWindowOptions
---@field height? number
---@field placement WindowPlacement
---@field title string
---@field width? number

---@param options CreateWindowOptions
---@return WindowState
local function create_new_window(options)
  local height = options.height or editor.window_default_height
  local placement = options.placement
  local width = options.width or editor.window_default_width

  -- validate options
  if placement == 'center' then
    assert(height, 'create_new_window: options.height is required for placement "center"')
    assert(width, 'create_new_window: options.width is required for placement "center"')
  end

  local canvas_w, canvas_h = get_canvas_dimensions()
  local x = 0
  local y = 0

  if placement == 'fullscreen' then
    height = canvas_h
    width = canvas_w
  end

  if placement == 'center' then
    x = round((canvas_w - width) / 2)
    y = round((canvas_h - height) / 2)
  end

  ---@type WindowState
  local window = {
    height = height,
    state = 'open',
    title = options.title,
    width = width,
    x = x,
    y = y,
  }

  return window
end

return create_new_window

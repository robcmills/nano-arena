local get_canvas_dimensions = require('util/get_canvas_dimensions')
local round = require('util/round')
local settings = require('settings')

local tile_size = settings.tile_size

---@alias WindowPlacement "center" | "fullscreen"

---@class CreateWindowOptions
---@field placement WindowPlacement
---@field tile_width? number
---@field tile_height? number
---@field title string

---@param options CreateWindowOptions
---@return WindowState
local function create_new_window(options)
  local placement = options.placement
  local tile_width = options.tile_width or 3
  local tile_height = options.tile_height or 3

  -- validate options
  if placement == 'center' then
    assert(tile_width, 'options.tile_width is required for placement "center"')
    assert(tile_height, 'options.tile_height is required for placement "center"')
  end

  local canvas_w, canvas_h = get_canvas_dimensions()

  if placement == 'fullscreen' then
    tile_width = math.floor(canvas_w / tile_size) - 2
    tile_height = math.floor(canvas_h / tile_size) - 2
  end

  local x = round((canvas_w - tile_width  * tile_size) / 2)
  local y = round((canvas_h - tile_height * tile_size) / 2)

  ---@type WindowState
  local window = {
    tile_height = tile_height,
    state = 'open',
    title = options.title,
    tile_width = tile_width,
    x = x,
    y = y,
  }

  return window
end

return create_new_window

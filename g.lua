---@type GameState
local g = {
  canvas = nil,
  canvas_height = 0,
  canvas_scale = 1,
  canvas_width = 0,
  draw_debug = true,
  fonts = nil,
  frame = 0,
  is_test = false,
  map = nil,
  now = 0,
  palette = nil,
  player = nil,
  state = 'editor',
}

return g

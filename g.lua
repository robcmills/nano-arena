---@class GameState
---@field canvas love.Canvas | nil Canvas for rendering
---@field canvas_scale number Scale factor for canvas rendering
---@field debug string? Renders at top left of screen if not nil.
---@field editor EditorState | nil Editor game state
---@field fonts FontsState | nil Fonts state
---@field frame number Frame counter
---@field is_test boolean Whether game is running in test mode
---@field map MapState | nil Map game state
---@field now number Current time in seconds
---@field player PlayerState | nil Player game state
---@field state 'game' | 'editor' Game state

---@class PlayerState
---@field dir string Current movement direction: 'up', 'down', 'left', 'right'
---@field flip_x boolean? Whether to flip sprite horizontally
---@field from_tile_x number? Starting tile X for movement interpolation
---@field from_tile_y number? Starting tile Y for movement interpolation
---@field last_move_time number? Timestamp of last movement start, nil if not moving
---@field map_pixel_x number Player X position in map pixels
---@field map_pixel_y number Player Y position in map pixels
---@field speed number Movement speed in pixels per second
---@field sprite_sheet love.Image Player sprite sheet image
---@field sprite_size number Size of each sprite in pixels
---@field sprites PlayerSprites Sprite quads for different directions
---@field tile_x number Player X tile position
---@field tile_y number Player Y tile position
---@field to_tile_x number? Target tile X for movement interpolation
---@field to_tile_y number? Target tile Y for movement interpolation

---@class PlayerSprites
---@field down love.Quad | nil Sprite quad for down direction
---@field left love.Quad | nil Sprite quad for left direction
---@field right love.Quad | nil Sprite quad for right direction
---@field up love.Quad | nil Sprite quad for up direction

---@class MapState
---@field map table? Loaded map data table
---@field sti table? STI map instance

---@class FontsState
---@field monogram FontInfo Monogram font information
---@field p8 FontInfo Pico-8 font information

---@class FontInfo
---@field char_height number Character height in pixels
---@field char_width number Character width in pixels
---@field font love.Font Love2D font object

---@type GameState
local g = {
  canvas = nil,
  canvas_scale = 1,
  fonts = nil,
  frame = 0,
  is_test = false,
  map = nil,
  now = 0,
  player = nil,
  state = 'editor',
}

return g

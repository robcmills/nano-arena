---@class Settings
---@field allow_void_suicide boolean Allow player to move into void
---@field button_padding_x number Button padding horizontal in pixels
---@field button_padding_y number Button padding vertical in pixels
---@field debug_x number Debug print X position in pixels
---@field debug_y number Debug print Y position in pixels
---@field grid_color [number, number, number] Grid color
---@field grid_size number Grid size in pixels
---@field player_move_speed number Player movement speed in pixels per second
---@field player_sprite_size number Player sprite size in pixels
---@field prompt_padding number Prompt padding in pixels
---@field prompt_max_width number Prompt width in pixels
---@field resolution number Canvas resolution in pixels
---@field tile_size number Tile size in pixels

---@type Settings
local settings = {
  allow_void_suicide = false,
  button_padding_x = 4,
  button_padding_y = 2,
  debug_x = 32,
  debug_y = 64,
  grid_color = {0.25, 0.25, 0.25}, -- todo: move to editor
  grid_size = 8, -- todo: move to editor
  player_move_speed = 100,
  player_sprite_size = 32,
  prompt_padding = 8,
  prompt_max_width = 256,
  resolution = 350, -- vertical resolution in pixels
  tile_size = 16,
}

return settings

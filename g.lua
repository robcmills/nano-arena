---@class GameState
---@field canvas love.Canvas | nil Canvas for rendering
---@field canvas_scale number Scale factor for canvas rendering
---@field editor EditorState | nil Editor game state
---@field fonts FontsState | nil Fonts state
---@field frame number Frame counter
---@field is_test boolean Whether game is running in test mode
---@field map MapState | nil Map game state
---@field now number Current time in seconds
---@field player PlayerState | nil Player game state

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

---@class EditorState
---@field char_width number Character width in pixels
---@field cursor_quad love.Quad Quad for cursor sprite
---@field menu_bar_colored_text (string|number)[]? Colored text array for menu bar
---@field menu_bar_height number? Height of menu bar in pixels
---@field menu_bar_items table<string, MenuBarItem>? Menu bar items by key
---@field menu_bar_order string[]? Ordered list of menu bar item keys
---@field menu_padding number? Padding for menu items in pixels
---@field menus table<string, Menu>? Menus by key
---@field opened_menu string? Currently opened menu key, nil if none
---@field spritesheet love.Image Editor spritesheet image

---@class MenuBarItem
---@field height number? Item height in pixels
---@field is_hovered boolean? Whether item is hovered
---@field key string Keyboard shortcut key
---@field label string Display label
---@field width number? Item width in pixels
---@field x number? X position in pixels
---@field y number? Y position in pixels

---@class Menu
---@field height number? Menu height in pixels
---@field items table<string, MenuItem> Menu items by key
---@field items_order string[] Ordered list of menu item keys
---@field width number? Menu width in pixels
---@field x number? X position in pixels
---@field y number? Y position in pixels

---@class MenuItem
---@field colored_text (string|number)[]? Colored text array for menu item
---@field height number? Item height in pixels
---@field is_hovered boolean? Whether item is hovered
---@field key string Keyboard shortcut key
---@field post_label string? Optional label text after key
---@field pre_label string? Optional label text before key
---@field width number? Item width in pixels
---@field x number? X position in pixels
---@field y number? Y position in pixels

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
  editor = nil,
  fonts = nil,
  frame = 0,
  is_test = false,
  map = nil,
  now = 0,
  player = nil,
}
return g

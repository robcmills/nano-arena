---@class EditorState
---@field char_width number Character width in pixels
---@field cursor_quad love.Quad? Quad for cursor sprite
---@field menu_bar_colored_text (string|number)[]? Colored text array for menu bar
---@field menu_bar_height number? Height of menu bar in pixels
---@field menu_bar_items table<string, MenuBarItem>? Menu bar items by key
---@field menu_bar_order string[]? Ordered list of menu bar item keys
---@field menu_padding number? Padding for menu items in pixels
---@field menus table<string, Menu>? Menus by key
---@field opened_menu string? Currently opened menu key, nil if none
---@field spritesheet love.Image? Editor spritesheet image

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

---@type EditorState
local editor = {
  char_width = 0,
  cursor_quad = nil,
  menu_bar_colored_text = nil,
  menu_bar_height = nil,
  menu_bar_items = nil,
  menu_bar_order = nil,
  menu_padding = nil,
  menus = nil,
  opened_menu = nil,
  spritesheet = nil,
}

return editor

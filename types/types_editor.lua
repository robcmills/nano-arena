---@class Arena -- aka level, map, world, etc.
---@field name string

---@class ArenaState
---@field arena Arena
---@field has_unsaved_changes boolean

---@class EditorState
---@field active_arena number? Currently active arena (index into arenas)
---@field arenas ArenaState[] Opened arenas (tabs)
---@field cursor_quad love.Quad? Quad for cursor sprite
---@field font FontInfo?
---@field menu_bar_colored_text (string|number)[]? Colored text array for menu bar
---@field menu_bar_height number Height of menu bar in pixels
---@field menu_bar_items table<string, MenuBarItem>? Menu bar items by key
---@field menu_bar_order string[]? Ordered list of menu bar item keys
---@field menu_padding_x number Horizontal padding for menu items in pixels
---@field menu_padding_y number Vertical padding for menu items in pixels
---@field menus table<string, Menu>? Menus by key
---@field opened_menu string? Currently opened menu key, nil if none
---@field sprites love.Quad[]? Editor sprite quads. Indexed left-to-right, top-to-bottom
---@field spritesheet love.Image? Editor spritesheet image
---@field tab_max_char_count number Number of characters in tab text (before ellipsification)
---@field tab_gap number Horizontal gap between tabs in pixels
---@field tabs TabState[] Tab positions and close button rects
---@field window_default_height number Default window height in pixels
---@field window_default_width number Default window width in pixels
---@field window_corner_radius number Window corner radius in pixels
---@field window_title_bar_height number Window title bar height in pixels (excluding borders)
---@field windows EditorWindows Windows states

---@class EditorWindows
---@field open OpenFileWindowState? Open file window state

---@class FileInfo
---@field last_modified? number The file's last modification time in seconds since the unix epoch, or nil if it can't be determined.
---@field name string File name
---@field size? number The size in bytes of the file, or nil if it can't be determined.

---@class Menu
---@field height number? Menu height in pixels
---@field items table<string, MenuItem> Menu items by key
---@field items_order string[] Ordered list of menu item keys
---@field width number? Menu width in pixels
---@field x number? X position in pixels
---@field y number? Y position in pixels

---@class MenuBarItem
---@field height number? Item height in pixels
---@field is_hovered boolean? Whether item is hovered
---@field key string Keyboard shortcut key
---@field label string Display label
---@field width number? Item width in pixels
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

---@class OpenFileWindowState : WindowState
---@field files FileInfo[] List of files and directories in current love filesystem directory path
---@field item_height number Item height in pixels
---@field scroll_offset_x number in canvas pixels
---@field scroll_offset_y number in canvas pixels
---@field scroll_velocity_x number
---@field scroll_velocity_y number

---@class Rect
---@field height number
---@field width number
---@field x number
---@field y number

---@class TabState
---@field close_button_rect Rect
---@field tab_rect Rect

---@class WindowState
---@field full_screen boolean Whether window is full screen
---@field height number Height in canvas pixels
---@field state 'closed' | 'open' Window state
---@field title string Window title
---@field width number Width in canvas pixels
---@field x number X position in pixels
---@field y number Y position in pixels

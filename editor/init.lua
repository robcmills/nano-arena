---@type EditorState
local editor = {
  arenas = {},
  cursor_quad = nil,
  font = nil,
  menu_bar_colored_text = nil,
  menu_bar_height = nil,
  menu_bar_items = nil,
  menu_bar_order = nil,
  menu_padding_x = nil,
  menu_padding_y = nil,
  menus = nil,
  opened_menu = nil,
  spritesheet = nil,
  window_default_height = 128,
  window_default_width = 128,
  window_corner_radius = 5,
  window_title_bar_height = 14,
  windows = {},
}

return editor

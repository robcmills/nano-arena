---@type EditorState
local editor = {
  arenas = {},
  cursor_quad = nil,
  font = nil,
  menu_bar_colored_text = nil,
  menu_bar_height = 0,
  menu_bar_items = nil,
  menu_bar_order = nil,
  menu_padding_x = 0,
  menu_padding_y = 0,
  menus = nil,
  opened_menu = nil,
  spritesheet = nil,
  tab_gap = 3,
  tabs = {},
  window_default_height = 128,
  window_default_width = 128,
  window_corner_radius = 5,
  window_title_bar_height = 14,
  windows = {},
}

return editor

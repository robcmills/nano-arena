local colors = require('colors')

---@class Theme
---@field editor_background_color RGB
---@field menu_background_color RGB
---@field menu_bar_background_color RGB
---@field menu_bar_highlight_background_color RGB
---@field menu_bar_text_highlight_color RGB
---@field menu_bar_text_normal_color RGB
---@field menu_text_highlight_color RGB
---@field menu_text_normal_color RGB
---@field tab_close_button_hover_background_color RGB
---@field tabs_active_background_color RGB
---@field tabs_inactive_background_color RGB
---@field text_directory_color RGB
---@field text_file_color RGB
---@field text_highlight_background_color RGB
---@field window_background_color RGB
---@field window_border_color RGB
---@field window_title_bar_background_color RGB
---@field window_title_text_color RGB

---@type Theme
local theme = {
  editor_background_color = colors.grey11,
  menu_background_color = colors.grey22,
  menu_bar_background_color = colors.grey22,
  menu_bar_border_color = colors.grey56,
  menu_bar_highlight_background_color = colors.blue,
  menu_bar_text_highlight_color = colors.p8.blue,
  menu_bar_text_normal_color = colors.grey89,
  menu_text_highlight_color = colors.p8.blue,
  menu_text_normal_color = colors.white,
  prompt_background_color = colors.grey22,
  tab_close_button_hover_background_color = colors.red67,
  tabs_active_background_color = colors.grey11,
  tabs_inactive_background_color = colors.grey33,
  tabs_text_color = colors.grey67,
  tabs_text_highlight_color = colors.grey89,
  text_directory_color = colors.cyan67,
  text_file_color = colors.white,
  text_highlight_background_color = colors.cyan33,
  window_background_color = colors.grey22,
  window_border_color = colors.cyan33,
  window_title_bar_background_color = colors.cyan33,
  window_title_bar_highlight_color = colors.cyan50,
  window_title_bar_shadow_color = colors.cyan17,
  window_title_text_color = colors.white,
}

return theme

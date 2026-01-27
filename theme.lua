local colors = require('colors')

---@class Theme
---@field button_background_color RGB
---@field button_outline_color RGB
---@field button_text_color RGB
---@field button_text_highlight_color RGB
---@field editor_background_color RGB
---@field menu_background_color RGB
---@field menu_bar_background_color RGB
---@field menu_bar_highlight_background_color RGB
---@field menu_bar_text_highlight_color RGB
---@field menu_bar_text_normal_color RGB
---@field menu_text_highlight_color RGB
---@field menu_text_normal_color RGB
---@field primary RGB
---@field primary_dark RGB
---@field primary_light RGB
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
  button_background_color = colors.grey33,
  button_outline_color = colors.grey78,
  button_text_color = colors.white,
  button_text_highlight_color = colors.azure67,
  editor_background_color = colors.grey11,
  menu_background_color = colors.grey22,
  menu_bar_background_color = colors.grey22,
  menu_bar_border_color = colors.grey56,
  menu_bar_highlight_background_color = colors.azure33,
  menu_bar_text_highlight_color = colors.azure67,
  menu_bar_text_normal_color = colors.grey89,
  menu_text_highlight_color = colors.azure67,
  menu_text_normal_color = colors.white,
  primary = colors.azure33,
  primary_dark = colors.azure_grey17,
  primary_light = colors.azure_grey67,
  prompt_background_color = colors.grey22,
  tab_close_button_hover_background_color = colors.red67,
  tabs_active_background_color = colors.grey11,
  tabs_inactive_background_color = colors.grey33,
  tabs_text_color = colors.grey67,
  tabs_text_highlight_color = colors.grey89,
  text_directory_color = colors.azure67,
  text_file_color = colors.white,
  text_highlight_background_color = colors.azure33,
  window_background_color = colors.grey22,
  window_border_color = colors.azure33,
  window_title_bar_background_color = colors.azure33,
  window_title_bar_highlight_color = colors.azure50,
  window_title_bar_shadow_color = colors.azure17,
  window_title_text_color = colors.white,
}

return theme

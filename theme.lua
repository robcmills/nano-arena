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
---@field window_background_color RGB
---@field window_border_color RGB
---@field window_title_bar_background_color RGB
---@field window_title_text_color RGB

---@type Theme
local theme = {
  editor_background_color = colors.very_dark_grey,
  menu_background_color = colors.dark_grey,
  menu_bar_background_color = colors.dark_grey,
  menu_bar_highlight_background_color = colors.blue,
  menu_bar_text_highlight_color = colors.p8.blue,
  menu_bar_text_normal_color = colors.white,
  menu_text_highlight_color = colors.p8.blue,
  menu_text_normal_color = colors.white,
  window_background_color = colors.dark_grey,
  window_border_color = colors.cyan33,
  window_title_bar_background_color = colors.cyan33,
  window_title_text_color = colors.white,
}

return theme

local draw_rect = require('draw/draw_rect')
local editor = require('editor')
local g = require('g')
local theme = require('theme')

local function draw_tabs()
  if #editor.arenas == 0 then return end

  -- background
  local canvas_width = g.canvas:getDimensions()
  draw_rect({
    color = theme.menu_bar_background_color,
    height = editor.menu_bar_height,
    width = canvas_width,
    x = 0,
    y = editor.menu_bar_height,
  })
  draw_rect({
    color = theme.menu_bar_border_color,
    height = 1,
    width = canvas_width,
    x = 0,
    y = editor.menu_bar_height * 2,
  })
end

return draw_tabs

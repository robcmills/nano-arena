local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local g = require('g')
local get_mouse_canvas_position = require('input/get_mouse_canvas_position')
local is_inside = require('collision/is_inside')
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
    y = editor.menu_bar_height - 1,
  })
  draw_rect({
    color = theme.menu_bar_border_color,
    height = 1,
    width = canvas_width,
    x = 0,
    y = editor.menu_bar_height * 2 - 1,
  })

  local x = 0
  local y = editor.menu_bar_height
  for i, arena in ipairs(editor.arenas) do
    local tab_width = editor.menu_padding_x * 2 + (#arena.name + 3) * editor.font.char_width
    local is_active = i == editor.active_arena
    if is_active then
      -- active tab border
      draw_rect({
        color = theme.menu_bar_border_color,
        fill = false,
        height = editor.menu_bar_height,
        width = tab_width,
        x = x,
        y = y,
      })
      -- active tab background
      draw_rect({
        color = theme.editor_background_color,
        height = editor.menu_bar_height,
        width = tab_width - 1,
        x = x,
        y = y,
      })
    else
      -- inactive tab background
      draw_rect({
        color = theme.tabs_inactive_background_color,
        height = editor.menu_bar_height - 1,
        width = tab_width,
        x = x - 1,
        y = y,
      })
    end

    -- hover highlight close button
    local mouse_x, mouse_y = get_mouse_canvas_position()
    local close_button_rect = {
      height = 7,
      width = 7,
      x = x + tab_width - editor.menu_padding_x - 7,
      y = y + 5,
    }
    if is_inside({ x = mouse_x, y = mouse_y, rect = close_button_rect }) and
        editor.opened_menu == nil then
      draw_rect({
        color = theme.tab_close_button_hover_background_color,
        height = close_button_rect.height,
        width = close_button_rect.width,
        x = close_button_rect.x,
        y = close_button_rect.y,
      })
    end

    -- tab text
    local text_color = is_active and
        theme.tabs_text_highlight_color or
        theme.tabs_text_color
    draw_text({
      color = text_color,
      text = arena.name .. "  x",
      x = x + editor.menu_padding_x,
      y = y + editor.menu_padding_y,
    })

    x = x + tab_width + editor.tab_gap
  end
end

return draw_tabs

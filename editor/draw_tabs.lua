local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local g = require('g')
local get_mouse_canvas_position = require('input/get_mouse_canvas_position')
local get_tab_text = require('editor/get_tab_text')
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

  local mouse_x, mouse_y = get_mouse_canvas_position()

  for i, arena in ipairs(editor.arenas) do
    local tab = editor.tabs[i]
    if not tab then break end

    local tab_rect = tab.tab_rect
    local close_button_rect = tab.close_button_rect
    local is_active = i == editor.active_arena

    if is_active then
      -- active tab border
      draw_rect({
        color = theme.menu_bar_border_color,
        fill = false,
        height = tab_rect.height,
        width = tab_rect.width,
        x = tab_rect.x,
        y = tab_rect.y,
      })
      -- active tab background
      draw_rect({
        color = theme.editor_background_color,
        height = tab_rect.height,
        width = tab_rect.width - 1,
        x = tab_rect.x,
        y = tab_rect.y,
      })
    else
      -- inactive tab background
      draw_rect({
        color = theme.tabs_inactive_background_color,
        height = tab_rect.height - 1,
        width = tab_rect.width,
        x = tab_rect.x - 1,
        y = tab_rect.y,
      })
    end

    -- hover highlight close button
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
      text = get_tab_text(arena.name) .. " x",
      x = tab_rect.x + editor.menu_padding_x,
      y = tab_rect.y + editor.menu_padding_y,
    })
  end
end

return draw_tabs

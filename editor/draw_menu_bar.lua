local draw_line = require('draw/draw_line')
local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local g = require('g')
local theme = require('theme')

local function draw_menu_bar()
  -- menu bar
  local canvas_width = g.canvas:getDimensions()
  draw_rect({
    color = theme.menu_bar_background_color,
    height = editor.menu_bar_height,
    width = canvas_width,
    x = 0,
    y = 0,
  })
  draw_line({
    color = theme.menu_bar_border_color,
    x1 = 0,
    y1 = editor.menu_bar_height,
    x2 = canvas_width,
    y2 = editor.menu_bar_height,
  })

  -- menu highlight
  local highlight_items = {}
  if editor.opened_menu then
    table.insert(highlight_items, editor.menu_bar_items[editor.opened_menu])
  end
  -- mouse hover
  for _, key in ipairs(editor.menu_bar_order) do
    local item = editor.menu_bar_items[key]
    if item.is_hovered then
      table.insert(highlight_items, item)
      break
    end
  end
  if #highlight_items > 0 then
    for _, item in ipairs(highlight_items) do
      love.graphics.setColor(theme.menu_bar_highlight_background_color)
      love.graphics.rectangle(
        'fill',
        item.x,
        item.y,
        item.width,
        item.height
      )
    end
  end

  -- menu text
  draw_text({
    text = editor.menu_bar_colored_text,
    x = editor.menu_padding_x,
    y = editor.menu_padding_y,
  })
end

return draw_menu_bar

local draw_line = require('draw/draw_line')
local draw_rect = require('draw/draw_rect')
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
    y1 = editor.menu_bar_height + 1,
    x2 = canvas_width,
    y2 = editor.menu_bar_height + 1,
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
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(
    editor.menu_bar_colored_text,
    editor.menu_padding_x,
    editor.menu_padding_y
  )
end

local function draw_open_menu()
  if editor.opened_menu == nil then return end

  local menu = editor.menus[editor.opened_menu]
  love.graphics.setColor(theme.menu_background_color)
  love.graphics.rectangle('fill', menu.x, menu.y, menu.width, menu.height)
  love.graphics.setColor(1, 1, 1)

  -- draw menu items
  for i, item_id in ipairs(menu.items_order) do
    local item = menu.items[item_id]
    if item.is_hovered then
      love.graphics.setColor(theme.menu_bar_highlight_background_color)
      love.graphics.rectangle('fill', item.x, item.y, item.width, item.height)
      love.graphics.setColor(1, 1, 1)
    end
    local x = menu.x + editor.menu_padding_x
    local y = menu.y + editor.menu_padding_y + (i-1) * editor.menu_bar_height
    love.graphics.print(item.colored_text, x, y)
  end
end

local function draw_menu()
  draw_menu_bar()
  draw_open_menu()
end

return draw_menu

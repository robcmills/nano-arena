local g = require('g')
local settings = require('settings')
local theme = require('theme')

local function draw_menu_bar()
  -- menu bar
  love.graphics.setColor(theme.menu_bar_background_color)
  love.graphics.rectangle('fill', 0, 0, settings.resolution, g.editor.menu_bar_height)

  -- draw highlight rectangle if a menu is opened
  if g.editor.opened_menu then
    local item = g.editor.menu_bar_items[g.editor.opened_menu]
    love.graphics.setColor(theme.menu_bar_highlight_background_color)
    love.graphics.rectangle('fill', item.x, 0, item.width, g.editor.menu_bar_height)
  end

  -- menu text
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(
    g.editor.menu_bar_colored_text,
    g.editor.menu_padding,
    g.editor.menu_padding
  )
end

local function draw_open_menu()
  if g.editor.opened_menu == nil then return end

  local menu = g.editor.menus[g.editor.opened_menu]
  love.graphics.setColor(theme.menu_background_color)
  love.graphics.rectangle('fill', menu.x, menu.y, menu.width, menu.height)
  love.graphics.setColor(1, 1, 1)

  -- if g.editor.selected_menu_item then
  --   local item = menu.items[g.editor.selected_menu_item]
  -- end

  -- draw menu items
  for i, item_id in ipairs(menu.items_order) do
    local item = menu.items[item_id]
    local x = menu.x + g.editor.menu_padding
    local y = menu.y + g.editor.menu_padding + (i-1) * g.editor.menu_bar_height
    love.graphics.print(item.colored_text, x, y)
  end
end

local function draw_menu()
  love.graphics.setFont(g.fonts.p8.font)
  draw_menu_bar()
  draw_open_menu()
end

return draw_menu

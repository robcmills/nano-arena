local colors = require('colors')
local g = require('g')
local settings = require('settings')

local function draw_menu_bar()
  -- menu bar
  love.graphics.setColor(g.editor.menu_bar_color)
  love.graphics.rectangle('fill', 0, 0, settings.resolution, g.editor.menu_bar_height)

  -- draw highlight rectangle if a menu is opened
  if g.editor.opened_menu then
    local item = g.editor.menu_bar_items[g.editor.opened_menu]
    love.graphics.setColor(colors.blue)
    love.graphics.rectangle('fill', item.x, 0, item.width, g.editor.menu_bar_height)
  end

  -- menu text
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(g.editor.menu_bar_text, g.editor.menu_padding, g.editor.menu_padding)
end

local function draw_open_menu()
  if g.editor.opened_menu == nil then return end

  local menu = g.editor.menus[g.editor.opened_menu]
  love.graphics.setColor(g.editor.menu_bar_color)
  love.graphics.rectangle('fill', menu.x, menu.y, menu.width, menu.height)
  love.graphics.setColor(1, 1, 1)
end

local function draw_menu()
  love.graphics.setFont(g.fonts.p8.font)
  draw_menu_bar()
  draw_open_menu()
end

return draw_menu

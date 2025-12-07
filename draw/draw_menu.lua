local colors = require('colors')
local g = require('g')
local settings = require('settings')

local menu_items = {
  file={
    {key="N",label="EW",id="new"},
    {key="O",label="PEN",id="open"},
    {key="S",label="AVE",id="save"},
  },
  edit={
    {key="U",label="NDO",id="undo"},
    {key="R",label="EDO",id="redo"},
    {key="C",label="OPY",id="copy"},
    {key="P",label="ASTE",id="paste"},
  },
  grid={
    {key="S",label="HOW",id="show_grid"},
    {key="H",label="IDE",id="hide_grid"},
    {key="C",label="OLOR",id="color"},
    {key="Z",label="IZE",id="size"},
  },
  help={
    {key="H",label="ELP",id="help"},
  }
}

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
end

local function draw_menu()
  love.graphics.setFont(g.fonts.p8.font)
  draw_menu_bar()
  draw_open_menu()
end

return draw_menu

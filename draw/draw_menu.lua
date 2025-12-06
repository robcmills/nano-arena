local colors = require('colors')
local g = require('g')
local settings = require('settings')

local function draw_menu()
  local menu_bar_color = colors.dark_grey
  local menu_height = 9
  local menu_padding = 2
  local char_width = 4

  -- menu items with their labels
  local menu_items = {
    {key = "F", label = "ILE", id = "file"},
    {key = "E", label = "DIT", id = "edit"},
    {key = "G", label = "RID", id = "grid"},
    {key = "S", label = "ETTINGS", id = "settings"},
    {key = "H", label = "ELP", id = "help"}
  }

  -- menu bar
  love.graphics.setColor(menu_bar_color)
  love.graphics.rectangle('fill', 0, 0, settings.resolution, menu_height)

  -- calculate positions and draw highlight if menu is open
  local x_offset = menu_padding
  local menu_positions = {}

  for _, item in ipairs(menu_items) do
    local item_width = (#item.key + #item.label) * char_width
    menu_positions[item.id] = {x = x_offset, width = item_width}
    x_offset = x_offset + item_width + (2 * char_width) -- 2 spaces between items
  end

  -- draw highlight rectangle if a menu is opened
  if g.editor.opened_menu and menu_positions[g.editor.opened_menu] then
    local pos = menu_positions[g.editor.opened_menu]
    love.graphics.setColor(colors.blue)
    love.graphics.rectangle('fill', pos.x - 2, 0, pos.width + 3, menu_height)
  end

  -- menu text
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1)
  local h = colors.p8.blue -- highlight color
  local n = colors.white -- normal color

  local colored_text = {}
  x_offset = menu_padding

  for i, item in ipairs(menu_items) do
    local is_open = (g.editor.opened_menu == item.id)
    local key_color = is_open and colors.white or h
    local text_color = is_open and colors.white or n

    table.insert(colored_text, key_color)
    table.insert(colored_text, item.key)
    table.insert(colored_text, text_color)
    table.insert(colored_text, item.label)

    if i < #menu_items then
      table.insert(colored_text, n)
      table.insert(colored_text, "  ")
    end
  end

  love.graphics.print(colored_text, menu_padding, menu_padding)
end

return draw_menu

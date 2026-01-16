local draw_editor_sprite = require('editor/draw_editor_sprite')
local draw_text = require('draw/draw_text')
local settings = require('settings')
local theme = require('theme')

local tile_size = settings.tile_size

---@class DrawSpriteWindowOptions
---@field tile_height number
---@field tile_width number
---@field title string
---@field x number
---@field y number

---@param options DrawSpriteWindowOptions
local function draw_sprite_window(options)
  local tile_width = options.tile_width
  local tile_height = options.tile_height
  local x = options.x
  local y = options.y
  local title = options.title

  for row = 1, tile_height do
    for col = 1, tile_width do
      local index

      if row == 1 then
        -- Top row
        if col == 1 then
          index = 9 -- top-left corner
        elseif col == tile_width then
          index = 11 -- top-right corner
        else
          index = 10 -- top edge
        end
      elseif row == tile_height then
        -- Bottom row
        if col == 1 then
          index = 25 -- bottom-left corner
        elseif col == tile_width then
          index = 27 -- bottom-right corner
        else
          index = 26 -- bottom edge
        end
      else
        -- Middle rows
        if col == 1 then
          index = 17 -- left edge
        elseif col == tile_width then
          index = 19 -- right edge
        else
          index = 18 -- center
        end
      end

      draw_editor_sprite({
        index = index,
        x = x + (col - 1) * tile_size,
        y = y + (row - 1) * tile_size,
      })
    end
  end

  -- title text
  draw_text({
    color = theme.window_title_text_color,
    text = ' ' .. title,
    x = x,
    y = y,
  })
end

return draw_sprite_window

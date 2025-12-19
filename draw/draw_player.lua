local g = require('g')
local get_screen_center = require('util/get_screen_center')
local settings = require('settings')
-- local tile_to_pixel = require('util/tile_to_pixel')

local function draw_player()
  local x, y = get_screen_center()
  local offset = settings.tile_size / 2
  love.graphics.draw(g.player.sprite_sheet, g.player.sprites.right, x - offset, y - offset)
end

return draw_player

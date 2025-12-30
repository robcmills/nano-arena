local g = require('g')
local tile_to_pixel = require('map/tile_to_pixel')

local function set_player_position(tile_x, tile_y)
  g.player.tile_x = tile_x
  g.player.tile_y = tile_y
  g.player.map_pixel_x = tile_to_pixel(tile_x)
  g.player.map_pixel_y = tile_to_pixel(tile_y)
end

return set_player_position

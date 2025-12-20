local g = require('g')

local function get_player_center()
  local offset = g.player.sprite_size / 2
  return g.player.map_pixel_x + offset, g.player.map_pixel_y + offset
end

return get_player_center

local g = require('g')
local get_map_translation = require('map/get_map_translation')
local get_player_center = require('util/get_player_center')

local function draw_map()
  local player_center_x, player_center_y = get_player_center()
  local offset = g.player.sprite_size / 4 + 1
  g.map.sti:draw(get_map_translation(player_center_x - offset, player_center_y - offset))
end

return draw_map

local g = require('g')
local get_map_translation = require('map/get_map_translation')
local get_player_center = require('util/get_player_center')

local function draw_map()
  g.map.sti:draw(get_map_translation(get_player_center()))
end

return draw_map

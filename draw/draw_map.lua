local g = require('g')
local get_map_center = require('map/get_map_center')
local get_map_translation = require('map/get_map_translation')

local function draw_map()
  g.map.sti:draw(get_map_translation(get_map_center(g.map)))
end

return draw_map

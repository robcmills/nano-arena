local g = require('g')
local sti = require('sti')

local function load_game()
  g.map = sti('tiled/arena-map-2.lua')
end

return load_game

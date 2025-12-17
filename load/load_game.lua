local load_map = require('load/load_map')
local load_player = require('load/load_player')

local function load_game()
  load_map('tiled/arena-map-2.lua')
  load_player()
end

return load_game

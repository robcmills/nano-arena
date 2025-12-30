local g = require('g')
local load_map = require('load/load_map')
local load_player = require('load/load_player')
local spawn_player = require('load/spawn_player')

local function load_game(args)
  args = args or {}
  g.frame = 0
  g.now = 0
  load_map(args.map or 'tiled/arena-map-2.lua')
  load_player()
  spawn_player()
end

return load_game

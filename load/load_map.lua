local g = require('g')
local sti = require('sti')

local function load_map(map_path)
  g.map = love.filesystem.load(map_path)()
  g.map.sti = sti(map_path)
end

return load_map

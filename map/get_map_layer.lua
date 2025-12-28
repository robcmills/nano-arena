local g = require('g')

local function get_map_layer(name)
  for _, layer in ipairs(g.map.layers) do
    if layer.name == name then
      return layer
    end
  end
end

return get_map_layer

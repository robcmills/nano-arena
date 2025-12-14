local function get_map_object(object_id, map)
  for _, layer in ipairs(map.layers) do
    if layer.type == "objectgroup" then
      for _, object in ipairs(layer.objects) do
        if object.id == object_id then
          return object
        end
      end
    end
  end
end

return get_map_object

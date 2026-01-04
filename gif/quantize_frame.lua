local ffi = require('ffi')

-- Direct calculation assuming 6x6x6 cube (see gif/generate_palette)
local function find_closest_color(r, g, b)
  local ri = math.floor(r / 255 * 5 + 0.5)
  local gi = math.floor(g / 255 * 5 + 0.5)
  local bi = math.floor(b / 255 * 5 + 0.5)
  return ri * 36 + gi * 6 + bi
end

--- @class QuantizeFrameArgs
--- @field color_to_index? table
--- @field imageData love.ImageData
--- @field height number
--- @field width number

--- @param args QuantizeFrameArgs
local function quantize_frame(args)
  local color_to_index = args.color_to_index
  local imageData = args.imageData
  local height = args.height
  local width = args.width

  local indexedData = {}
  local pointer = ffi.cast("uint8_t*", imageData:getFFIPointer())

  for i = 0, width * height - 1 do
    local offset = i * 4
    local r = pointer[offset]
    local g = pointer[offset + 1]
    local b = pointer[offset + 2]

    if color_to_index then
      local key = r * 65536 + g * 256 + b
      indexedData[i + 1] = color_to_index[key] or 0
    else
      local index = find_closest_color(r, g, b)
      table.insert(indexedData, index)
    end
  end

  return indexedData
end

return quantize_frame

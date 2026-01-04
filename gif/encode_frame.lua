local compress_lzw = require('gif/compress_lzw')
local constants = require('gif/constants')
local quantize_frame = require('gif/quantize_frame')

--- @class EncodeFrameArgs
--- @field color_to_index? table
--- @field frameIndex number
--- @field imageData love.ImageData
--- @field height number
--- @field profiler Profiler
--- @field width number

--- @param args EncodeFrameArgs
local function encode_frame(args)
  local color_to_index = args.color_to_index
  local frameIndex = args.frameIndex
  local height = args.height
  local imageData = args.imageData
  local profiler = args.profiler
  local width = args.width

  -- Convert image to indexed color
  profiler.start_section("Frame " .. frameIndex .. " - Color Quantization")
  local indexedData = quantize_frame({
    color_to_index = color_to_index,
    imageData = imageData,
    height = height,
    width = width,
  })
  profiler.end_section("Frame " .. frameIndex .. " - Color Quantization")

  -- Image Data (LZW-compressed)
  profiler.start_section("Frame " .. frameIndex .. " - LZW Compression")
  local compressed = compress_lzw(indexedData, constants.min_code_size)
  profiler.end_section("Frame " .. frameIndex .. " - LZW Compression")

  return compressed
end

return encode_frame

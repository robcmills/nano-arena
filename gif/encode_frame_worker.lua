local ffi = require('ffi')
local compress_lzw = require('gif/compress_lzw')
local constants = require('gif/constants')
local quantize_frame = require('gif/quantize_frame')

ffi.cdef[[
  typedef struct { uint8_t r, g, b, a; } RGBA;
]]

local inputChannel = love.thread.getChannel("gif_encode_input")
local outputChannel = love.thread.getChannel("gif_encode_output")

while true do
  local job = inputChannel:demand()

  if job.command == "stop" then
    break
  end

  if job.command == "encode" then
    -- Reconstruct pixel data from shared memory
    local pixels = ffi.cast("RGBA*", ffi.cast("uintptr_t", job.bufferAddress))

    -- Create a temporary table to hold pixel data for quantization
    -- quantize_frame expects to read pixels, so we create an adapter
    local pixelAdapter = {
      getWidth = function() return job.width end,
      getHeight = function() return job.height end,
      getPixel = function(self, x, y)
        local idx = y * job.width + x
        local pixel = pixels[idx]
        return pixel.r / 255, pixel.g / 255, pixel.b / 255, pixel.a / 255
      end
    }

    -- Convert image to indexed color
    local indexedData = quantize_frame({
      color_to_index = job.color_to_index,
      imageData = pixelAdapter,
      height = job.height,
      width = job.width,
    })

    -- Image Data (LZW-compressed)
    local compressed = compress_lzw(indexedData, constants.min_code_size)

    -- Send result back
    outputChannel:push({
      frameIndex = job.frameIndex,
      compressed = compressed,
      bufferAddress = job.bufferAddress, -- Pass back for cleanup
    })
  end
end

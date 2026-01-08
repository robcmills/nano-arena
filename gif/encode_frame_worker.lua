local compress_lzw = require('gif/compress_lzw')
local constants = require('gif/constants')
local quantize_frame = require('gif/quantize_frame')

local inputChannel = love.thread.getChannel("gif_encode_input")
local outputChannel = love.thread.getChannel("gif_encode_output")

while true do
  local job = inputChannel:demand()

  if job.command == "stop" then
    break
  end

  if job.command == "encode" then
    -- Convert image to indexed color using shared buffer address
    local indexedData = quantize_frame({
      color_to_index = job.color_to_index,
      bufferAddress = job.bufferAddress,
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

local GifRecorder = {
  recording = false,
  frames = {},
  canvas = nil,
  delay = 1 / 60, -- 60 FPS
}

-- Simple GIF encoder (basic implementation)
local function encodeGIF(frames, width, height, delay)
  local gif = {}

  -- GIF Header
  table.insert(gif, "GIF89a")

  -- Logical Screen Descriptor
  table.insert(gif, string.char(
    width % 256, math.floor(width / 256),
    height % 256, math.floor(height / 256),
    0xF7,     -- Global color table, 256 colors
    0,        -- Background color index
    0         -- Pixel aspect ratio
  ))

  -- Global Color Table (256 colors - simple palette)
  for i = 0, 255 do
    local r = math.floor((i % 8) * 255 / 7)
    local g = math.floor((math.floor(i / 8) % 8) * 255 / 7)
    local b = math.floor(math.floor(i / 64) * 255 / 3)
    table.insert(gif, string.char(r, g, b))
  end

  -- Netscape Extension (for looping)
  table.insert(gif, string.char(0x21, 0xFF, 0x0B))
  table.insert(gif, "NETSCAPE2.0")
  table.insert(gif, string.char(0x03, 0x01, 0x00, 0x00, 0x00))

  -- Encode each frame
  for _, frameData in ipairs(frames) do
    -- Graphic Control Extension
    local delayCs = math.floor(delay * 100)
    table.insert(gif, string.char(
      0x21, 0xF9, 0x04,
      0x04,       -- Disposal method
      delayCs % 256, math.floor(delayCs / 256),
      0, 0
    ))

    -- Image Descriptor
    table.insert(gif, string.char(
      0x2C,
      0, 0, 0, 0,       -- Position
      width % 256, math.floor(width / 256),
      height % 256, math.floor(height / 256),
      0
    ))

    -- LZW Compressed image data (simplified - uses minimum compression)
    table.insert(gif, string.char(8))     -- LZW minimum code size

    -- This is a simplified encoder - for production use a proper LZW library
    local pixels = {}
    for y = 1, height do
      for x = 1, width do
        local r, g, b = frameData:getPixel(x - 1, y - 1)
        -- Quantize to 256 color palette
        local colorIndex = math.floor(r * 7) +
            math.floor(g * 7) * 8 +
            math.floor(b * 3) * 64
        table.insert(pixels, colorIndex)
      end
    end

    -- Simple block encoding (not true LZW - placeholder)
    local blockSize = 255
    for i = 1, #pixels, blockSize do
      local block = {}
      for j = i, math.min(i + blockSize - 1, #pixels) do
        table.insert(block, string.char(pixels[j]))
      end
      table.insert(gif, string.char(#block))
      table.insert(gif, table.concat(block))
    end
    table.insert(gif, string.char(0))     -- Block terminator
  end

  -- GIF Trailer
  table.insert(gif, string.char(0x3B))

  return table.concat(gif)
end

function GifRecorder:start(canvas)
  self.recording = true
  self.frames = {}
  self.canvas = canvas
  print("GIF Recording started...")
end

function GifRecorder:captureFrame()
  if not self.recording then return end

  local imageData = self.canvas:newImageData()
  table.insert(self.frames, imageData)
end

function GifRecorder:stop(filename)
  if not self.recording then return end

  self.recording = false
  filename = (filename or "recording") .. ".gif"

  local width = self.canvas:getWidth()
  local height = self.canvas:getHeight()

  print(string.format("Encoding %d frames...", #self.frames))

  local gifData = encodeGIF(self.frames, width, height, self.delay)

  love.filesystem.write(filename, gifData)
  print("Saved to: " .. love.filesystem.getSaveDirectory() .. "/" .. filename)

  self.frames = {}
end

return GifRecorder

local encode_gif = require('util/encode')

local GifRecorder = {
  recording = false,
  frames = {},
  canvas = nil,
  delay = 1 / 60, -- 60 FPS
}

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

  local gifData = encode_gif({
    frames = self.frames,
    width = width,
    height = height,
    delay = self.delay
  })

  love.filesystem.write(filename, gifData)
  print("Saved to: " .. love.filesystem.getSaveDirectory() .. "/" .. filename)

  self.frames = {}
end

return GifRecorder

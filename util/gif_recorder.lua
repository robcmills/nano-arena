local encode_gif = require('util/encode')

--- @class GifRecorderArgs
--- @field fps? number

--- @param args GifRecorderArgs
local function get_gif_recorder(args)
  local state = {
    canvas = nil,
    delay = 1 / (args.fps or 60),
    frames = {},
    recording = false,
  }

  --- @param canvas love.Canvas
  local function start(canvas)
    state.canvas = canvas
    state.recording = true
    state.frames = {}
    print("GIF Recording started...")
  end

  local function capture_frame()
    if not state.recording then return end
    table.insert(state.frames, state.canvas:newImageData())
  end

  local function stop(filename)
    if not state.recording then return end

    local width = state.canvas:getWidth()
    local height = state.canvas:getHeight()

    print(string.format("Encoding %d frames...", #state.frames))
    local gifData = encode_gif({
      frames = state.frames,
      width = width,
      height = height,
      delay = state.delay
    })

    local path = filename .. ".gif"
    love.filesystem.write(path, gifData)
    print("Saved to: " .. love.filesystem.getSaveDirectory() .. "/" .. path)

    state.frames = {}
    state.recording = false
  end

  return {
    captureFrame = capture_frame,
    start = start,
    stop = stop,
  }
end

return get_gif_recorder

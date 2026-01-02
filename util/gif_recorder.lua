local encode_gif = require('util/encode')

--- @class GifRecorderArgs
--- @field canvas love.Canvas
--- @field filename? string
--- @field fps? number
--- @field palette? RGB[]

local function get_gif_recorder()
  local state = {
    canvas = nil,
    delay = 1 / 60,
    frames = {},
    recording = false,
  }

  --- @param args GifRecorderArgs
  local function init(args)
    state.canvas = args.canvas
    if args.fps then
      state.delay = 1 / args.fps
    end
    state.filename = (args.filename or "recording") .. ".gif"
    state.frames = {}
    state.palette = args.palette
  end

  local function start()
    state.frames = {}
    state.recording = true
    print("GIF Recording started...")
  end

  local function capture_frame()
    if not state.recording then return end
    table.insert(state.frames, state.canvas:newImageData())
  end

  local function stop()
    if not state.recording then return end

    print(string.format("Encoding %d frames...", #state.frames))
    local gifData = encode_gif({
      delay = state.delay,
      frames = state.frames,
      height = state.canvas:getHeight(),
      palette = state.palette,
      width = state.canvas:getWidth(),
    })

    love.filesystem.write(state.filename, gifData)
    print("Saved to: " .. love.filesystem.getSaveDirectory() .. "/" .. state.filename)

    state.frames = {}
    state.recording = false
  end

  return {
    captureFrame = capture_frame,
    init = init,
    start = start,
    stop = stop,
  }
end

return get_gif_recorder

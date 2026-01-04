local encode_frame = require('gif/encode_frame')
local encode_gif = require('gif/encode_gif')
local get_color_to_index = require('gif/get_color_to_index')
local get_profiler = require('util/get_profiler')

--- @class GifRecorderState
--- @field canvas love.Canvas | nil
--- @field color_to_index? table
--- @field delay number
--- @field frames table
--- @field filename string
--- @field frame_index number
--- @field palette? RGB[]
--- @field profiler Profiler
--- @field recording boolean

--- @class GifRecorderInitArgs
--- @field canvas love.Canvas
--- @field filename? string
--- @field fps? number
--- @field palette? RGB[]

local function get_gif_recorder()
  --- @type GifRecorderState
  local state = {
    canvas = nil,
    delay = 1 / 60,
    filename = "recording.gif",
    frame_index = 1,
    frames = {},
    profiler = get_profiler(),
    recording = false,
  }

  --- @param args GifRecorderInitArgs
  local function init(args)
    state.canvas = args.canvas
    if args.fps then
      state.delay = 1 / args.fps
    end
    state.filename = (args.filename or "recording") .. ".gif"
    state.frames = {}
    state.palette = args.palette
    if args.palette then
      state.color_to_index = get_color_to_index(args.palette)
    end
  end

  local function start()
    state.frames = {}
    state.recording = true
    print("GIF Recording started...")
  end

  local function capture_frame()
    if not state.recording then return end

    table.insert(state.frames, encode_frame({
      color_to_index = state.color_to_index,
      frameIndex = state.frame_index,
      height = state.canvas:getHeight(),
      imageData = state.canvas:newImageData(),
      profiler = state.profiler,
      width = state.canvas:getWidth(),
    }))
    state.frame_index = state.frame_index + 1
  end

  local function stop()
    if not state.recording then return end

    print(string.format("Encoding %d frames...", #state.frames))
    local gif = encode_gif({
      delay = state.delay,
      frames = state.frames,
      height = state.canvas:getHeight(),
      palette = state.palette,
      profiler = state.profiler,
      width = state.canvas:getWidth(),
    })

    love.filesystem.write(state.filename, gif)
    print("Saved to: " .. love.filesystem.getSaveDirectory() .. "/" .. state.filename)

    state.frame_index = 0
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

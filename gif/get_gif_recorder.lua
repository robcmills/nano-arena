local ffi = require('ffi')
local encode_gif = require('gif/encode_gif')
local get_color_to_index = require('gif/get_color_to_index')
local get_profiler = require('util/get_profiler')

ffi.cdef[[
  void* malloc(size_t size);
  void free(void* ptr);
  void* memcpy(void* dest, const void* src, size_t n);
  typedef struct { uint8_t r, g, b, a; } RGBA;
]]

--- @class GifRecorderState
--- @field canvas love.Canvas | nil
--- @field color_to_index? table
--- @field delay number
--- @field frames table
--- @field filename string
--- @field frame_index number
--- @field inputChannel love.Channel
--- @field outputChannel love.Channel
--- @field palette? RGB[]
--- @field profiler Profiler
--- @field recording boolean
--- @field sharedBuffers table
--- @field thread love.Thread

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
    inputChannel = love.thread.getChannel("gif_encode_input"),
    outputChannel = love.thread.getChannel("gif_encode_output"),
    profiler = get_profiler(),
    recording = false,
    sharedBuffers = {},
    thread = love.thread.newThread("gif/encode_frame_worker.lua"),
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
    state.frame_index = 1
    state.recording = true
    state.sharedBuffers = {}

    state.thread:start()

    print("GIF Recording started...")
  end

  local function capture_frame()
    if not state.recording then return end

    local width = state.canvas:getWidth()
    local height = state.canvas:getHeight()
    local imageData = state.canvas:newImageData()

    -- Allocate shared buffer (lives outside Lua's memory management)
    local frameSize = width * height * 4
    local sharedBuffer = ffi.C.malloc(frameSize)

    -- Copy frame data to shared buffer
    local dest = ffi.cast("RGBA*", sharedBuffer)
    local src = ffi.cast("RGBA*", imageData:getFFIPointer())
    ffi.C.memcpy(dest, src, frameSize)

    -- Pass the pointer address as a number to the worker thread
    state.inputChannel:push({
      command = "encode",
      bufferAddress = tonumber(ffi.cast("uintptr_t", sharedBuffer)),
      color_to_index = state.color_to_index,
      frameIndex = state.frame_index,
      frameSize = frameSize,
      height = height,
      width = width,
    })

    -- Track the buffer for later cleanup
    table.insert(state.sharedBuffers, sharedBuffer)

    state.frame_index = state.frame_index + 1
  end

  local function stop()
    if not state.recording then return end

    local frameCount = state.frame_index - 1
    print(string.format("Waiting for %d frames to finish encoding...", frameCount))

    state.profiler.start_section("Wait for thread to finish")
    -- Collect all encoded frames from the worker thread
    local encodedFrames = {}
    for i = 1, frameCount do
      local result = state.outputChannel:demand() -- Block until result is available
      encodedFrames[result.frameIndex] = result.compressed

      -- Free the shared buffer
      local bufferPtr = ffi.cast("void*", ffi.cast("uintptr_t", result.bufferAddress))
      ffi.C.free(bufferPtr)
    end

    -- Stop the worker thread
    state.inputChannel:push({ command = "stop" })
    state.thread:wait()

    state.profiler.end_section("Wait for thread to finish")

    -- Create new thread for next recording
    state.thread = love.thread.newThread("gif/encode_frame_worker.lua")

    print(string.format("Encoding %d frames into GIF...", frameCount))
    state.profiler.start_section("Encoding gif")
    local gif = encode_gif({
      delay = state.delay,
      frames = encodedFrames,
      height = state.canvas:getHeight(),
      palette = state.palette,
      profiler = state.profiler,
      width = state.canvas:getWidth(),
    })

    love.filesystem.write(state.filename, gif)
    print("Saved to: " .. love.filesystem.getSaveDirectory() .. "/" .. state.filename)

    state.profiler.end_section("Encoding gif")
    state.profiler.print_profile()

    state.frame_index = 1
    state.frames = {}
    state.sharedBuffers = {}
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

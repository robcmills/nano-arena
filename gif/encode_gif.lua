local encode_frame = require('gif/encode_frame')
local generate_palette = require('gif/generate_palette')
local get_profiler = require('util/get_profiler')

-- ============================================
-- Helper Functions for Writing Data
-- ============================================

---@param tbl table
local function get_write_byte(tbl)
  ---@param value number
  return function(value)
    table.insert(tbl, string.char(value % 256))
  end
end

---@param tbl table
local function get_write_word(tbl)
  local write_byte = get_write_byte(tbl)
  ---@param value number
  return function(value)
    write_byte(value % 256)
    write_byte(math.floor(value / 256) % 256)
  end
end

---@param tbl table
local function get_write_string(tbl)
  ---@param str string
  return function(str)
    table.insert(tbl, str)
  end
end

-- ============================================
-- Color Quantization
-- ============================================


--- @alias RGB [number, number, number]

--- @param out table
--- @param palette? RGB[]
local function write_global_color_table(out, palette)
  local write_byte = get_write_byte(out)

  -- Packed field:
  local gctFlag = 1  -- Global Color Table Flag: 1 (yes)
  local colorRes = 7 -- Color Resolution: 7 (8 bits per channel)
  local sortFlag = 0 -- Sort Flag: 0 (not sorted)
  local gctSize = 7  -- Size of Global Color Table: 7 (256 colors = 2^(7+1))
  local packed =
      (gctFlag * 128) +
      (colorRes * 16) +
      (sortFlag * 8) +
      gctSize
  write_byte(packed)
  write_byte(0) -- Background color index
  write_byte(0) -- Pixel aspect ratio (zero for no aspect ratio info)

  if palette then
    for i = 1, 256 do
      if palette[i] then
        write_byte(palette[i][1])
        write_byte(palette[i][2])
        write_byte(palette[i][3])
      else
        write_byte(0)
        write_byte(0)
        write_byte(0)
      end
    end
  else
    local global_palette = generate_palette()
    for i = 0, 255 do
      write_byte(global_palette[i][1])
      write_byte(global_palette[i][2])
      write_byte(global_palette[i][3])
    end
  end
end

--- If palette is provided, build a fast lookup table
--- @param palette? RGB[]
local function get_color_to_index(palette)
  if not palette then return end

  local color_to_index = {}
  local palette_size = #palette

  for i = 1, palette_size do
    local c = palette[i]
    local key = c[1] * 65536 + c[2] * 256 + c[3]
    color_to_index[key] = i - 1
  end

  return color_to_index
end

--- @class WriteFrameArgs
--- @field color_to_index? table
--- @field delayTime number
--- @field frameIndex number
--- @field frames_count number
--- @field height number
--- @field imageData love.ImageData
--- @field out table
--- @field profiler Profiler
--- @field width number

--- @param args WriteFrameArgs
local function write_frame(args)
  local color_to_index = args.color_to_index
  local delayTime = args.delayTime
  local frameIndex = args.frameIndex
  local frames_count = args.frames_count
  local height = args.height
  local imageData = args.imageData
  local out = args.out
  local profiler = args.profiler
  local width = args.width

  local write_byte = get_write_byte(out)
  local write_word = get_write_word(out)

  -- Graphic Control Extension (for timing and transparency)
  if frames_count > 1 or delayTime > 0 then
    write_byte(0x21) -- Extension introducer
    write_byte(0xF9) -- Graphic control label
    write_byte(4)    -- Block size

    -- Packed field:
    -- - Reserved: 0 (3 bits)
    -- - Disposal Method: 0 (no disposal specified)
    -- - User Input Flag: 0 (no user input)
    -- - Transparent Color Flag: 0 (no transparency)
    write_byte(0)

    write_word(delayTime) -- Delay time in hundredths of a second
    write_byte(0)         -- Transparent color index (unused)
    write_byte(0)         -- Block terminator
  end

  -- Image Descriptor
  write_byte(0x2C)   -- Image separator
  write_word(0)      -- Left position
  write_word(0)      -- Top position
  write_word(width)  -- Image width
  write_word(height) -- Image height

  -- Packed field:
  -- - Local Color Table Flag: 0 (use global)
  -- - Interlace Flag: 0 (not interlaced)
  -- - Sort Flag: 0
  -- - Reserved: 0 (2 bits)
  -- - Size of Local Color Table: 0 (no local table)
  write_byte(0)

  local minCodeSize = 8 -- 8 bits for 256-color palette
  write_byte(minCodeSize)

  local encoded = encode_frame({
    color_to_index = color_to_index,
    frameIndex = frameIndex,
    height = height,
    imageData = imageData,
    minCodeSize = minCodeSize,
    profiler = profiler,
    width = width,
  })

  -- Write encoded data in sub-blocks (max 255 bytes each)
  local pos = 1
  while pos <= #encoded do
    local blockSize = math.min(255, #encoded - pos + 1)
    write_byte(blockSize)
    for i = pos, pos + blockSize - 1 do
      write_byte(encoded[i])
    end
    pos = pos + blockSize
  end

  write_byte(0) -- Block terminator
end

--- @class EncodeGifArgs
--- @field delay number
--- @field frames love.ImageData[]
--- @field height number
--- @field palette? RGB[]
--- @field width number

--- @param args EncodeGifArgs
local function encode_gif(args)
  local delay = args.delay
  local frames = args.frames
  local height = args.height
  local palette = args.palette
  if palette then
    assert(#palette <= 256, "Palette must be no more than 256 colors")
  end
  local width = args.width

  local profiler = get_profiler()

  -- Convert delay from seconds to hundredths of a second (GIF time unit)
  local delayTime = math.floor(delay * 100)

  local out = {}
  local write_byte = get_write_byte(out)
  local write_word = get_write_word(out)
  local write_string = get_write_string(out)

  -- gif header
  write_string("GIF89a")

  -- logical screen descriptor
  write_word(width)
  write_word(height)

  write_global_color_table(out, palette)
  local color_to_index = get_color_to_index(palette)

  -- Netscape extension for animation loop
  if #frames > 1 then
    write_byte(0x21)         -- Extension introducer
    write_byte(0xFF)         -- Application extension label
    write_byte(11)           -- Block size
    write_string("NETSCAPE") -- Application identifier
    write_string("2.0")      -- Application authentication code
    write_byte(3)            -- Sub-block data size
    write_byte(1)            -- Sub-block ID
    write_word(0)            -- Loop count (0 = infinite)
    write_byte(0)            -- Block terminator
  end

  -- process each frame
  for frameIndex, imageData in ipairs(frames) do
    write_frame({
      color_to_index = color_to_index,
      delayTime = delayTime,
      frameIndex = frameIndex,
      frames_count = #frames,
      height = height,
      imageData = imageData,
      out = out,
      profiler = profiler,
      width = width,
    })
  end

  -- write gif trailer
  write_byte(0x3B)

  profiler.start_section("Final Concatenation")
  local result = table.concat(out)
  profiler.end_section("Final Concatenation")

  profiler.print_profile()
  return result
end

return encode_gif

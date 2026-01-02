local ffi = require('ffi')

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

--- @class Profiler
--- @field start_section fun(name: string)
--- @field end_section fun(name: string)
--- @field print_profile fun()

--- @return Profiler
local function get_profiler()
  local profile = {
    startTime = love.timer.getTime(),
    startMemory = collectgarbage("count"),
    sections = {}
  }

  local function start_section(name)
    collectgarbage("collect") -- Force GC for accurate memory measurement
    profile.sections[name] = {
      startTime = love.timer.getTime(),
      startMemory = collectgarbage("count")
    }
  end

  local function end_section(name)
    local section = profile.sections[name]
    section.endTime = love.timer.getTime()
    section.endMemory = collectgarbage("count")
    section.duration = section.endTime - section.startTime
    section.memoryDelta = section.endMemory - section.startMemory
  end

  local function print_profile()
    local totalTime = love.timer.getTime() - profile.startTime
    local totalMemory = collectgarbage("count") - profile.startMemory

    print("\n========== GIF ENCODER PROFILE ==========")
    print(string.format("Total Time: %.4f seconds", totalTime))
    print(string.format("Total Memory Delta: %.2f KB", totalMemory))
    print("\n--- Section Breakdown ---")

    -- Sort sections by duration
    local sortedSections = {}
    for name, data in pairs(profile.sections) do
      table.insert(sortedSections, { name = name, data = data })
    end
    table.sort(sortedSections, function(a, b)
      return a.data.duration > b.data.duration
    end)

    for _, section in ipairs(sortedSections) do
      local pct = (section.data.duration / totalTime) * 100
      print(string.format("  %-30s %8.4fs (%5.1f%%)  %+.2f KB",
        section.name,
        section.data.duration,
        pct,
        section.data.memoryDelta))
    end
    print("==========================================\n")
  end

  return {
    end_section = end_section,
    print_profile = print_profile,
    start_section = start_section,
  }
end

-- ============================================
-- Color Quantization
-- ============================================

local function generate_palette()
  local palette = {}

  -- Use a 6x6x6 RGB color cube (216 colors) plus 40 grayscale values
  for i = 0, 215 do
    local r = math.floor(i / 36)
    local g = math.floor((i % 36) / 6)
    local b = i % 6
    palette[i] = {
      math.floor(r * 255 / 5),
      math.floor(g * 255 / 5),
      math.floor(b * 255 / 5)
    }
  end

  -- Add grayscale ramp
  for i = 216, 255 do
    local gray = math.floor((i - 216) * 255 / 39)
    palette[i] = { gray, gray, gray }
  end

  return palette
end

local function find_closest_color(r, g, b)
  -- Direct calculation for 6x6x6 cube (no searching needed)
  local ri = math.floor(r / 255 * 5 + 0.5)
  local gi = math.floor(g / 255 * 5 + 0.5)
  local bi = math.floor(b / 255 * 5 + 0.5)
  return ri * 36 + gi * 6 + bi
end

--- @class QuantizeFrameArgs
--- @field color_to_index? table
--- @field imageData love.ImageData
--- @field height number
--- @field width number

--- @param args QuantizeFrameArgs
local function quantize_frame(args)
  local color_to_index = args.color_to_index
  local imageData = args.imageData
  local height = args.height
  local width = args.width

  local indexedData = {}
  local pointer = ffi.cast("uint8_t*", imageData:getFFIPointer())

  for i = 0, width * height - 1 do
    local offset = i * 4
    local r = pointer[offset]
    local g = pointer[offset + 1]
    local b = pointer[offset + 2]

    if color_to_index then
      local key = r * 65536 + g * 256 + b
      indexedData[i + 1] = color_to_index[key] or 0
    else
      local index = find_closest_color(r, g, b)
      table.insert(indexedData, index)
    end
  end

  return indexedData
end

--- LZW Compression
--- @param data table
--- @param minCodeSize number
local function compress(data, minCodeSize)
  local clearCode = 2 ^ minCodeSize
  local eoiCode = clearCode + 1
  local nextCode = eoiCode + 1

  -- String table for LZW
  local stringTable = {}

  local function initTable()
    stringTable = {}
    for i = 0, clearCode - 1 do
      stringTable[string.char(i)] = i
    end
    nextCode = eoiCode + 1
  end

  initTable()

  -- Output buffer for variable-length codes
  local codes = {}
  local codeSize = minCodeSize + 1

  local function writeCode(code)
    table.insert(codes, { code = code, bits = codeSize })

    -- Increase code size when needed
    if nextCode > (2 ^ codeSize - 1) and codeSize < 12 then
      codeSize = codeSize + 1
    end
  end

  -- Start with clear code
  writeCode(clearCode)

  -- LZW compression algorithm
  local w = ""
  for i = 1, #data do
    local k = string.char(data[i])
    local wk = w .. k

    if stringTable[wk] then
      w = wk
    else
      writeCode(stringTable[w])

      -- Add new string to table
      if nextCode < 4096 then
        stringTable[wk] = nextCode
        nextCode = nextCode + 1
      end

      -- Reset table if full
      if nextCode >= 4095 then
        writeCode(clearCode)
        initTable()
        codeSize = minCodeSize + 1
      end

      w = k
    end
  end

  -- Output final string
  if w ~= "" then
    writeCode(stringTable[w])
  end

  -- End of information
  writeCode(eoiCode)

  -- Pack variable-length codes into bytes
  local bytes = {}
  local bitBuffer = 0
  local bitCount = 0

  for _, entry in ipairs(codes) do
    bitBuffer = bitBuffer + (entry.code * (2 ^ bitCount))
    bitCount = bitCount + entry.bits

    while bitCount >= 8 do
      table.insert(bytes, bitBuffer % 256)
      bitBuffer = math.floor(bitBuffer / 256)
      bitCount = bitCount - 8
    end
  end

  -- Flush remaining bits
  if bitCount > 0 then
    table.insert(bytes, bitBuffer % 256)
  end

  return bytes
end

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

--- @class EncodeFrameArgs
--- @field color_to_index? table
--- @field delayTime number
--- @field frameIndex number
--- @field frames_count number
--- @field height number
--- @field imageData love.ImageData
--- @field out table
--- @field profiler Profiler
--- @field width number

--- @param args EncodeFrameArgs
local function process_frame(args)
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
  local minCodeSize = 8 -- 8 bits for 256-color palette
  write_byte(minCodeSize)
  local compressed = compress(indexedData, minCodeSize)
  profiler.end_section("Frame " .. frameIndex .. " - LZW Compression")

  -- Write compressed data in sub-blocks (max 255 bytes each)
  local pos = 1
  while pos <= #compressed do
    local blockSize = math.min(255, #compressed - pos + 1)
    write_byte(blockSize)
    for i = pos, pos + blockSize - 1 do
      write_byte(compressed[i])
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
    process_frame({
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

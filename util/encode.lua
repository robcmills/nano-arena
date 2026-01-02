-- ============================================
-- Color Quantization
-- ============================================

local function find_closest_color(r, g, b)
  -- Direct calculation for 6x6x6 cube (no searching needed)
  local ri = math.floor(r / 255 * 5 + 0.5)
  local gi = math.floor(g / 255 * 5 + 0.5)
  local bi = math.floor(b / 255 * 5 + 0.5)
  return ri * 36 + gi * 6 + bi
end

local function quantize_frame(args)
  local imageData = args.imageData
  local height = args.height
  local width = args.width
  local indexedData = {}

  for y = 0, height - 1 do
    for x = 0, width - 1 do
      local r, g, b = imageData:getPixel(x, y)
      -- Convert from [0,1] to [0,255]
      r = math.floor(r * 255 + 0.5)
      g = math.floor(g * 255 + 0.5)
      b = math.floor(b * 255 + 0.5)
      -- Find closest palette color
      local index = find_closest_color(r, g, b)
      table.insert(indexedData, index)
    end
  end
  return indexedData
end

local function encode_gif(args)
  local frames = args.frames
  local width = args.width
  local height = args.height
  local delay = args.delay

  -- ============================================
  -- Profiling Setup
  -- ============================================
  local profile = {
    startTime = love.timer.getTime(),
    startMemory = collectgarbage("count"),
    sections = {}
  }

  local function startSection(name)
    collectgarbage("collect") -- Force GC for accurate memory measurement
    profile.sections[name] = {
      startTime = love.timer.getTime(),
      startMemory = collectgarbage("count")
    }
  end

  local function endSection(name)
    local section = profile.sections[name]
    section.endTime = love.timer.getTime()
    section.endMemory = collectgarbage("count")
    section.duration = section.endTime - section.startTime
    section.memoryDelta = section.endMemory - section.startMemory
  end

  local function printProfile()
    local totalTime = love.timer.getTime() - profile.startTime
    local totalMemory = collectgarbage("count") - profile.startMemory

    print("\n========== GIF ENCODER PROFILE ==========")
    print(string.format("Total Time: %.4f seconds", totalTime))
    print(string.format("Total Memory Delta: %.2f KB", totalMemory))
    print(string.format("Image Size: %dx%d, Frames: %d", width, height, #frames))
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

  -- Convert delay from seconds to hundredths of a second (GIF time unit)
  local delayTime = math.floor(delay * 100)

  local output = {}

  -- ============================================
  -- Helper Functions for Writing Data
  -- ============================================

  local function writeByte(value)
    table.insert(output, string.char(value % 256))
  end

  local function writeWord(value)
    writeByte(value % 256)
    writeByte(math.floor(value / 256) % 256)
  end

  local function writeString(str)
    table.insert(output, str)
  end

  -- ============================================
  -- Palette Generation (256-color)
  -- ============================================

  local function generatePalette()
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

  -- ============================================
  -- LZW Compression
  -- ============================================

  local function lzwCompress(data, minCodeSize)
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

  -- ============================================
  -- Write GIF Header
  -- ============================================

  writeString("GIF89a")

  -- ============================================
  -- Write Logical Screen Descriptor
  -- ============================================

  writeWord(width)
  writeWord(height)

  -- Packed field:
  -- - Global Color Table Flag: 1 (yes)
  -- - Color Resolution: 7 (8 bits per channel)
  -- - Sort Flag: 0 (not sorted)
  -- - Size of Global Color Table: 7 (256 colors = 2^(7+1))
  local gctFlag = 1
  local colorRes = 7
  local sortFlag = 0
  local gctSize = 7

  local packed = (gctFlag * 128) + (colorRes * 16) + (sortFlag * 8) + gctSize
  writeByte(packed)

  writeByte(0) -- Background color index
  writeByte(0) -- Pixel aspect ratio (no aspect ratio info)

  -- ============================================
  -- Write Global Color Table
  -- ============================================

  startSection("Palette Generation")
  local globalPalette = generatePalette()
  endSection("Palette Generation")

  for i = 0, 255 do
    writeByte(globalPalette[i][1]) -- Red
    writeByte(globalPalette[i][2]) -- Green
    writeByte(globalPalette[i][3]) -- Blue
  end

  -- ============================================
  -- Write Netscape Extension for Animation Loop
  -- ============================================

  if #frames > 1 then
    writeByte(0x21)         -- Extension introducer
    writeByte(0xFF)         -- Application extension label
    writeByte(11)           -- Block size
    writeString("NETSCAPE") -- Application identifier
    writeString("2.0")      -- Application authentication code
    writeByte(3)            -- Sub-block data size
    writeByte(1)            -- Sub-block ID
    writeWord(0)            -- Loop count (0 = infinite)
    writeByte(0)            -- Block terminator
  end

  -- ============================================
  -- Process Each Frame
  -- ============================================

  for frameIndex, imageData in ipairs(frames) do
    -- Graphic Control Extension (for timing and transparency)
    if #frames > 1 or delayTime > 0 then
      writeByte(0x21) -- Extension introducer
      writeByte(0xF9) -- Graphic control label
      writeByte(4)    -- Block size

      -- Packed field:
      -- - Reserved: 0 (3 bits)
      -- - Disposal Method: 0 (no disposal specified)
      -- - User Input Flag: 0 (no user input)
      -- - Transparent Color Flag: 0 (no transparency)
      writeByte(0)

      writeWord(delayTime) -- Delay time in hundredths of a second
      writeByte(0)         -- Transparent color index (unused)
      writeByte(0)         -- Block terminator
    end

    -- Image Descriptor
    writeByte(0x2C)   -- Image separator
    writeWord(0)      -- Left position
    writeWord(0)      -- Top position
    writeWord(width)  -- Image width
    writeWord(height) -- Image height

    -- Packed field:
    -- - Local Color Table Flag: 0 (use global)
    -- - Interlace Flag: 0 (not interlaced)
    -- - Sort Flag: 0
    -- - Reserved: 0 (2 bits)
    -- - Size of Local Color Table: 0 (no local table)
    writeByte(0)

    -- Convert image to indexed color
    startSection("Frame " .. frameIndex .. " - Color Quantization")
    local indexedData = quantize_frame({
      imageData = imageData,
      height = height,
      width = width,
    })
    endSection("Frame " .. frameIndex .. " - Color Quantization")

    -- Image Data (LZW-compressed)
    startSection("Frame " .. frameIndex .. " - LZW Compression")
    local minCodeSize = 8 -- 8 bits for 256-color palette
    writeByte(minCodeSize)
    local compressed = lzwCompress(indexedData, minCodeSize)
    endSection("Frame " .. frameIndex .. " - LZW Compression")

    -- Write compressed data in sub-blocks (max 255 bytes each)
    local pos = 1
    while pos <= #compressed do
      local blockSize = math.min(255, #compressed - pos + 1)
      writeByte(blockSize)

      for i = pos, pos + blockSize - 1 do
        writeByte(compressed[i])
      end

      pos = pos + blockSize
    end

    writeByte(0) -- Block terminator
  end

  -- ============================================
  -- Write GIF Trailer
  -- ============================================

  writeByte(0x3B)

  startSection("Final Concatenation")
  local result = table.concat(output)
  endSection("Final Concatenation")

  printProfile()
  return result
end

return encode_gif

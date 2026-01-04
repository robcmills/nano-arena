--- LZW Compression
--- @param data table
--- @param minCodeSize number
local function compress_lzw(data, minCodeSize)
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

return compress_lzw

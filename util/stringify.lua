local function stringify(value, indent)
  indent = indent or 0
  local spacing = string.rep("  ", indent)
  local t = type(value)

  if t == "string" then
    return '"' .. value:gsub('"', '\\"') .. '"'
  elseif t == "number" or t == "boolean" or t == "nil" then
    return tostring(value)
  elseif t == "table" then
    local parts = {}
    -- local isArray = #value > 0

    for k, v in pairs(value) do
      local key
      if type(k) == "string" then
        key = k .. " = "
      else
        key = "[" .. tostring(k) .. "] = "
      end

      local formatted = spacing .. "  " .. key .. stringify(v, indent + 1)
      table.insert(parts, formatted)
    end

    if #parts == 0 then
      return "{}"
    end

    return "{\n" .. table.concat(parts, ",\n") .. "\n" .. spacing .. "}"
  else
    return "<" .. t .. ">"
  end
end

return stringify

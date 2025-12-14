
local function assert_string(value, message)
  local default_message = "Expected string, got " .. type(value)
  assert(type(value) == "string", message or default_message)
  return value
end

return assert_string

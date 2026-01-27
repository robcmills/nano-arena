---Extracts the string from a colored text table
---@param colored_text table | string
---@return string
local function colored_to_string(colored_text)
  if type(colored_text) == 'string' then
    return colored_text
  end
  local text = ''
  for _, item in ipairs(colored_text) do
    if type(item) == 'string' then
      text = text .. item
    end
  end
  return text
end

return colored_to_string

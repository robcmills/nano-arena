local theme = require('theme')

---@class GetColoredButtonLabelOptions
---@field key string
---@field label string

---@param options GetColoredButtonLabelOptions
---@return table colored_text
local function get_colored_button_label(options)
  local key = options.key
  local label = options.label
  -- get first index of key in label
  local key_index = string.find(string.lower(label), string.lower(key), 1, true)
  assert(key_index, 'get_colored_button_label: key not found in label')
  -- split label into two parts before and after key
  -- replace key with colored key
  local colored_text = {}
  -- before key
  if key_index > 1 then
    table.insert(colored_text, theme.button_text_color)
    table.insert(colored_text, string.sub(label, 1, key_index - 1))
  end
  -- highlighted key
  table.insert(colored_text, theme.button_text_highlight_color)
  table.insert(colored_text, string.sub(label, key_index, key_index))
  -- after key
  if key_index + 1 <= #label then
    table.insert(colored_text, theme.button_text_color)
    table.insert(colored_text, string.sub(label, key_index + 1))
  end
  return colored_text
end

return get_colored_button_label

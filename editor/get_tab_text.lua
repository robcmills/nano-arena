local editor = require('editor')

--- Get tab text from arena name with ellipsification
---@param name string
local function get_tab_text(name)
  local max = editor.tab_max_char_count
  local text = name:sub(1, max)
  if #name > max then
    text = text .. "…"
  end
  return text
end

return get_tab_text

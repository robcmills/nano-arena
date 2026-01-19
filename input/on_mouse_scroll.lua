local on_scroll_in_open_file_window = require('editor/on_scroll_in_open_file_window')

---@param dx number Amount of horizontal mouse wheel movement. Positive values indicate movement to the right.
---@param dy number Amount of vertical mouse wheel movement. Positive values indicate upward movement.
local function on_mouse_scroll(dx, dy)
  on_scroll_in_open_file_window(dx, dy)
end

return on_mouse_scroll

local update_open_file_window = require('editor/update_open_file_window')

---@param dt number delta time in seconds
local function update_editor(dt)
  update_open_file_window(dt)
end

return update_editor

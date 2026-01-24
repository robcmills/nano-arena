local editor = require('editor')

---@param index number the tab index to activate
local function activate_tab(index)
  editor.active_arena = index
end

return activate_tab

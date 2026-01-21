local editor = require('editor')

local function close_opened_menu()
  editor.opened_menu = nil
end

return close_opened_menu

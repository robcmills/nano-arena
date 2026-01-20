local settings = require('settings')

---@param window OpenFileWindowState
local function get_files_list_scroll_container(window)
  return {
    height = window.height - settings.tile_size, -- account for title bar
    width = window.width - 2, -- account for borders
    x = window.x + 1,
    y = window.y + settings.tile_size, -- account for title bar
  }
end

return get_files_list_scroll_container

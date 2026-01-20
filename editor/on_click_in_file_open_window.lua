local editor = require('editor')
local get_files_list_scroll_container = require('editor/get_files_list_scroll_container')
local is_inside = require('collision/is_inside')

---@class OnClickInFileOpenWindowOptions
---@field button number
---@field x number canvas x position in pixels
---@field y number canvas y position in pixels

---@param options OnClickInFileOpenWindowOptions
local function on_click_in_file_open_window(options)
  local button = options.button
  local x = options.x
  local y = options.y

  local window = editor.windows.open
  if not window then return end
  local scroll_container = get_files_list_scroll_container(window)
  if not is_inside({ x = x, y = y, rect = scroll_container }) then return end

  local item_index = math.floor(
    (y - scroll_container.y + window.scroll_offset_y)
    / window.item_height
  ) + 1
  local item = window.files[item_index]
  -- todo: open file
end

return on_click_in_file_open_window

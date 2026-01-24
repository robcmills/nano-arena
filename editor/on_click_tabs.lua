local activate_tab = require('editor/activate_tab')
local close_tab = require('editor/close_tab')
local editor = require('editor')
local is_inside = require('collision/is_inside')

---@class OnClickTabsOptions
---@field x number canvas x position in pixels
---@field y number canvas y position in pixels
---@field button number mouse button

---@param options OnClickTabsOptions
local function on_click_tabs(options)
  local x = options.x
  local y = options.y

  for i, _ in ipairs(editor.arenas) do
    local tab = editor.tabs[i]
    if not tab then break end

    -- check close button first
    if is_inside({ x = x, y = y, rect = tab.close_button_rect }) then
      close_tab(i)
      return
    end

    -- check if inactive tab is clicked
    if i ~= editor.active_arena and is_inside({ x = x, y = y, rect = tab.tab_rect }) then
      activate_tab(i)
      return
    end
  end
end

return on_click_tabs

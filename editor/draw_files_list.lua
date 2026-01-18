local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local get_mouse_canvas_position = require('input/get_mouse_canvas_position')
local reset_graphics = require('draw/reset_graphics')
local theme = require('theme')

---@class DrawFilesListOptions
---@field files FileInfo[]
---@field height number
---@field item_height number
---@field scroll_offset number
---@field width number
---@field x number
---@field y number

-- Module state for scrolling

-- Handle mouse wheel scrolling
-- local function handle_scroll(dy, options)
--   local items = editor.files
--   local max_scroll = math.max(0, #items * item_height - options.height)
--
--   scroll_offset = scroll_offset - (dy * item_height * 3)
--   scroll_offset = math.max(0, math.min(scroll_offset, max_scroll))
-- end

---@param options DrawFilesListOptions
local function draw_files_list(options)
  local files = options.files
  local height = options.height
  local item_height = options.item_height
  local scroll_offset = options.scroll_offset
  local width = options.width
  local x = options.x
  local y = options.y

  -- Handle mouse wheel input for scrolling
  local mouse_x, mouse_y = get_mouse_canvas_position()
  -- if mouse_x >= x and mouse_x <= x + width and
  --    mouse_y >= y and mouse_y <= y + height then
  --   local wheel_dy = 0
  --   -- Check for wheel events (this would need to be called from love.wheelmoved)
  --   -- For now, we'll handle it via a global that can be set
  --   if _G.last_wheel_dy then
  --     handle_scroll(_G.last_wheel_dy, options)
  --     _G.last_wheel_dy = nil
  --   end
  -- end

  -- Set up clipping to window bounds
  love.graphics.setScissor(x, y, width, height)

  local start_y = y - scroll_offset

  -- Draw each item
  for i, item in ipairs(files) do
    local item_y = start_y + ((i - 1) * item_height)

    -- Only draw if visible within window
    if item_y + item_height >= y and item_y <= y + height then
      local display_name = item.name
      if item.is_directory then
        display_name = "[" .. display_name .. "]"
      end

      -- Draw background for hover
      if mouse_x >= x and mouse_x <= x + width and
         mouse_y >= item_y and mouse_y <= item_y + item_height then
        -- love.graphics.setColor(0.3, 0.3, 0.4, 1)
        -- love.graphics.rectangle("fill", x, item_y, width, item_height)
        draw_rect({
          color = theme.text_highlight_background_color,
          height = item_height,
          width = width,
          x = x,
          y = item_y,
        })
      end

      -- Draw text
      local text_color = item.is_directory and theme.text_directory_color or theme.text_file_color
      draw_text({
        color = text_color,
        text = display_name,
        x = x + 4,
        y = item_y + 2,
      })
    end
  end

  reset_graphics()
end

-- Export additional functions for external scroll handling
-- draw_files_list.handle_scroll = handle_scroll
-- draw_files_list.reset_cache = function()
--   cached_items = nil
-- end

return draw_files_list

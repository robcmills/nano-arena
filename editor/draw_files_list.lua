local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local get_mouse_canvas_position = require('input/get_mouse_canvas_position')
local reset_graphics = require('draw/reset_graphics')
local theme = require('theme')

---@class DrawFilesListOptions
---@field files FileInfo[]
---@field height number
---@field item_height number
---@field scroll_offset_x number
---@field scroll_offset_y number
---@field width number
---@field x number
---@field y number

---@param options DrawFilesListOptions
local function draw_files_list(options)
  local files = options.files
  local height = options.height
  local item_height = options.item_height
  local scroll_offset_x = options.scroll_offset_x
  local scroll_offset_y = options.scroll_offset_y
  local width = options.width
  local x = options.x
  local y = options.y

  love.graphics.setScissor(x - 2, y, width + 2, height)

  local mouse_x, mouse_y = get_mouse_canvas_position()
  local start_y = y - scroll_offset_y

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
        draw_rect({
          color = theme.text_highlight_background_color,
          height = item_height,
          width = width + 1,
          x = x - 1,
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

return draw_files_list

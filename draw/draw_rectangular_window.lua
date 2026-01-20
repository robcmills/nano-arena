local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local settings = require('settings')
local theme = require('theme')

local function draw_rectangular_window(options)
  local x = options.x
  local y = options.y
  local width = options.width
  local height = options.height
  local title = options.title

  -- background
  draw_rect({
    color = theme.window_background_color,
    height = height,
    width = width,
    x = x,
    y = y,
  })

  -- title bar
  draw_rect({
    color = theme.window_title_bar_background_color,
    height = settings.tile_size,
    width = width,
    x = x,
    y = y,
  })

  -- title text
  draw_text({
    color = theme.window_title_text_color,
    text = ' ' .. title,
    x = x,
    y = y + 1,
  })

  -- border
  draw_rect({
    color = theme.window_border_color,
    fill = false,
    height = height,
    width = width,
    x = x,
    y = y,
  })
end

return draw_rectangular_window

local draw_editor_sprite = require('editor/draw_editor_sprite')
local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local editor = require('editor')
local settings = require('settings')
local theme = require('theme')

local tile_size = settings.tile_size

---@class DrawSpriteWindowOptions
---@field height number
---@field title string
---@field width number
---@field x number
---@field y number

---@param options DrawSpriteWindowOptions
local function draw_sprite_window(options)
  local height = options.height
  local title = options.title
  local width = options.width
  local x = options.x
  local y = options.y

  -- draw sprite corners

  -- top left
  draw_editor_sprite({
    index = 9,
    x = x,
    y = y,
  })
  -- top right
  draw_editor_sprite({
    index = 11,
    x = x + width - tile_size,
    y = y,
  })
  -- bottom left
  draw_editor_sprite({
    index = 25,
    x = x,
    y = y + height - tile_size,
  })
  -- bottom right
  draw_editor_sprite({
    index = 27,
    x = x + width - tile_size,
    y = y + height - tile_size,
  })

  -- draw title bar background
  draw_rect({
    color = theme.window_title_bar_highlight_color,
    height = 1,
    width = width - tile_size * 2,
    x = x + tile_size,
    y = y,
  })
  draw_rect({
    color = theme.window_title_bar_background_color,
    height = editor.window_title_bar_height,
    width = width - tile_size * 2,
    x = x + tile_size,
    y = y + 1,
  })
  draw_rect({
    color = theme.window_title_bar_shadow_color,
    height = 1,
    width = width - 2,
    x = x + 1,
    y = y + editor.window_title_bar_height + 1,
  })

  -- draw body background
  draw_rect({
    color = theme.window_background_color,
    height = height - tile_size * 2,
    width = width,
    x = x,
    y = y + tile_size,
  })
  -- draw left border
  draw_rect({
    color = theme.window_border_color,
    height = height - tile_size * 2,
    width = 1,
    x = x,
    y = y + tile_size,
  })
  -- draw right border
  draw_rect({
    color = theme.window_border_color,
    height = height - tile_size * 2,
    width = 1,
    x = x + width - 1,
    y = y + tile_size,
  })

  -- draw bottom background
  draw_rect({
    color = theme.window_background_color,
    height = tile_size,
    width = width - tile_size * 2,
    x = x + tile_size,
    y = y + height - tile_size,
  })

  -- draw bottom border
  draw_rect({
    color = theme.window_border_color,
    height = 1,
    width = width - tile_size * 2,
    x = x + tile_size,
    y = y + height - 1,
  })

  -- title text
  draw_text({
    color = theme.window_title_text_color,
    text = ' ' .. title,
    x = x,
    y = y + 1,
  })
end

return draw_sprite_window

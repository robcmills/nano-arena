local draw_rect = require('draw/draw_rect')
local draw_text = require('draw/draw_text')
local g = require('g')
local theme = require('theme')
local settings = require('settings')

local function draw_prompt()
  local prompt = g.prompt
  if not prompt then return end

  -- background
  draw_rect({
    color = theme.prompt_background_color,
    height = prompt.height,
    width = prompt.width,
    x = prompt.x,
    y = prompt.y,
  })
  -- border
  draw_rect({
    color = theme.menu_bar_border_color,
    fill = false,
    height = prompt.height,
    width = prompt.width,
    x = prompt.x,
    y = prompt.y,
  })
  -- text
  draw_text({
    color = theme.menu_bar_text_normal_color,
    limit = prompt.width - settings.prompt_padding * 2,
    text = prompt.text,
    x = prompt.x + settings.prompt_padding,
    y = prompt.y + settings.prompt_padding,
  })
end

return draw_prompt

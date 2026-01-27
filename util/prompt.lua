local create_new_window = require('editor/create_new_window')
local g = require('g')
local measure_text = require('util/measure_text')
local settings = require('settings')

---@class PromptButton : PromptButtonOptions
---@field height number Button height in pixels
---@field width number Button width in pixels
---@field x number Button x position in canvas pixels
---@field y number Button y position in canvas pixels

---@class PromptButtonOptions
---@field on_click? function
---@field key string
---@field label string
---@field type? 'primary'

---@class PromptOptions
---@field buttons PromptButtonOptions[]
---@field text string

---@param options PromptOptions
local function prompt(options)
  local max_text_width = settings.prompt_max_width - settings.prompt_padding * 2
  local text_width, text_height = measure_text({
    text = options.text,
    max_width = max_text_width,
  })
  local font = love.graphics.getFont()
  local font_height = font:getHeight()
  local gap = font_height
  local button_height = font_height + settings.button_padding_y * 2
  local height = settings.prompt_padding * 2 +
      text_height +
      gap +
      button_height
  local width = settings.prompt_padding * 2 + text_width
  width = math.min(width, settings.prompt_max_width)

  local window = create_new_window({
    height = height,
    placement = 'center',
    title = '',
    width = width,
  })

  g.prompt = {
    buttons = options.buttons,
    height = height,
    text = options.text,
    width = width,
    x = window.x,
    y = window.y,
  }

  local buttons = g.prompt.buttons
  local x_offset = settings.prompt_padding
  -- iterate right to left to right align
  for i = 0, #buttons - 1 do
    local button = buttons[#buttons - i]
    button.on_click = function()
      if button.on_click then
        button.on_click()
      end
      g.prompt = nil
    end
    button.height = settings.button_padding_y * 2 + font_height
    button.width = settings.button_padding_x * 2 + font:getWidth(button.label)
    button.x = window.x + width - x_offset - button.width
    button.y = window.y + height - settings.prompt_padding - button.height
    x_offset = x_offset + settings.prompt_padding + button.width -- add gap between buttons
  end
end

return prompt

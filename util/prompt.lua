local create_new_window = require('editor/create_new_window')
local g = require('g')
local measure_text = require('util/measure_text')
local settings = require('settings')

---@class PromptButton
---@field on_click? function
---@field key string
---@field label string

---@class PromptOptions
---@field buttons PromptButton[]
---@field text string

---@param options PromptOptions
local function prompt(options)
  local max_text_width = settings.prompt_max_width - settings.prompt_padding * 2
  local text_width, text_height = measure_text({
    text = options.text,
    max_width = max_text_width,
  })
  local gap = text_height
  local button_height = text_height + settings.button_padding * 2
  local height = settings.prompt_padding * 2 +
      text_height
      -- gap +
      -- button_height
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

  for _, button in ipairs(g.prompt.buttons) do
    button.on_click = function()
      if button.on_click then
        button.on_click()
      end
      g.prompt = nil
    end
  end
end

return prompt

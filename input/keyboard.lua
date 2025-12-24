local editor = require('editor')
local take_screenshot = require('util/save_screenshot')

function love.keypressed(key)
  if editor ~= nil then
    if key == 'f' then
      editor.opened_menu = 'file'
    elseif key == 'e' then
      editor.opened_menu = 'edit'
    elseif key == 'g' then
      editor.opened_menu = 'grid'
    elseif key == 'h' then
      editor.opened_menu = 'help'
    elseif key == 'escape' then
      editor.opened_menu = nil
    end
  end
  if key == 'q' then
    love.event.quit()
  elseif key == 'n' then
    take_screenshot()
  end
end


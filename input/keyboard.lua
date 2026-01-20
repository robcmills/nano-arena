local close_file_open_window = require('editor/close_file_open_window')
local editor = require('editor')
local on_click_file_open = require('editor/on_click_file_open')
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
      close_file_open_window()
    elseif key == 'o' and editor.opened_menu == 'file' then
      editor.opened_menu = nil
      on_click_file_open()
    end
  end
  if key == 'q' then
    love.event.quit()
  elseif key == 'n' then
    take_screenshot()
  end
end


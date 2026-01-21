local close_file_open_window = require('editor/close_file_open_window')
local close_opened_menu = require('editor/close_opened_menu')
local editor = require('editor')
local on_click_file_new = require('editor/on_click_file_new')
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
      close_opened_menu()
      close_file_open_window()
    elseif key == 'n' and editor.opened_menu == 'file' then
      on_click_file_new()
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


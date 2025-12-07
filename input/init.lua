local g = require('g')

function love.keypressed(key)
  if key == 'f' then
    g.editor.opened_menu = 'file'
  elseif key == 'e' then
    g.editor.opened_menu = 'edit'
  elseif key == 'g' then
    g.editor.opened_menu = 'grid'
  elseif key == 's' then
    g.editor.opened_menu = 'settings'
  elseif key == 'h' then
    g.editor.opened_menu = 'help'
  elseif key == 'escape' then
    g.editor.opened_menu = nil
  elseif key == 'q' then
    love.event.quit()
  end
end

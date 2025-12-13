local g = require('g')

function love.keypressed(key)
  if g.editor ~= nil then
    if key == 'f' then
      g.editor.opened_menu = 'file'
    elseif key == 'e' then
      g.editor.opened_menu = 'edit'
    elseif key == 'g' then
      g.editor.opened_menu = 'grid'
    elseif key == 'h' then
      g.editor.opened_menu = 'help'
    elseif key == 'escape' then
      g.editor.opened_menu = nil
    end
  end
  if key == 'q' then
    love.event.quit()
  end
end


local editor = require('editor')

local function draw_editor_sprite(options)
  local index = options.index
  local x = options.x
  local y = options.y

  love.graphics.draw(editor.spritesheet, editor.sprites[index], x, y)
end

return draw_editor_sprite

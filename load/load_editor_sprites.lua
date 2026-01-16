local editor = require('editor')
local settings = require('settings')

local function load_editor_sprites()
  local editor_spritesheet = love.graphics.newImage("assets/editor-spritesheet.png")
  editor.spritesheet = editor_spritesheet
  local tile_size = settings.tile_size
  local spritesheet_width = editor_spritesheet:getWidth()
  local spritesheet_height = editor_spritesheet:getHeight()
  local sprites = {}
  for y = 0, spritesheet_height - 1, tile_size do
    for x = 0, spritesheet_width - 1, tile_size do
      local quad = love.graphics.newQuad(x, y, tile_size, tile_size, spritesheet_width, spritesheet_height)
      table.insert(sprites, quad)
    end
  end
  editor.sprites = sprites
end

return load_editor_sprites

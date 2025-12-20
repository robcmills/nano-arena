local g = require('g')

local function load_player()
  g.player = {}
  g.player.sprite_sheet = love.graphics.newImage("assets/player.png")
  local sheet_width = g.player.sprite_sheet:getWidth()
  local sheet_height = g.player.sprite_sheet:getHeight()
  local sprite_size = 16
  g.player.sprite_size = sprite_size
  g.player.sprites = {}
  g.player.sprites.down = love.graphics.newQuad(sprite_size, sprite_size, sprite_size, sprite_size, sheet_width, sheet_height)
  g.player.sprites.right = love.graphics.newQuad(0, sprite_size, sprite_size, sprite_size, sheet_width, sheet_height)
  g.player.sprites.up = love.graphics.newQuad(0, 0, sprite_size, sprite_size, sheet_width, sheet_height)
  g.player.map_pixel_x = 16
  g.player.map_pixel_y = 16
  g.player.tile_x = 1
  g.player.tile_y = 1
  g.player.last_move_time = nil
end

return load_player

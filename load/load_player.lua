local g = require('g')

local function load_player()
  g.player = {}
  g.player.sprite_sheet = love.graphics.newImage("assets/player.png")
  local sheet_width = g.player.sprite_sheet:getWidth()
  local sheet_height = g.player.sprite_sheet:getHeight()
  local ss = 32
  g.player.sprite_size = ss

  g.player.sprites = {}
  g.player.sprites.down = love.graphics.newQuad(ss, ss, ss, ss, sheet_width, sheet_height)
  g.player.sprites.left = love.graphics.newQuad(0, 0, ss, ss, sheet_width, sheet_height)
  g.player.sprites.right = love.graphics.newQuad(ss, 0, ss, ss, sheet_width, sheet_height)
  g.player.sprites.up = love.graphics.newQuad(0, ss, ss, ss, sheet_width, sheet_height)

  -- Player starting position
  g.player.map_pixel_x = 16
  g.player.map_pixel_y = 16
  g.player.tile_x = 1
  g.player.tile_y = 1
  g.player.last_move_time = nil
end

return load_player

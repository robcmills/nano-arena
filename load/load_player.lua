local g = require('g')
local settings = require('settings')
local weapons = require('weapons')

local function load_player()
  g.player = {
    dir = 'right',
    flip_x = false,
    from_tile_x = nil,
    from_tile_y = nil,
    last_move_time = nil,
    last_shoot_time = nil,
    map_pixel_x = 0,
    map_pixel_y = 0,
    speed = 0,
    sprite_sheet = love.graphics.newImage("assets/player.png"),
    sprite_size = settings.player_sprite_size,
    sprites = {
      down = nil,
      left = nil,
      right = nil,
      up = nil,
    },
    tile_x = 0,
    tile_y = 0,
    to_tile_x = nil,
    to_tile_y = nil,
    weapon = weapons.line,
  }
  local sheet_width = g.player.sprite_sheet:getWidth()
  local sheet_height = g.player.sprite_sheet:getHeight()
  local ss = g.player.sprite_size
  g.player.sprites.down = love.graphics.newQuad(ss, ss, ss, ss, sheet_width, sheet_height)
  g.player.sprites.left = love.graphics.newQuad(0, 0, ss, ss, sheet_width, sheet_height)
  g.player.sprites.right = love.graphics.newQuad(ss, 0, ss, ss, sheet_width, sheet_height)
  g.player.sprites.up = love.graphics.newQuad(0, ss, ss, ss, sheet_width, sheet_height)
end

return load_player

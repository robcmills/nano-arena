local g = require('g')
local get_input = require('input/get_input')
local update_map = require('update/update_map')
local update_player = require('update/update_player')

function love.update(dt)
  g.frame = g.frame + 1
  g.now = g.now + dt
  update_map(dt)
  local input = get_input()
  update_player(g.player, input)
end

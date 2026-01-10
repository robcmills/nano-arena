local g = require('g')
local get_input = require('input/get_input')
local test = require('test')
local update_map = require('update/update_map')
local update_player = require('update/update_player')

function love.update(dt)
  if g.state == 'game' then
    g.frame = g.frame + 1
    g.now = g.now + dt
    if g.is_test then test:update_pre() end
    update_map(dt)
    local input = get_input()
    update_player(g.player, input)

    -- g.debug = string.format("FRAME: %d NOW: %.3f DT: %.3f", g.frame, g.now, dt)
  end
end

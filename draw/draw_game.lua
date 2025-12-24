local draw_player = require('draw/draw_player')
local draw_map = require('draw/draw_map')

local function draw_game()
  draw_map()
  draw_player()
end

return draw_game

local on_mouse_moved = require('input/on_mouse_moved')
local on_mouse_pressed = require('input/on_mouse_pressed')

function love.mousemoved(screen_x, screen_y)
  on_mouse_moved(screen_x, screen_y)
end

function love.mousepressed(screen_x, screen_y, button)
  on_mouse_pressed(screen_x, screen_y, button)
end

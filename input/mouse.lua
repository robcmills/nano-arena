local on_mouse_moved = require('input/on_mouse_moved')
local on_mouse_pressed = require('input/on_mouse_pressed')
local on_mouse_scroll = require('input/on_mouse_scroll')

function love.mousemoved(screen_x, screen_y)
  on_mouse_moved(screen_x, screen_y)
end

function love.mousepressed(screen_x, screen_y, button)
  on_mouse_pressed(screen_x, screen_y, button)
end

function love.wheelmoved(dx, dy)
  on_mouse_scroll(dx, dy)
end

local function reset_graphics()
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setScissor()
end

return reset_graphics

local g = require('g')

local function load_fonts()
  g.fonts = {
    future = {
      char_height = 12,
      char_width = 6,
      font = love.graphics.newImageFont(
        'assets/future-font.png',
        'abcdefghijklmnopqrstuvwxyz.,"\'?!@_*#$%()+-/:;<=>[\\]^{|}~ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '
      )
    },
    monogram = {
      char_height = 12,
      char_width = 7,
      font = love.graphics.newImageFont(
        'assets/monogram-font.png',
        ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!"#$%&\'()*+,-./:;<=>?[\\]^_{|}~`@'
      )
    },
    p8 = {
      char_height = 5,
      char_width = 4,
      font = love.graphics.newImageFont(
        'assets/pico8-font.png',
        ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,"\'?!@_*#$%()+-/:;<=>[\\]^{|}~'
      ),
    },
  }
  g.fonts.monogram.font:setFilter('nearest', 'nearest')
  g.fonts.p8.font:setFilter('nearest', 'nearest')
  love.graphics.setFont(g.fonts.p8.font)
end

return load_fonts

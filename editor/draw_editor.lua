local draw_background = require('editor/draw_background')
local draw_cursor = require('editor/draw_cursor')
local draw_menu = require('editor/draw_menu')
local draw_tabs = require('editor/draw_tabs')
local draw_windows = require('editor/draw_windows')
local editor = require('editor')

local function draw_editor()
  love.graphics.setFont(editor.font.font)
  draw_background()
  draw_menu()
  draw_tabs()
  draw_windows()
  draw_cursor()
end

return draw_editor

local draw_background = require('editor/draw_background')
local draw_cursor = require('editor/draw_cursor')
local draw_menu_bar = require('editor/draw_menu_bar')
local draw_open_menu = require('editor/draw_open_menu')
local draw_prompt = require('draw/draw_prompt')
local draw_tabs = require('editor/draw_tabs')
local draw_windows = require('editor/draw_windows')
local editor = require('editor')

local function draw_editor()
  love.graphics.setFont(editor.font.font)
  draw_background()
  draw_menu_bar()
  draw_tabs()
  draw_open_menu()
  draw_windows()
  draw_prompt()
  draw_cursor()
end

return draw_editor

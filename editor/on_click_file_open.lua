local create_new_window = require('editor/create_new_window')
local editor = require('editor')

local function on_click_file_open()
  if editor.windows.open then
    editor.windows.open.state = 'open'
  else
    editor.windows.open = create_new_window({
      height = 128,
      placement = 'center',
      title = 'Select arena',
      width = 128,
    })
  end
end

return on_click_file_open

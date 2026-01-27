local editor = require('editor')
local prompt = require('util/prompt')
local theme = require('theme')
local update_tabs = require('editor/update_tabs')

---@param tab_index number the tab index to close
local function close_tab(tab_index)
  if editor.arenas[tab_index].has_unsaved_changes then
    prompt({
      text = 'The active arena has unsaved changes!',
      buttons = {
        {
          key = 'c',
          label = 'Cancel',
        },
        {
          key = 'd',
          label = 'Discard',
          on_click = function()
            close_tab(tab_index)
          end,
        },
        {
          key = 's',
          label = 'Save',
          on_click = function()
            -- save_arena(tab_index)
            close_tab(tab_index)
          end,
          type = 'primary',
        },
      },
    })
    return
  end

  local was_active = editor.active_arena == tab_index
  local was_less = tab_index < editor.active_arena
  table.remove(editor.tabs, tab_index)
  table.remove(editor.arenas, tab_index)

  if was_less or was_active then
    editor.active_arena = math.max(1, editor.active_arena - 1)
  elseif #editor.tabs == 0 then
    editor.active_arena = nil
  end

  update_tabs()
end

return close_tab

-- Get list of files and directories in given directory
---@param directory string
local function get_file_list(directory)
  local items = {}
  local directory_items = love.filesystem.getDirectoryItems(directory)

  for _, item_name in ipairs(directory_items) do
    local info = love.filesystem.getInfo(item_name)
    if info then
      table.insert(items, {
        name = item_name,
        is_directory = info.type == "directory"
      })
    end
  end

  -- Sort: directories first, then files, alphabetically within each group
  table.sort(items, function(a, b)
    if a.is_directory and not b.is_directory then
      return true
    elseif not a.is_directory and b.is_directory then
      return false
    else
      return a.name < b.name
    end
  end)

  return items
end

return get_file_list

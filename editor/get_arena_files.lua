-- Get list of arena files in save directory
---@return FileInfo[]
local function get_arena_files()
  local items = {}
  local directory_items = love.filesystem.getDirectoryItems("")
  local save_dir = love.filesystem.getSaveDirectory()

  for _, item_name in ipairs(directory_items) do
    local info = love.filesystem.getInfo(item_name)
    local real_dir = love.filesystem.getRealDirectory(item_name)
    if real_dir == save_dir and
        info.type == "file" and
        item_name:sub(-6) == ".arena" then
      table.insert(items, {
        last_modified = info.modtime,
        name = item_name,
        size = info.size,
      })
    end
  end

  -- Sort alphabetically
  table.sort(items, function(a, b)
    return a.name < b.name
  end)

  return items
end

return get_arena_files

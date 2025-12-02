local settings = require('settings')

local function get_screen_center()
  return settings.resolution / 2, settings.resolution / 2
end

return get_screen_center

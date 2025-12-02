local round = require('util/round')
local settings = require('settings')

local function get_screen_center()
  return round(settings.resolution / 2), round(settings.resolution / 2)
end

return get_screen_center

local g = require('g')

local function take_screenshot(filename)
  filename = filename or string.format("screenshot_%s.png", os.time())
  -- Get the image data directly from the canvas (at native resolution)
  local image_data = g.canvas:newImageData()
  local file_data = image_data:encode("png")
  love.filesystem.write(filename, file_data)
  print("Screenshot saved: " .. filename)
end

return take_screenshot

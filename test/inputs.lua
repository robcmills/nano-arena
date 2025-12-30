local merge = require('util/merge')

local base_inputs = {
  down = false,
  left = false,
  right = false,
  up = false,
}

local inputs = {
  down = merge(base_inputs, { down = true }),
  left = merge(base_inputs, { left = true }),
  none = merge(base_inputs, {}),
  right = merge(base_inputs, { right = true }),
  up = merge(base_inputs, { up = true }),
}

return inputs

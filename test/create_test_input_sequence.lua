local g = require('g')
local inputs = require('test/inputs')

local function create_test_input_sequence(sequence)
  local state = {
    sequence = sequence,
    current_index = 1,
    is_waiting = false,
  }

  return function()
    -- If we've exhausted the sequence, return nil to signal end
    if state.current_index > #state.sequence then
      return nil
    end

    local current_input = inputs[state.sequence[state.current_index]]

    -- Check if we're waiting for a movement to complete
    if state.is_waiting then
      -- Movement is complete when last_move_time is nil and speed is 0
      local move_complete = g.player.last_move_time == nil and g.player.speed == 0

      if move_complete then
        -- Movement finished, advance to next input
        state.current_index = state.current_index + 1
        state.is_waiting = false

        -- Return none this frame, next input will be returned next frame
        return inputs.none
      else
        -- Still waiting, return no input
        return inputs.none
      end
    end

    -- Check if this is a movement input
    local is_movement = current_input == inputs.up or
        current_input == inputs.down or
        current_input == inputs.left or
        current_input == inputs.right

    if is_movement then
      -- Start waiting for this movement to complete
      state.is_waiting = true
    else
      -- Non-movement input, advance immediately
      state.current_index = state.current_index + 1
    end

    return current_input
  end
end

return create_test_input_sequence

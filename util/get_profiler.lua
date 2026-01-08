--- @class Profiler
--- @field start_section fun(name: string)
--- @field end_section fun(name: string)
--- @field print_profile fun()

--- @return Profiler
local function get_profiler()
  local profile = {
    startTime = 0,
    startMemory = collectgarbage("count"),
    sections = {}
  }

  local function start_section(name)
    collectgarbage("collect") -- Force GC for accurate memory measurement
    if profile.startTime == 0 then
      profile.startTime = love.timer.getTime()
    end
    profile.sections[name] = {
      startTime = love.timer.getTime(),
      startMemory = collectgarbage("count")
    }
  end

  local function end_section(name)
    local section = profile.sections[name]
    section.endTime = love.timer.getTime()
    section.endMemory = collectgarbage("count")
    section.duration = section.endTime - section.startTime
    section.memoryDelta = section.endMemory - section.startMemory
  end

  local function print_profile()
    local totalTime = love.timer.getTime() - profile.startTime
    local totalMemory = collectgarbage("count") - profile.startMemory

    print("\n========== GIF ENCODER PROFILE ==========")
    print(string.format("Total Time: %.4f seconds", totalTime))
    print(string.format("Total Memory Delta: %.2f KB", totalMemory))
    print("\n--- Section Breakdown ---")

    -- Sort sections by duration
    local sortedSections = {}
    for name, data in pairs(profile.sections) do
      table.insert(sortedSections, { name = name, data = data })
    end
    table.sort(sortedSections, function(a, b)
      return a.data.duration > b.data.duration
    end)

    for _, section in ipairs(sortedSections) do
      local pct = (section.data.duration / totalTime) * 100
      print(string.format("  %-30s %8.4fs (%5.1f%%)  %+.2f KB",
        section.name,
        section.data.duration,
        pct,
        section.data.memoryDelta))
    end
    print("==========================================\n")
  end

  return {
    end_section = end_section,
    print_profile = print_profile,
    start_section = start_section,
  }
end

return get_profiler

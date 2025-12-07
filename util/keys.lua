local function keys(table)
  local r={}
  for k in pairs(table) do
    r[#r+1]=k
  end
  return r
end

return keys

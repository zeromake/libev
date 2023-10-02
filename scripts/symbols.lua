local list = {}

local skip = {
  ev_child_start = 1,
  ev_child_stop = 2,
}

local lines = io.lines(path.join(os.scriptdir(), "Symbols.ev"))
for line in lines do
  if line ~= "" and skip[line] == nil then
    table.insert(list, line)
  end
end

lines = io.lines(path.join(os.scriptdir(), "Symbols.event"))
for line in lines do
  if line ~= "" and skip[line] == nil then
    table.insert(list, line)
  end
end

local extractMap = path.join(os.scriptdir(), "..", "build", "generate/libev.map")
local extractDef = path.join(os.scriptdir(), "..", "build", "generate/libev.def")

local extractMapFile = io.open(extractMap, "wb")
local extractDefFile = io.open(extractDef, "wb")

extractMapFile:write([[{
global:
]])
extractDefFile:write([[
LIBRARY
  EXPORTS
]])
for _, fn in ipairs(list) do
  extractMapFile:write(string.format('    %s;\n', fn))
  extractDefFile:write(string.format('        %s\n', fn))
end
extractMapFile:write([[local:*
}]])
extractMapFile:close()
extractDefFile:close()

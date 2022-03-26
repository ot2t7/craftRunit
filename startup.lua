-- Runit for CraftOS

local function split(str, sep)
    local result = {}
    local regex = ("([^%s]+)"):format(sep)
    for each in str:gmatch(regex) do
       table.insert(result, each)
    end
    return result
 end

local tasks = {}
local tasksDir = "/runit/"
local taskFiles = fs.list(tasksDir)

for _, file in ipairs(taskFiles) do
    local splitted = split(file, ".")
    if splitted[#splitted] == "lua" then
        local script = fs.open(tasksDir..file, "r").readAll()
        print("Found service: "..tasksDir..file)
        tasks[#tasks] = loadstring(script)
    end
end


print("Running services..")
parallel.waitForAll(unpack(tasks))
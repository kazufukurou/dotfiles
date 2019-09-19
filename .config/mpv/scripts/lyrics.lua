function file_exists(name)
    local f = io.open(name,"r")
    if f ~= nil then io.close(f) return true else return false end
end

function read_all(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

function run(command)
    local f = io.popen(command)
    local result = f:read("*a")
    f:close()
    return result
end

function main()
    fileName = mp.get_property("filename")
    filePath = mp.get_property("path")
    realFilePath = run("realpath \"" .. filePath .. "\"")
    lrcPath = realFilePath:gsub("%/[^/]+$", "/lyrics/" .. fileName:gsub("(%..+)$", ".txt"))
    if file_exists(lrcPath) then
        mp.commandv("print-text", "")
        mp.commandv("print-text", read_all(lrcPath))
    end
end

mp.register_event("file-loaded", main)

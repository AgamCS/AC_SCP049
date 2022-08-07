local dataDir = "ac_scp049"
local configDir = dataDir .. "/config.txt"
local cureDir = dataDir .. "/cures.txt"

local function loadConfig()
    local contents = file.Read(configDir)
    contents = util.JSONToTable(contents)
    AC_SCP49.config = contents
end

local function loadCures()
    local contents = file.Read(cureDir)
    contents = util.JSONToTable(contents)
    AC_SCP49.cures = contents
end

if SERVER then
    if (!file.Exists(dataDir, "DATA")) then
        file.CreateDir(dataDir)
    end

    if (file.Exists(configDir, "DATA")) then
        loadConfig()
    else
        local config = util.TableToJSON(AC_SCP49.config, true)
        file.Write(configDir, config)
    end

    if (file.Exists(cureDir, "DATA")) then
        loadCures()
    else
        local cures = util.TableToJSON(AC_SCP49.cures, true)
        file.Write(cureDir, cures)
    end
end
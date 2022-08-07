AC_SCP49.data = AC_SCP49.data or {}

// file.Find("ac_scp049", "data")
local dataDir = "ac_scp049"
local configDir = dataDir .. "/config.txt"



function AC_SCP49.data.writeConfig(data)
    file.Write(configDir, data)
end
local dataDir = "ac_scp049"
local configDir = dataDir .. "/config.txt"

local function loadConfig()
    local contents = file.Read(configDir)
    contents = util.JSONToTable(contents)
    AC_SCP49.config = contents
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

    net.Receive("ac_scp049.loadClientConfig", function(len, ply)
        local config = util.TableToJSON(AC_SCP49.config)
        config = util.Compress(config)
        net.Start("ac_scp049.loadClientConfig")
            net.WriteUInt(#config, 16)
            net.WriteData(config, #config)
        net.Send(ply)
    end)


end


if CLIENT then
    hook.Add("InitPostEntity", "loadClientConfig", function()
        net.Start("ac_scp049.loadClientConfig")
        net.SendToServer()
    end)

    net.Receive("ac_scp049.loadClientConfig", function()
        local len = net.ReadUInt(16)
        local config = net.ReadData(len)
        config = util.Decompress(config)
        AC_SCP49.config = util.JSONToTable(config)
        hook.Run("AC_SCP049.ClientConfigUpdated")
    end)

end
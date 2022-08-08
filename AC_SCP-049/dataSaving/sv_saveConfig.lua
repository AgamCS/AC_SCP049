// file.Find("ac_scp049", "data")
local dataDir = "ac_scp049"
local configDir = dataDir .. "/config.txt"

local exploitColor = Color(255, 0, 0)

local function writeConfig(data)
    data = util.TableToJSON(data, true)
    file.Write(configDir, data)
end

net.Receive("ac_scp049.verifyConfigChanges", function(len, ply)
    if !AC_SCP49.config["adminRanks"][ply:GetUserGroup()] then MsgC(exploitColor, "SCP 049 EXPLOIT: User " .. ply:Name() .. "(" .. ply:SteamID64() .. ") tried making changes to the config, but is not a valid rank!") return end 
    local len = net.ReadUInt(8)
    local changes = net.ReadData(len)
    local uncompChanges = util.Decompress(changes)
    uncompChanges = util.JSONToTable(uncompChanges)

    for k, v in pairs(uncompChanges) do
        AC_SCP49.config[k] = v
        Msg("Making change to " .. k)
    end
    writeConfig(AC_SCP49.config)
    DarkRP.notify(ply, 0, 10, AC_SCP49.getLang("changes_made_noti"))
    net.Start("ac_scp049.sendConfigToClients")
        net.WriteUInt(len, 8)
        net.WriteData(changes, len)
    net.Broadcast()
end)
net.Receive("ac_scp049.sendConfigToClients", function()
    local len = net.ReadUInt(8)
    local changes = net.ReadData(len)
    changes = util.Decompress(changes)
    changes = util.JSONToTable(changes)

    for k, v in pairs(changes) do
        AC_SCP49.config[k] = v
    end
    hook.Run("AC_SCP049.ClientConfigUpdated")
end)
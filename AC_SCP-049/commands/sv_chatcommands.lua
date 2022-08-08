hook.Add("PlayerSay", "SCP_049.ChatCommands", function(ply, txt)
    if AC_SCP49.config["adminMenuCommands"][txt] and AC_SCP49.config["adminRanks"][ply:GetUserGroup()] then
        ply:ConCommand("scp049_config")
        return ""
    end
end)

net.Receive("ac_scp049.checkRank", function(len, ply)
    if !AC_SCP49.config["adminRanks"][ply:GetUserGroup()] then return end
    net.Start("ac_scp049.checkRank")
    net.Send(ply)
end)
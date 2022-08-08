concommand.Add("scp049_config", function(ply)
    net.Start("ac_scp049.checkRank")
    net.SendToServer()
end)


net.Receive("ac_scp049.checkRank", function()
    if IsValid(AC_SCP49.configMenu) then
        AC_SCP49.configMenu:Remove()
    end
    AC_SCP49.configMenu = vgui.Create("scp_049_configMain")
end)



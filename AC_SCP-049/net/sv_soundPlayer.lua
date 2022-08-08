net.Receive("ac_scp049.playSound", function(len, ply)
    local index = net.ReadUInt(5)
    local soundFile = AC_SCP49.config["soundMenu"][index].soundFile
    ply:EmitSound(soundFile, AC_SCP49.config["soundLevel"], 100, 1)
end)


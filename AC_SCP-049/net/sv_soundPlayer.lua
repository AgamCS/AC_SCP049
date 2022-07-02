net.Receive("ac_scp049.playSound", function(len, ply)
    local index = net.ReadUInt(5)
    print(index)
    local soundFile = AC_SCP49.config.soundMenu[index].soundFile
    print(soundFile)
    ply:EmitSound(soundFile, AC_SCP49.config.soundLevel, 100, 1)
end)


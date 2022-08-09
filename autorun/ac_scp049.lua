AC_SCP49 = AC_SCP49 or {}

local function addDir(path)
    local files, folders = file.Find(path .. "*", "LUA")
        for k, v in pairs(files) do
            if string.StartWith(v, "sh_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                end
                include(path .. v)
            elseif string.StartWith(v, "sv_") then
                include(path .. v)
            elseif  string.StartWith(v, "cl_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                elseif CLIENT then
                    include(path .. v)
                end
            end
        end
end

addDir("AC_SCP-049/libs/outline/")
addDir("AC_SCP-049/lang/")
addDir("AC_SCP-049/config/")
addDir("AC_SCP-049/loaders/")
addDir("AC_SCP-049/dataSaving/")
addDir("AC_SCP-049/cures/")
addDir("AC_SCP-049/net/")
addDir("AC_SCP-049/vgui/")
addDir("AC_SCP-049/zombies/")
addDir("AC_SCP-049/player/")
addDir("AC_SCP-049/commands/")

if SERVER then
    util.AddNetworkString("ac_scp049.playSound")
    util.AddNetworkString("ac_scp049.setupPlayer")
    util.AddNetworkString("ac_scp049.startMix")
    util.AddNetworkString("ac_scp049.requestCureList")
    util.AddNetworkString("ac_scp049.requestEquipCure")
    util.AddNetworkString("ac_scp049.requestRemoveCure")
    util.AddNetworkString("ac_scp049.sendZombieAdd")
    util.AddNetworkString("ac_scp049.sendZombieRemove")
    util.AddNetworkString("ac_scp049.playerBecame0492")
    util.AddNetworkString("ac_scp049.playerBecameSCP049")
    util.AddNetworkString("ac_scp049.loadClientConfig")
    util.AddNetworkString("ac_scp049.verifyConfigChanges")
    util.AddNetworkString("ac_scp049.sendConfigToClients")
    util.AddNetworkString("ac_scp049.checkRank")
    util.AddNetworkString("ac_scp049.sendReviveCam")

end

MsgC(Color(0, 255, 0), "[SCP 049]: All files loaded")

if CLIENT then
    AC_SCP49.mixStartTime = 0
end
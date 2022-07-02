AC_SCP49 = AC_SCP49 or {}

local function addDir(path)
    local files, folders = file.Find(path .. "*", "LUA")
        for k, v in pairs(files) do
            if string.StartWith(v, "sh_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                    print("[SCP-049] Added CS File:" .. path..v)
                end
                include(path .. v)
            elseif string.StartWith(v, "sv_") then
                include(path .. v)
                print("[SCP-049] Added SV File:" .. path..v)
            elseif  string.StartWith(v, "cl_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                    print("[SCP-049] Added CS File:" .. path..v)
                elseif CLIENT then
                    include(path .. v)
                    print("[SCP-049] Added CS File:" .. path..v)
                end
            end
        end
end

addDir("AC_SCP-049/lang/")
addDir("AC_SCP-049/config/")
addDir("AC_SCP-049/loaders/")
addDir("AC_SCP-049/cures/")
addDir("AC_SCP-049/net/")
addDir("AC_SCP-049/vgui/")
addDir("AC_SCP-049/player/")

if SERVER then
    util.AddNetworkString("ac_scp049.playSound")
    util.AddNetworkString("ac_scp049.setupPlayer")
    util.AddNetworkString("ac_scp049.startMix")
    util.AddNetworkString("ac_scp049.requestCureList")
    util.AddNetworkString("ac_scp049.requestCurrentCure")
end

if CLIENT then
    AC_SCP49.mixStartTime = 0
end
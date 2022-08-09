local _P = FindMetaTable("Player")
local reviveSound = Sound("npc/zombie/zombie_alert1.wav")


local function compress(table)
    local statusInfo = util.TableToJSON(table)
    statusInfo = util.Compress(statusInfo)
    local len = #statusInfo
    return statusInfo, len
end

local function runScriptedSequence(ply)
    ply:Lock()
    local anim = ply:SelectWeightedSequence(ACT_HL2MP_ZOMBIE_SLUMP_RISE)
    local seqDuration = ply:SequenceDuration(anim)
    ply:DoAnimationEvent( ACT_HL2MP_ZOMBIE_SLUMP_RISE )
    ply:EmitSound(reviveSound)
    net.Start("ac_scp049.sendReviveCam")
        net.WriteUInt(seqDuration, 4)
    net.Send(ply)
    timer.Simple(seqDuration, function()
        ply:UnLock()
    end)
end


function _P:addCure(cureType)
    if !cureType then return end
    local cure = AC_SCP49.getCure(cureType)
    if !cure then return end
    self.cureCount = self.cureCount + 1
    if self.cures[cure.class] then self.cures[cure.class].amount = self.cures[cure.class].amount + 1 return end
    self.cures[cure.class] = cure
    self.cures[cure.class].amount = 1
end

function _P:getCures()
    return self.cures
end

function _P:equipCure(cureType)
    if !cureType then return end
    local cure = AC_SCP49.getCure(cureType)
    if !cure then return end
    
    if SERVER then
        self.equippedCure = cureType
    end

    if CLIENT then
        net.Start("ac_scp049.requestEquipCure")
            net.WriteString(cureType)
        net.SendToServer()
    end

end
// 76561198249861928
concommand.Add("equipCure", function()
    local me = player.GetBySteamID64("76561198249861928")
    me:applyCureToVictim("redred", me)
end)

function _P:unequipCure()
    self.equippedCure = nil
end

function _P:getCurrentCure()
    return self.equippedCure
end

function _P:getCurrentCureName()
    local cure = AC_SCP49.getCure(self.equippedCure)
    if !cure then
        return
    end
    return cure.name
end

function _P:is0492()
    return self.isPlayer0492
end

function _P:setIs0492(state)
    if !SERVER then return end
    self.isPlayer0492 = tobool(state)
    if state then
        AC_SCP49.zombie.Add(self)
    else
        AC_SCP49.zombie.Remove(self)
    end
    net.Start("ac_scp049.playerBecame0492")
        net.WriteBool(state)
    net.Send(self)
end

function _P:isSCP049()
    return self.isPlayerSCP049
end

function _P:applyCureToVictim(cureType, victim)
    if !SERVER then return end
    if !self.cures[cureType] || self.cures[cureType].amount < 1 then return end
    local cureTable = AC_SCP49.getCure(cureType) 
    if !cureTable then return end
    cureTable.effect(victim)
    local pos = victim:GetPos()
    victim:Spawn()
    victim:SetPos(pos)
    victim.scp0492oldModel = victim:GetModel()
    victim:SetModel(AC_SCP49.config["zombieModel"])
    victim:StripWeapons()
    timer.Simple(0, function()
        victim:Give("weapon_scp_zombie")
        victim:setIs0492(true)
        runScriptedSequence(victim)
        self.cureCount = self.cureCount - 1
        self.cures[cureType].amount = self.cures[cureType].amount - 1
        if self.cures[cureType].amount < 1 then
            self.cures[cureType] = nil
            self:unequipCure()
            net.Start("ac_scp049.requestRemoveCure")
                net.WriteString(cureType)
            net.Send(self)
        end
    end)
end


function _P:isMixing()
    return self.isPlayerMixing
end

function _P:setIsMixing(cureType, state)
    if (!cureType || !AC_SCP49.getCure(cureType)) && state == true then return end
    state = tobool(state)
    if state == true && self.cureCount >= AC_SCP49.config["cureLimit"] then DarkRP.notify(self, 1, 5, AC_SCP49.getLang("cure_limit")) return end
    if CLIENT then
        self.isPlayerMixing = state
        net.Start("ac_scp049.startMix")
            net.WriteBool(state)
            if cureType then
                net.WriteString(cureType)
            end
        net.SendToServer()
        if state == false then return end
        timer.Create(self:SteamID64() .. " ac_scp049.mixingTimer", AC_SCP49.config["mixTime"], 1, function()
            self:setIsMixing(false)
            self:addCure(cureType)
        end)
    end
    if SERVER then
        self.isPlayerMixing = state
        if state == false then return end
        timer.Create(self:SteamID64() .. " ac_scp049.mixingTimer", AC_SCP49.config["mixTime"], 1, function()
            self:setIsMixing(false)
            self:addCure(cureType)
            DarkRP.notify(self, 2, 5, AC_SCP49.getLang("done_mixing"))
        end)
    end
    
end

if SERVER then
    hook.Add("PlayerDeath", "AC_SCP049.ResetIs0492", function(victim)
        if IsValid(victim) && victim:is0492() then
            //victim:SetKnocked(false)
            victim:setIs0492(false)
            victim:SetModel(victim.scp0492oldModel)
            victim:Spawn()
        end
    end)

    hook.Add("PlayerChangedTeam", "AC_SCP049.change049Status", function(ply, oldTeam, newTeam)
        local oldTeamName, newTeamName = team.GetName(oldTeam), team.GetName(newTeam)
        if oldTeamName == AC_SCP49.config["scp049Job"] then
            ply.isPlayerSCP049 = false
            net.Start("ac_scp049.playerBecameSCP049")
                net.WriteBool(false)
            net.Send(ply)
            return
        end
        if newTeamName == AC_SCP49.config["scp049Job"] then
            ply.isPlayerSCP049 = true
            AC_SCP49.zombie.Add(ply)
            net.Start("ac_scp049.playerBecameSCP049")
                net.WriteBool(true)
            net.Send(ply)
            return
        end

    end)

    net.Receive("ac_scp049.setupPlayer", function(len, ply)
        ply.isPlayer0492 = false
        ply.isPlayerMixing = false
        ply.cures = {}
        ply.cureCount = 0
        ply.currentCure = ""
        ply.equippedCure = nil
        ply.isPlayerSCP049 = false
        net.Start("ac_scp049.setupPlayer")
            local zombieList, len = compress(AC_SCP49.zombie.list)
            net.WriteUInt(len, 8)
            net.WriteData(zombieList, len) 
        net.Send(ply)
    end)

    net.Receive("ac_scp049.startMix", function(len, ply)
        local state = net.ReadBool()
        local cure = net.ReadString()
        ply:setIsMixing(cure, state)
    end)

    net.Receive("ac_scp049.requestEquipCure", function(len, ply)
        local cureClass = net.ReadString()
        if ply.cures[cureClass] then
            net.Start("ac_scp049.requestEquipCure")
                net.WriteString(cureClass)
            net.Send(ply)
            ply:equipCure(cureClass)
        end
    end)
end

if CLIENT then

    

    hook.Add("InitPostEntity", "AC_SCP049.SetupPlayer", function()
        local ply = LocalPlayer()
        net.Start("ac_scp049.setupPlayer")
        net.SendToServer()
        ply.cures = {}
        ply.cureCount = 0
        ply.currentCure = ""
        ply.equippedCure = nil
        ply.isPlayerSCP049 = false
    end)

    net.Receive("AC_SCP49.zombie.list", function()
        local len = net.ReadUInt(8)
        local data = net.ReadData(8)
        data = util.Decompress(data)
        data = util.JSONToTable(data)
        AC_SCP49.zombie.list = data
    end)

    net.Receive("ac_scp049.requestEquipCure", function()
        local cureClass = net.ReadString()
        LocalPlayer().equippedCure = cureClass
    end)

    net.Receive("ac_scp049.playerBecame0492", function()
        local state = net.ReadBool()
        LocalPlayer().isPlayer0492 = state
    end)

    net.Receive("ac_scp049.playerBecameSCP049", function()
        local state = net.ReadBool()
        LocalPlayer().isPlayerSCP049 = state
    end)

    net.Receive("ac_scp049.requestRemoveCure", function()
        local ply = LocalPlayer()
        local cureType = net.ReadString()
        if ply.cures[cureType] then
            ply.cures[cureType] = nil
            ply:unequipCure()
            ply.cureCount = ply.cureCount - 1
        end
    end)

    

    net.Receive("ac_scp049.sendReviveCam", function()
        local duration = net.ReadUInt(4)
        
        hook.Add("CalcView", "AC_SCP049.ReviveCam", function(ply, origin, angles, fov)
            local view = {
                origin = origin - ( angles:Forward() * 100 ),
                angles = -ply:EyeAngles(),
                fov = fov,
                drawviewer = true
            }
            return view
        end)

        timer.Simple(duration, function()
            hook.Remove("CalcView", "AC_SCP049.ReviveCam")
        end)

    end)

    hook.Add("PlayerDisconnected", "AC_SCP049.CleanUpPlayer", function(ply)
        AC_SCP49.zombie.Remove(ply)
    end)

end




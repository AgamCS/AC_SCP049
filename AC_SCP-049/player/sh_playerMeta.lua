local _P = FindMetaTable("Player")


function _P:addCure(cureType)
    if !cureType then return end
    local cure = AC_SCP49.getCure(cureType)
    if !cure then return end
    self.cureCount = self.cureCount + 1
    if SERVER then print(self.cures[cure.class]) end
    if self.cures[cure.class] then self.cures[cure.class].amount = self.cures[cure.class].amount + 1 return end
    self.cures[cure.class] = cure
    self.cures[cure.class].amount = 1
    PrintTable(self.cures[cure.class])
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
        print(self.equippedCure)
    end

    if CLIENT then
        net.Start("ac_scp049.requestEquipCure")
            net.WriteString(cureType)
        net.SendToServer()
    end

end

function _P:unequipCure()
    self.equippedCure = nil
end

function _P:getCurrentCure()
    print(self.equippedCure)
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
    self.isPlayer0492 = tobool(state)
end

function _P:applyCureToVictim(cureType, victim)
    if !SERVER then return end
    if !cureType then DarkRP.notify(self, 1, 5, "You do not have a cure equipped!") return end
    if !self.cures[cureType] || self.cures[cureType].amount < 1 then return end
    cureType = AC_SCP49.getCure(cureType) 
    if !cureType then return end
    cureType.effect(self)
    victim:SetModel(AC_SCP49.config.zombieModel)
    victim:Spawn()
    victim:SetPos(victim:GetPos())
    print(victim)
    //victim:setIs0492(true)
    self.cures[cureType].amount = self.cures[cureType].amount - 1
    if self.cures[cureType].amount < 1 then
        self.cures[cureType] = nil
        net.Start("ac_scp049.requestRemoveCure")
            net.WriteString(cureType)
        net.Send(self)
    end
end


function _P:isMixing()
    return self.isPlayerMixing
end

function _P:setIsMixing(cureType, state)
    if (!cureType || !AC_SCP49.getCure(cureType)) && state == true then return end
    state = tobool(state)
    if state == true && self.cureCount >= AC_SCP49.config.cureLimit then DarkRP.notify(self, 1, 5, AC_SCP49.getLang("cure_limit")) return end
    if CLIENT then
        self.isPlayerMixing = state
        net.Start("ac_scp049.startMix")
            net.WriteBool(state)
            if cureType then
                net.WriteString(cureType)
            end
        net.SendToServer()
        if state == false then return end
        timer.Create(self:SteamID64() .. " ac_scp049.mixingTimer", AC_SCP49.config.mixTime, 1, function()
            self:setIsMixing(false)
            self:addCure(cureType)
        end)
    end
    if SERVER then
        self.isPlayerMixing = state
        if state == false then return end
        timer.Create(self:SteamID64() .. " ac_scp049.mixingTimer", AC_SCP49.config.mixTime, 1, function()
            self:setIsMixing(false)
            self:addCure(cureType)
            DarkRP.notify(self, 2, 5, AC_SCP49.getLang("done_mixing"))
        end)
    end
    
end

if SERVER then
    hook.Add("PlayerDeath", "AC_SCP049.ResetIs0492", function(victim, inflictor, attacker)
        if IsValid(victim) && victim:is0492() then
            victim:setIs0492(false)
        end
    end)

    net.Receive("ac_scp049.setupPlayer", function(len, ply)
        ply:setIs0492(false)
        ply:setIsMixing(false)
        ply.cures = {}
        ply.cureCount = 0
        ply.currentCure = ""
        ply.equippedCure = nil
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
    end)

    net.Receive("ac_scp049.requestEquipCure", function()
        local cureClass = net.ReadString()
        LocalPlayer().equippedCure = cureClass
    end)

    net.Receive("ac_scp049.requestRemoveCure", function()
        local cureType = net.ReadString()
        if self.cures[cureType] then
            self.cures[cureType] = nil
        end
    end)

end




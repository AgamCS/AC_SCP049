local _P = FindMetaTable("Player")


function _P:addCure(cureType)
    if CLIENT then return end
    if !cureType then return end
    local cure = AC_SCP49.getCure(cureType)
    if !cure then return end
    self.cureCount = self.cureCount + 1
    if self.cures[cure.class] then self.cures[cure.class].amount = self.cures[cure.class].amount + 1 return end
    self.cures[cure.class] = cure
    self.cures[cure.class].amount = 1
end

function _P:getCures()
    if SERVER then
        return cureType
    else
        net.Start("ac_scp049.requestCureList")
        net.SendToServer()
    end
end

function _P:removeCure(cureName)
    if !self.cures[cureName] then return end
    self.cures[cureName] = {}
end

function _P:getCures()
    return self.cures
end

function _P:is0492()
    return self.isPlayer0492
end

function _P:setIs0492(state)
    self.isPlayer0492 = tobool(state)
end

function _P:applyCure(cureType, spawnPos)
    if !SERVER then return end
    if !self.cures[cureType] || self.cures[cureType] < 1 then return end
    cureType = AC_SCP49.getCure(cureType) 
    if !cureType then return end
    cureType.effect(self)
    self:SetModel(AC_SCP49.config.zombieModel)
    self:Spawn()
    self:SetPos(spawnPos)
    self.setIs0492(true)
    self.cures[cureType].amount = self.cures[cureType].amount - 1
end


function _P:isMixing()
    return self.isPlayerMixing
end

function _P:setIsMixing(cureType, state)
    if (!cureType || !AC_SCP49.getCure(cureType)) && state == true then return end
    state = tobool(state)
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
        end)
    end
    if SERVER then
        if state == true && self.cureCount >= AC_SCP49.config.cureLimit then DarkRP.notify(self, 1, 8, AC_SCP49.getLang("cure_limit")) return end
        self.isPlayerMixing = state
        if state == false then return end
        timer.Create(self:SteamID64() .. " ac_scp049.mixingTimer", AC_SCP49.config.mixTime, 1, function()
            self:setIsMixing(false)
            self:addCure(cureType)
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
    end)

    net.Receive("ac_scp049.startMix", function(len, ply)
        local state = net.ReadBool()
        local cure = net.ReadString()
        ply:setIsMixing(cure, state)
    end)

    net.Receive("ac_scp049.requestCureList", function(len, ply)
        net.Start("ac_scp049.requestCureList")
            local json = util.TableToJSON(self.cures)
            json = util.Compress(json)
            local len = #json
            net.WriteUInt(len, 8)
            net.WriteData(json, len)
        net.Send(ply)
    end)
end

if CLIENT then
    hook.Add("InitPostEntity", "AC_SCP049.SetupPlayer", function()
        net.Start("ac_scp049.setupPlayer")
        net.SendToServer()
        ply.cures = {}
        ply.currentCure = ""
    end)
    
    net.Receive("ac_scp049.requestCureList", function()
        local len = net.ReadUInt(8)
        local data = net.ReadData(len)
        data = util.Decompress(data)
        data = util.JSONToTable(data)
        LocalPlayer().cures = data
    end)
end




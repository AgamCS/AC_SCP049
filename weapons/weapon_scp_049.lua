SWEP.PrintName = "SCP-049"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Weight = 5
SWEP.SlotPos = 2
SWEP.Slot = 4
SWEP.DrawAmmo = false

SWEP.ViewModel = "models/scp049/weapons/c_scp049.mdl"
SWEP.WorldModel = ""

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.currentCure = ""

SWEP.Primary.AttackDelay = 0.3 // Delay before you are able to attempt to kill again
SWEP.Primary.AttackRange = 100 // Range 
SWEP.Primary.CureRange = 100

// HUD COLORS
local background = Color(50,50,50,200)
local outline = Color(255,255,255,50)
local edges = Color(255,255,255,120)
local progress = Color(150, 150, 150)

function SWEP:Initalize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    self:SetSequence("flask_mix")
    self:ResetSequence("flask_mix")
    
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    self:SetSequence("flask_mix")
    self:ResetSequence("flask_mix")
    self:SetNextPrimaryFire( CurTime() + self.Primary.AttackDelay )
    if !SERVER then return end
    local tr = util.TraceLine( {
        start = owner:EyePos(),
        endpos = owner:EyePos() + owner:EyeAngles():Forward() * self.Primary.AttackRange,
        filter = owner,
        ignoreworld = true,
    })
    if !tr.Entity:IsValid() then return end    
    if tr.Entity:GetNW2Bool("IsPlayerRagdoll", false) then
        if !tr.Entity.DeathRagdoll then return end
        local victimPos = tr.Entity:GetPos()
        local victim = tr.Entity.DeathRagdoll:GetOwner()
        victim:applyCure("redyellow", victimPos)
    elseif tr.Entity:IsValid() && !AC_SCP49.config.immuneModels[tr.Entity:GetModel()] then
        tr.Entity:TakeDamage(tr.Entity:Health(), owner, self)
    end
end

function SWEP:SecondaryAttack()
    self:SetSequence("flask_draw")
    self:ResetSequence("flask_draw")
    if !CLIENT then return end
    if IsValid(AC_SCP49.testPanel) then
        AC_SCP49.testPanel:Remove()
    end
    AC_SCP49.testPanel = vgui.Create("scp_049_cureMenu")
    AC_SCP49.testPanel:SetSize(ScrW() * 0.8, ScrH() * 0.7)
    AC_SCP49.testPanel:Center()
end

function SWEP:Reload()
    if SERVER then return end
    if IsValid(self.soundMenu) then
        self.soundMenu:Remove()
    end

    self.soundMenu = vgui.Create("scp_049_soundList")
    self.soundMenu:SetSize(ScrW() * 0.3, ScrH() * 0.7)
    self.soundMenu:Center()
    self.soundMenu:SetTitle("Sounds")
    self.soundMenu:ShowCloseButton()
    self.soundMenu:createSounds()
end

if CLIENT then
    function SWEP:DrawHUD()
        local owner = self:GetOwner()
        draw.SimpleText(string.format(AC_SCP49.getLang("swep_hud_text"), input.LookupBinding("+attack2")), "AC_SCP049.FontScale12", ScrW() * 0.175, ScrH() * 0.97, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        if !owner:isMixing() then return end
        if AC_SCP49.testPanel && AC_SCP49.testPanel:IsVisible() then return end
        local time = AC_SCP49.mixStartTime  + AC_SCP49.config.mixTime - AC_SCP49.mixStartTime 
        local curtime = CurTime() - AC_SCP49.mixStartTime 
        local timeleft = math.Round(timer.TimeLeft(owner:SteamID64() .. " ac_scp049.mixingTimer"), 1) 
        local endtime = AC_SCP49.config.mixTime - timeleft
        local scrw, scrh = ScrW(), ScrH()
        local x, y, width, height = scrw * 0.5 - scrw * 0.15, scrh * 0.8 - scrh * 0.05, scrw * 0.3, scrh * 0.07
        local status = math.Clamp(curtime / time, 0, 1)
        local barWidth = status * width - 16
        surface.SetDrawColor(background)
        surface.DrawRect(x, y, width, height)
        surface.SetDrawColor(outline)
        surface.DrawOutlinedRect(x, y, width, height)
        surface.SetDrawColor(edges)
        AC_SCP49.DrawEdges(x, y, width, height,  8, 2)
        surface.SetDrawColor(progress)
        surface.DrawRect(x + 8, y + 7, barWidth, height * 0.2)

        draw.SimpleText("MIXING CURE", "AC_SCP049.Font", scrw * 0.5 , scrh * 0.8 - 20, color_white, 1, 1)
        draw.SimpleText(timeleft, "AC_SCP049.FontScale12", scrw * 0.5 , scrh * 0.8, color_white, 1, 1)

    end
end

function SWEP:Think()
    local owner = self:GetOwner()
    local min, max = owner:OBBMins(), owner:OBBMaxs()
    local startpos = owner:GetPos()
    if SERVER then
        local tr = util.TraceHull(
            {
                start = startpos,
                endpos = startpos + owner:GetUp() * 192,
                filter = owner,
                mins = min,
                max = max,
                ignoreworld = true,
            }) 
            
            if !tr.Entity:IsValid() then return end
            if AC_SCP49.config.immuneModels[tr.Entity:GetModel()] then return end 
            tr.Entity:TakeDamage(tr.Entity:Health(), owner, self)
    end
end


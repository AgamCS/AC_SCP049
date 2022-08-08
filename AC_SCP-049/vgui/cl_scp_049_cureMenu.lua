local background = Color(60, 60, 60)
local potionOutline = Color(10, 10, 10)
local outline = Color(50, 50, 50)
local potionBackground = Color(33, 33, 33)
local hoverColor = Color(100, 100, 200)
local progress = Color(150, 150, 150)


local PANEL = {}

local t = {
    [1] = "red",
    [2] = "green",
    [3] = "blue",
    [4] = "yellow",
    [5] = "cyan",
    [6] = "pink",
    [7] = "white",
}

function PANEL:Init()
    self:SetTitle(AC_SCP49.getLang("cure_title"))
    self:SetBackgroundColor(background)
    self:SetOutlineColor(outline)
    self:DrawOutline(true)
end

function PANEL:cureMenuLayout()
    local pW, pH = self:GetWide(), self:GetTall()
    local ingredientWide, ingredientTall = pW * 0.85, pH * 0.2
    self.ingredient1 = vgui.Create("scp_049_ingredientPanel", self)
    local ingW, ingH = pW * 0.2, pH * 0.4
    self.ingredient1:SetSize(ingW, ingH)
    self.ingredient1:SetPos((pW * 0.01) + (ingW/2), (ingH/2))
    self.ingredient1:SetModel(AC_SCP49.config["ingredientModel"])

    
    self.ingredient2 = vgui.Create("scp_049_ingredientPanel", self)
    self.ingredient2:SetSize(ingW, ingH)
    self.ingredient2:SetPos((pW * 0.3) + (ingW/2), (ingH/2))
    self.ingredient2:SetModel(AC_SCP49.config["ingredientModel"])

    self.cure = vgui.Create("scp_049_ingredientPanel", self)
    self.cure:SetSize(ingW, ingH)
    self.cure:SetPos((pW * 0.6) + (ingW/2), (ingH/2))
    self.cure:SetModel(AC_SCP49.config["cureModel"])
    self.cure:SetPanelAsCure(self.ingredient1, self.ingredient2)

    self.ingredient1:SetPanelAsIngredient(self.cure)
    self.ingredient2:SetPanelAsIngredient(self.cure)

    local ingredientBackground = vgui.Create("DPanel", self)
    ingredientBackground:SetSize(ingredientWide, ingredientTall)
    ingredientBackground:CenterHorizontal()
    ingredientBackground:SetPos(ingredientBackground:GetX(), pH * 0.7)
    ingredientBackground.Paint = function(s, w, h)
        //surface.SetDrawColor(ingredientBackgroundColor)
        //surface.DrawRect(0, 0, w, h)
    end

    local ingredientScroll = vgui.Create("DHorizontalScroller", ingredientBackground)
    ingredientScroll:Dock(FILL)
    ingredientScroll:DockPadding(ingredientWide * 0.001, ingredientTall * 0.05, ingredientWide * 0.001, ingredientTall * 0.1)
    for k, v in pairs(t) do
        local modelPanel = vgui.Create("DPanel", ingredientScroll)
        modelPanel:SetSize(ingredientWide * 0.1, ingredientTall * 0.9)        
        modelPanel:DockMargin(ingredientWide * 0.03, ingredientTall * 0.01, ingredientWide * 0.01, 0)
        modelPanel:Dock(LEFT)
        modelPanel.Paint = function(s, w, h)
            surface.SetDrawColor(potionBackground)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(potionOutline)
            surface.DrawOutlinedRect(0, 0, w, h, 4)
            draw.SimpleText(AC_SCP49.config["ingredients"][v].name, "AC_SCP049.Font", w * 0.5, 0 + h * 0.11, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        local potion = vgui.Create("DModelPanel", modelPanel)
        potion.name = v
        potion:StretchToParent(0, 0, 0, 0)
        potion:SetModel(AC_SCP49.config["ingredients"][v].model)
        potion:SetColor(AC_SCP49.config["ingredients"][v].color)
        local ent = potion:GetEntity()
        ent:SetModelScale(3)
        ent:SetPos(ent:GetPos() + Vector(0, 0, 25))
        potion.LayoutEntity = function(ent)

        end
        
        potion.DoClick = function()
            if self.ingredient1:GetIngredient() && self.ingredient2:GetIngredient() then
                return
            elseif self.ingredient1:GetIngredient() then
                self.ingredient2:SetIngredient(potion.name)
            else
                self.ingredient1:SetIngredient(potion.name)
            end

            if !IsValid(self.ingredient1) || !IsValid(self.ingredient2) then return end
            local ing1, ing2 = self.ingredient1:GetIngredient(), self.ingredient2:GetIngredient() 
            if !self.ingredient1:GetIngredient() || !self.ingredient2:GetIngredient() then return end
            local cure = ing1 .. ing2
            self.cure:SetCure(ing1, ing2)

        end

        potion.OnCursorEntered = function(s)
            local ent = s:GetEntity()
            ent:SetModelScale(3.5)
        end

        potion.OnCursorExited = function(s)
            local ent = s:GetEntity()
            ent:SetModelScale(3)
        end 

    end

    local mixButton = vgui.Create("DButton", self)
    local mixButtonW, mixButtonH = pW * 0.205, pH * 0.05
    mixButton:SetSize(mixButtonW, mixButtonH)
    mixButton:SetPos( (mixButtonW * 2.88) + (mixButtonW / 2 ), (pH * 0.4) + (pH / 2)  )
    mixButton:SetText(" ")
    mixButton.Paint = function(s, w, h)
        local ply = LocalPlayer()
        surface.SetDrawColor(potionBackground)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(potionOutline)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
        if s:IsHovered() && !ply:isMixing() then
            draw.SimpleText(AC_SCP49.getLang("start_mixing"), "AC_SCP049.Font", w * 0.5, h * 0.5, hoverColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif !s:IsHovered() && !ply:isMixing() then
            draw.SimpleText(AC_SCP49.getLang("start_mixing"), "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    mixButton.DoClick = function(s)
        local ply = LocalPlayer()
        if ply:isMixing() then notification.AddLegacy(AC_SCP49.getLang("already_mixing"), 1, 5) return end
        AC_SCP49.mixStartTime = CurTime()
        ply:setIsMixing(self.cure:GetCure(), true)
    end

    local mixProgress = vgui.Create("DPanel", self)
    mixProgress:SetPos( (mixButtonW * 2.88) + (mixButtonW / 2 ), (pH * 0.4) + (pH / 2)  )
    mixProgress:SetSize(mixButtonW, mixButtonH)
    mixProgress:SetMouseInputEnabled(false)

    mixProgress.Paint = function(s, w, h)
        local ply = LocalPlayer()
        if !ply:isMixing() then return end
        local time = AC_SCP49.mixStartTime + AC_SCP49.config["mixTime"] - AC_SCP49.mixStartTime
        local curTime = CurTime() - AC_SCP49.mixStartTime
        local timeleft = math.Round(timer.TimeLeft(ply:SteamID64() .. " ac_scp049.mixingTimer"), 1) 
        local endtime = AC_SCP49.config["mixTime"] - timeleft
        local status = math.Clamp(curTime / time, 0, 1)
        local barWidth = status * w - 16
        surface.SetDrawColor(progress)
        surface.DrawRect(0, 0, barWidth, h)
        draw.SimpleText(AC_SCP49.getLang("is_mixing") .. " " .. timeleft, "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local infoPanel = vgui.Create("DPanel", self)
    infoPanel:SetSize(mixButtonW, mixButtonH)
    infoPanel:SetPos( (mixButtonW * 0.0001) + (mixButtonW / 2 ), (pH * 0.4) + (pH / 2)  )
    infoPanel.Paint = function(s, w, h)
        surface.SetDrawColor(potionBackground)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(potionOutline)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
        draw.SimpleText(string.format(AC_SCP49.getLang("cure_bag_bind"), string.upper(input.LookupBinding("+use")), input.LookupBinding("+attack")), "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:OnSizeChanged()
    self:InvalidateLayout()
    self:ShowCloseButton()
    self:cureMenuLayout()
end

function PANEL:Paint(w, h)
    local ing1, ing2 = AC_SCP49.getIngredientName(self.ingredient1:GetIngredient()), AC_SCP49.getIngredientName(self.ingredient2:GetIngredient())
    surface.SetDrawColor(self.backgroundColor)
    surface.DrawRect(0, 0, w, h)
    draw.SimpleText(self.Title, "AC_SCP049.FontScale12", 0 + 5, 0 + 15, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText(string.format(AC_SCP49.getLang("cure_name"), ing1, ing2), "AC_SCP049.FontScale12", w * 0.5, h * 0.15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(AC_SCP49.getLang("cure_instructions"), "AC_SCP049.Font", w * 0.5, h * 0.67, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText("+", "AC_SCP049.Symbol", w * 0.35, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText("=", "AC_SCP049.Symbol", w * 0.65, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    if !self.drawOutline then return end
    surface.SetDrawColor(self.outlineColor)
    surface.DrawOutlinedRect(0, 0, w, h, 4)
end

vgui.Register("scp_049_cureMenu", PANEL, "scp_049_panel")

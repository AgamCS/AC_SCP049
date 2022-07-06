local PANEL = {}
local closeColor = Color(255, 0, 0)
local fadeEnd = 0
local timeUntilFade = 5
local selectedCure
local fadeString = ""
function PANEL:Init()
    self:SetTitle(AC_SCP49.getLang("cure_bag"))
    self.cures = LocalPlayer():getCures() or {}
    local scroller = vgui.Create("DScrollPanel", self)
    scroller:Dock(FILL)
end

function PANEL:createCures()
    local ply = LocalPlayer()
    self.cures = ply.cures
    local pW, pH = self:GetWide(), self:GetTall()
    local xSpace = pW * 0.01
    self:DockPadding(pW * 0.01, pH * 0.4, pW * 0.001, pH * 0.3)
    if !self.cures then return end
    for k, v in pairs(self.cures) do
        local curePanel = vgui.Create("scp_049_ingredientPanel", self)
        curePanel:SetSize(pW * 0.1, pH * 0.2)
        curePanel:DockMargin(0, pH * 0.05, pW * 0.01, 0)
        curePanel:Dock(LEFT)
        curePanel:SetPos(xSpace, pH * 0.1)
        curePanel:SetPanelAsCure(true)
        curePanel:SetCure(v.class)
        curePanel:SetModel(v.model, 3.5)
        curePanel:SetColor(v.color)
        curePanel:SetTooltip(v.name .. " x" .. v.amount)

        curePanel.DoClick = function(s)
            if selectedCure == v then
                ply:unequipCure()
                fadeEnd = CurTime() + timeUntilFade
                fadeString = string.format(AC_SCP49.getLang("unequipped_cure"), selectedCure.name or "Error")
                selectedCure = nil
            else
                selectedCure = v
                ply:equipCure(k)
                fadeEnd = CurTime() + timeUntilFade
                fadeString = string.format(AC_SCP49.getLang("equipped_cure"), selectedCure.name or "Error")
            end
        end

        xSpace = pW * 0.05
    end

end

function PANEL:ShowCloseButton()
    local pW, pH = self:GetWide(), self:GetTall()
    self.closeButton = vgui.Create("DButton", self)
    self.closeButton:SetSize(pW * 0.1,  pH * 0.1)
    self.closeButton:SetPos(pW * 0.89 + 5, 0 + pH * 0.01)
    self.closeButton:SetText("")
    self.closeButton.DoClick = function()
        self:Remove()
    end
    
    self.closeButton.Paint = function(s, w, h)
        surface.SetDrawColor(closeColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Close", "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:OnSizeChanged()
    //self:ShowCloseButton()
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(self.backgroundColor)
    surface.DrawRect(0, 0, w, h)
    draw.SimpleText(self.Title, "AC_SCP049.FontScale12", 0 + 5, 0 + 15, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    if self.drawOutline then
        surface.SetDrawColor(self.outlineColor)
        surface.DrawOutlinedRect(0, 0, w, h, 4)
    end
    if table.IsEmpty(self.cures) then
        draw.SimpleText(AC_SCP49.getLang("no_cures"), "AC_SCP049.FontScale12", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    if CurTime() < fadeEnd then
        draw.SimpleText(fadeString, "AC_SCP049.Font", w * 0.5, h * 0.2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

vgui.Register("scp_049_cureBag", PANEL, "scp_049_panel")
local background = Color(48, 48, 48)
local outline = Color(33, 33, 33)
local closeColor = Color(255, 0, 0)


local PANEL = {}


function PANEL:Init()
    self.Title = ""
    self.backgroundColor = self.backgroundColor or background
    self.drawOutline = self.drawOutline or true
    self.outlineColor = self.outlineColor or outline
    self:MakePopup()
end

function PANEL:ShowCloseButton()
    local pW, pH = self:GetWide(), self:GetTall()
    self.closeButton = vgui.Create("DButton", self)
    self.closeButton:SetSize(pW * 0.1,  pH * 0.05)
    self.closeButton:SetPos(pW * 0.89, 0 + pH * 0.005)
    self.closeButton:SetText("")
    self.closeButton.DoClick = function()
        self:Hide()
    end
    
    self.closeButton.Paint = function(s, w, h)
        surface.SetDrawColor(closeColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Close", "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetTitle(text)
    self.Title = text
end

function PANEL:SetBackgroundColor(color)
    if !IsColor(color) then  print(color) error(self:GetName() .. " attempted to set invalid background color") self:Remove() end
    self.backgroundColor = color
end



function PANEL:SetOutlineColor(color)
    if !IsColor(color) then  print(color) error(self:GetName() .. " attempted to set invalid outline color") self:Remove() end
    self.outlineColor = color
end

function PANEL:DrawOutline(bool)
    if !isbool(bool) then error(self:GetName() .. " was not passed a bool!") self:Remove() end
    self.drawOutline = bool
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(self.backgroundColor)
    surface.DrawRect(0, 0, w, h)
    draw.SimpleText(self.Title, "AC_SCP049.FontScale12", 0 + 5, 0 + 15, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    if !self.drawOutline then return end
    surface.SetDrawColor(self.outlineColor)
    surface.DrawOutlinedRect(0, 0, w, h, 4)
    
end


vgui.Register("scp_049_panel", PANEL, "Panel")
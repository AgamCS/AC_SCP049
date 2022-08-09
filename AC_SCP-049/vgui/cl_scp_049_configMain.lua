

local PANEL = {}
local background = Color(48, 48, 48)
local sPanelBackground = Color(0, 0, 0, 200)
local hoverColor = Color(100, 100, 200)

function PANEL:Init()

    local scrw, scrh = ScrW(), ScrH()
    self:SetSize(scrw * 0.8, scrh * 0.7)
    self:Center()
    self:SwitchScene("scp_049_configHome", AC_SCP49.getLang("frame_title"))
    self:ShowCloseButton(true)
    self:MakePopup(true)
end

function PANEL:OnScreenSizeChanged()
    self:InvalidateLayout()
end

function PANEL:OnSizeChanged()
    self:InvalidateLayout()
end

function PANEL:SwitchScene(newScene, newTitle)
    if IsValid(self.panel) then
        self.panel:Remove()
    end 
    self.panel = vgui.Create(newScene, self)
    self.panel:Dock(FILL)
    self.panel:CreateSettings(self:GetWide(), self:GetTall())
    self:SetTitle(newTitle)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(background)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("scp_049_configMain", PANEL, "DFrame")


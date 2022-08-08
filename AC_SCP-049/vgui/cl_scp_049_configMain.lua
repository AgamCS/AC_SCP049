

local PANEL = {}
local background = Color(48, 48, 48)
local sPanelBackground = Color(0, 0, 0, 200)
local hoverColor = Color(100, 100, 200)

local settings = {
    [1] = {
        name = AC_SCP49.getLang("scp_settings_name"),
        desc = AC_SCP49.getLang("scp_settings_desc"),
        newScene = "scp_049_configSCP",
    },

    [2] = {
        name = AC_SCP49.getLang("general_settings_name"),
        desc = AC_SCP49.getLang("general_settings_desc"),
        newScene = "scp_049_configGeneral",
    }
}


function PANEL:Init()

    local scrw, scrh = ScrW(), ScrH()

    self.panel = vgui.Create("DPanel", self)
    self.panel:Dock(FILL)
    self.panel.Paint = function(s, w, h)
    end

    self:SetSize(scrw * 0.8, scrh * 0.7)
    self:Center()
    self:SetTitle(AC_SCP49.getLang("frame_title"))
    self:ShowCloseButton(true)
    self:MakePopup(true)
    self:CreateSettings(scrw * 0.8, scrh * 0.7)
end

function PANEL:CreateSettings(pWidth, pHeight)
    for k, v in ipairs(settings) do
        local sPanel = vgui.Create("DPanel", self.panel)
        sPanel:Dock(TOP)
        sPanel:SetSize(pWidth * 0.9, pHeight * 0.2)
        sPanel:DockMargin(pWidth * 0.01, pHeight * 0.01, pWidth * 0.01, pHeight * 0.01)
        sPanel.Paint = function(s, w, h)
            surface.SetDrawColor(sPanelBackground)
            surface.DrawRect(0, 0, w, h)
        end

        local sButton = vgui.Create("DButton", sPanel)
        sButton:SetSize(pWidth * 0.3, pHeight * 0.1)
        sButton:SetPos(pWidth * 0.01, ((pHeight * 0.2) * 0.5) - ((pHeight * 0.1) * 0.5))
        sButton:SetText("")
        sButton.Paint = function(s, w, h)
            draw.RoundedBox(4, 0, 0, w, h, background)
            if !s:IsHovered() then
                draw.SimpleText(v.name, "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(v.name, "AC_SCP049.Font", w * 0.5, h * 0.5, hoverColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        sButton.DoClick = function()
            self.panel:Remove()
            self.panel = vgui.Create(v.newScene, self)
            self.panel:Dock(FILL)
            self.panel:CreateSettings(self:GetWide(), self:GetTall())
            self:SetTitle(v.name)
            self.panel.Paint = function(s, w, h)
            end
        end

        local sText = vgui.Create("DLabel", sPanel)
        sText:SetSize(pWidth * 0.3, pHeight * 0.1)
        sText:SetText(v.desc)
        sText:SetFont("AC_SCP049.Font")
        local tW, tH = sText:GetTextSize()
        sText:SetPos((pWidth * 0.6), ((pHeight * 0.2) * 0.5) - ((pHeight * 0.1) * 0.5))
        

    end
end


function PANEL:OnScreenSizeChanged()
    self:InvalidateLayout()
end

function PANEL:OnSizeChanged()
    self:InvalidateLayout()
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(background)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("scp_049_configMain", PANEL, "DFrame")


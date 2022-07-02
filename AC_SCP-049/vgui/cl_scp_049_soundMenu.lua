local PANEL = {}
local grip = Color(91, 91, 91)
local sbar = Color(50, 50, 50)
local btn = Color(35, 35, 35)

local soundBtn = Color(45, 45, 45)
local outline = Color(33, 33, 33)

local hoverColor = Color(100, 100, 200)

function PANEL:createSounds()
    local scrw, scrh = ScrW(), ScrH()
    self.soundScroll = vgui.Create("DScrollPanel", self)
    self.soundScroll:StretchToParent(0, scrh * 0.04, 0, scrh * 0.04)
    self.soundScroll:DockPadding(scrw * 0.01, scrh * 0.2, scrw * 0.01, scrh * 0.2)
    local bar = self.soundScroll:GetVBar()
    self.soundScroll.Paint = function(s, w, h)
    end

    bar.Paint = function(s, w, h)
        surface.SetDrawColor(sbar)
        surface.DrawRect(0, 0, w, h)
    end

    bar.btnUp.Paint = function(s, w, h)
        surface.SetDrawColor(btn)
        surface.DrawRect(0, 0, w, h)
    end

    bar.btnDown.Paint = function(s, w, h)
        surface.SetDrawColor(btn)
        surface.DrawRect(0, 0, w, h)
    end

    bar.btnGrip.Paint = function(s, w,  h)
        surface.SetDrawColor(grip)
        surface.DrawRect(0, 0, w, h)
    end

    local w, h = self.soundScroll:GetWide(), self.soundScroll:GetTall()
    for k, v in ipairs(AC_SCP49.config.soundMenu) do
        local btn = vgui.Create("DButton", self.soundScroll)
        btn:SetSize(w * 0.1, h * 0.1)
        btn:Dock(TOP)
        btn:SetText("")
        btn:DockMargin(w * 0.1, h * 0.01 , w * 0.1, h * 0.01)

        btn.DoClick = function()
            net.Start("ac_scp049.playSound")
                net.WriteUInt(k, 5)
            net.SendToServer()
        end

        btn.Paint = function(s, w, h)
            surface.SetDrawColor(soundBtn)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(outline)
            surface.DrawOutlinedRect(0, 0, w, h, 4)
            if btn:IsHovered() then
                draw.SimpleText(v.text, "AC_SCP049.Font", w * 0.5, h * 0.5, hoverColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                return
            end
            draw.SimpleText(v.text, "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end



vgui.Register("scp_049_soundList", PANEL, "scp_049_panel")
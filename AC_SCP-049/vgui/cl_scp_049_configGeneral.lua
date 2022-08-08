local PANEL = {}
local background = Color(48, 48, 48)
local sPanelBackground = Color(0, 0, 0, 200)
local hoverColor = Color(100, 100, 200)

local settings = {
    [1] = {
        name = AC_SCP49.getLang("general_menuCommands_name"),
        desc = AC_SCP49.getLang("general_menuCommands_desc"),
        default = AC_SCP49.config["adminMenuCommands"],
        type = "string",
        entry = NULL,
        key = "adminMenuCommands",
    },

    [2] = {
        name = AC_SCP49.getLang("general_adminRanks_name"),
        desc = AC_SCP49.getLang("general_adminRanks_desc"),
        default = AC_SCP49.config["adminRanks"],
        type = "string",
        entry = NULL,
        key = "adminRanks",
    },
    
}

local function applyChanges()
    
    local changes = {}
    local changeFound = false
    for k, v in ipairs(settings) do
        local newValue
        
        // First check for changes
        local strings = string.Explode(" ", v.entry:GetText())
        local newStrings = {}
        for _, path in pairs(strings) do
            newStrings[path] = true
            changes[v.key] = newStrings
            newValue = newStrings
        end
        if newValue == v.default then continue end
        
        changes[v.key] = newValue
        changeFound = true
    end
    if !changeFound then return end
    changes = util.TableToJSON(changes)
    changes = util.Compress(changes)

    net.Start("ac_scp049.verifyConfigChanges")
        net.WriteUInt(#changes, 8)
        net.WriteData(changes, #changes)
    net.SendToServer()
end


function PANEL:Init()
    self.scroller = vgui.Create("DScrollPanel", self)
    self.scroller:Dock(FILL)
end

function PANEL:CreateSettings(pWidth, pHeight)
    for k, v in ipairs(settings) do
        local sPanel = vgui.Create("DPanel")
        self.scroller:AddItem(sPanel)
        sPanel:Dock(TOP)
        sPanel:SetSize(pWidth * 0.9, pHeight * 0.25)
        sPanel:DockMargin(pWidth * 0.05, pHeight * 0.01, pWidth * 0.05, pHeight * 0.01)
        sPanel.Paint = function(s, w, h)
            surface.SetDrawColor(sPanelBackground)
            surface.DrawRect(0, 0, w, h)
        end

        local sName = vgui.Create("DLabel", sPanel)
        sName:SetSize(pWidth * 0.5, pHeight * 0.1)
        sName:SetText(v.name)
        sName:SetFont("AC_SCP049.Font")
        sName:SetPos((pWidth * 0.01), ((pHeight * 0.25) * 0.5) - ((pHeight * 0.1) * 0.5))

        local sDesc = vgui.Create("DLabel", sPanel)
        sDesc:SetSize(pWidth * 0.5, pHeight * 0.1)
        sDesc:SetText(v.desc)
        sDesc:SetFont("AC_SCP049.FontSmall")
        sDesc:SetPos((pWidth * 0.01), ((pHeight * 0.25) * 0.5) - ((pHeight * 0.1) * 0.5) + pHeight * 0.05)

        if v.type == "string" then
            local tEntry = vgui.Create("DTextEntry", sPanel)
            tEntry:SetSize(pWidth * 0.5, pHeight * 0.05)
            tEntry:SetPos((pWidth * 0.2), ((pHeight * 0.25) * 0.5) - ((pHeight * 0.05) * 0.5))
            local str
            if istable(v.default) then
                str = ""
                for key, value in pairs(v.default) do
                    str = str .. key .. " "
                end
            end
            tEntry:SetValue(str or v.default)
            v.entry = tEntry
        elseif v.type == "int" then
            local tEntry = vgui.Create("DTextEntry", sPanel)
            tEntry:SetSize(pWidth * 0.5, pHeight * 0.05)
            tEntry:SetPos((pWidth * 0.2), ((pHeight * 0.25) * 0.5) - ((pHeight * 0.05) * 0.5))
            tEntry:SetNumeric(true)
            tEntry:SetValue(v.default)
            v.entry = tEntry
        elseif v.type == "color" then
            local colorPicker = vgui.Create("DColorMixer", sPanel)
            colorPicker:SetSize(pWidth * 0.5, pHeight * 0.2)
            colorPicker:SetPos((pWidth * 0.2), ((pHeight * 0.25) * 0.5) - ((pHeight * 0.2) * 0.5))
            colorPicker:SetColor(v.default)
            v.entry = colorPicker
        end

    end

    local applyButton = vgui.Create("DButton", self)
    applyButton:SetSize(pWidth * 0.1, pHeight * 0.05)
    //applyButton:SetPos(pWidth * 0.8, pHeight * 0.9)
    applyButton:DockMargin(pWidth * 0.8, pHeight * 0.01, pWidth * 0.06, pHeight * 0.01)
    applyButton:Dock(BOTTOM)
    applyButton:SetText("")
    applyButton.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, sPanelBackground)
        local applyText = AC_SCP49.getLang("settings_apply")
        if !s:IsHovered() then
            draw.SimpleText(applyText, "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(applyText, "AC_SCP049.Font", w * 0.5, h * 0.5, hoverColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    applyButton.DoClick = function(s)
        applyChanges()
    end

end

function PANEL:OnScreenSizeChanged()
    self:InvalidateLayout()
end

function PANEL:OnSizeChanged()
    self:InvalidateLayout()
end

vgui.Register("scp_049_configGeneral", PANEL, "DPanel")

concommand.Add("test_adminSCP", function()
    if IsValid(AC_SCP49.adminSCPTestPanel) then
        AC_SCP49.adminSCPTestPanel:Remove()
        return
    end
    AC_SCP49.adminSCPTestPanel = vgui.Create("scp_049_configSCP")
end)

hook.Add("AC_SCP049.ClientConfigUpdated", "AC_SCP049.updateSCPSettings", function()
    for k, v in pairs(settings) do
        v.default = AC_SCP49.config[v.key]
    end
end)
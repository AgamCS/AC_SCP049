local PANEL = {}
local background = Color(48, 48, 48)
local sPanelBackground = Color(0, 0, 0, 200)
local hoverColor = Color(100, 100, 200)

local settings = {
    [1] = {
        name = AC_SCP49.getLang("scp_immuneModels_name"),
        desc = AC_SCP49.getLang("scp_immuneModels_desc"),
        default = AC_SCP49.config["immuneModels"],
        type = "string",
        entry = NULL,
        key = "immuneModels",
    },

    [2] = {
        name = AC_SCP49.getLang("scp_mixTime_name"),
        desc = AC_SCP49.getLang("scp_mixTime_desc"),
        default = AC_SCP49.config["mixTime"],
        type = "int",
        entry = NULL,
        key = "mixTime",
    },
    
    [3] = {
        name = AC_SCP49.getLang("scp_soundLevel_name"),
        desc = AC_SCP49.getLang("scp_soundLevel_desc"),
        default = AC_SCP49.config["soundLevel"],
        type = "int",
        entry = NULL,
        key = "soundLevel",
    },

    [4] = {
        name = AC_SCP49.getLang("scp_scp049Job_name"),
        desc = AC_SCP49.getLang("scp_scp049Job_desc"),
        default = AC_SCP49.config["scp049Job"],
        type = "string",
        entry = NULL,
        key = "scp049Job",
    },

    [5] = {
        name = AC_SCP49.getLang("scp_cureLimit_name"),
        desc = AC_SCP49.getLang("scp_cureLimit_desc"),
        default = AC_SCP49.config["cureLimit"],
        type = "int",
        entry = NULL,
        key = "cureLimit",
    },

    [6] = {
        name = AC_SCP49.getLang("scp_zombieModel_name"),
        desc = AC_SCP49.getLang("scp_zombieModel_desc"),
        default = AC_SCP49.config["zombieModel"],
        type = "string",
        entry = NULL,
        key = "zombieModel",
    },

    [7] = {
        name = AC_SCP49.getLang("scp_zombieOutlineColor_name"),
        desc = AC_SCP49.getLang("scp_zombieOutlineColor_desc"),
        default = AC_SCP49.config["zombieOutlineColor"],
        type = "color",
        entry = NULL,
        key = "zombieOutlineColor",
    },

    [8] = {
        name = AC_SCP49.getLang("scp_doorAutoClose_name"),
        desc = AC_SCP49.getLang("scp_doorAutoClose_desc"),
        default = AC_SCP49.config["autoCloseTime"],
        type = "int",
        entry = NULL,
        key = "autoCloseTime",
    },

}

local function applyChanges()
    
    local changes = {}
    local changeFound = false
    for k, v in ipairs(settings) do
        local newValue
        
        // First check for changes
        if v.key == "immuneModels" then
            // the value of ["immuneModels"] is a table, so we need to treat is different from a string, integer, or Color structure
            local modelNames = string.Explode(" ", v.entry:GetText())
            local newImmunes = {}
            for _, path in pairs(modelNames) do
                newImmunes[path] = true
                changes[v.key] = newImmunes
                newValue = newImmunes
            end
        elseif v.type == "string" or v.type == "int" then
            newValue = v.entry:GetInt() or v.entry:GetText()
        elseif v.type == "color" then
            newValue = v.entry:GetColor()
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

    local backButton = vgui.Create("DButton", self)
    backButton:SetSize(pWidth * 0.1, pHeight * 0.05)
    backButton:DockMargin(pWidth * 0.8, pHeight * 0.01, pWidth * 0.06, pHeight * 0.01)
    backButton:Dock(BOTTOM)
    backButton:SetText("")
    backButton.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, sPanelBackground)
        local backText = AC_SCP49.getLang("settings_back")
        if !s:IsHovered() then
            draw.SimpleText(backText, "AC_SCP049.Font", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(backText, "AC_SCP049.Font", w * 0.5, h * 0.5, hoverColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    backButton.DoClick = function(s)
        local parent = self:GetParent()
        parent:SwitchScene("scp_049_configHome", AC_SCP49.getLang("frame_title"))
    end

end

function PANEL:OnSizeChanged()
    self:InvalidateLayout()
end

function PANEL:Paint()

end

vgui.Register("scp_049_configSCP", PANEL, "DPanel")

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

// Used for both ingredients and cures

local PANEL = {}
PANEL.__model = ""
PANEL.__modelEnt = "models/hunter/blocks/cube025x025x025.mdl"
PANEL.__ingredient = nil
PANEL.__cure = nil
PANEL.__ingredientPanels = {} // Used if the panel is a cure
PANEL.__curePanel = nil // Used is panel is an ingredient

PANEL.__isCure = false 
PANEL.__isIngredient = false

local nilColor = Color(33, 33, 33)
local outline = Color(10, 10, 10)

function PANEL:Init()
    self:SetText("")
    self:createModelPanel()
end

function PANEL:SetPanelAsCure(panel1, panel2)
    self.__ingredientPanels[1] = panel1
    self.__ingredientPanels[2] = panel2
    self.__isCure = true 
    self.__isIngredient = false
end

function PANEL:SetPanelAsIngredient(curePanel)
    self.__curePanel = curePanel
    self.__isCure = false  
    self.__isIngredient = true
end

function PANEL:SetIngredient(name)
    if !AC_SCP49.config.ingredients[name] then error("Could not find ingredient in list") end
    self.__ingredient = name
    self.modelPanel:SetColor(AC_SCP49.config.ingredients[name].color)
end

function PANEL:RemoveIngredient()
    self.__ingredient = nil
    self.modelPanel:SetColor(nilColor) 

end

function PANEL:GetIngredient()
    if self.__ingredient == "" then
        return false
    else
        return self.__ingredient
    end
end

function PANEL:SetCure(ing1, ing2)
    local cureTable
    if !ing2 then
        cureTable = AC_SCP49.getCure(ing1)
    else
       cureTable = AC_SCP49.getCure(ing1 .. ing2) || AC_SCP49.getCure(ing2 .. ing1)
    end

    if !cureTable then return end
    self.__cure = cureTable.class
    self.modelPanel:SetColor(cureTable.color)
end

function PANEL:RemoveCure()
    self.__cure = nil
    self.modelPanel:SetColor(nilColor) 

end

function PANEL:GetCure()
    if self.__cure == "" then
        return false
    else
        return self.__cure
    end
end

function PANEL:createModelPanel()
    self.modelPanel = vgui.Create("DModelPanel", self)
    self.modelPanel:Dock(FILL)
    self.modelPanel:SetModel(self.__model)
    self.modelPanel:SetColor(nilColor)
    self.modelPanel.LayoutEntity = function()

    end

    self.modelPanel.DoClick = function()
        if self:GetIngredient() then
            self:RemoveIngredient()
        end
        if self.__isIngredient && self.__curePanel then
            self.__curePanel:RemoveCure()
        end
    end

end

function PANEL:SetModel(model)
    self.__model = model
    self.modelPanel:SetModel(model)
    local ent = self.modelPanel:GetEntity()
    ent:SetModelScale(4.5)
    ent:SetPos(ent:GetPos() + Vector(0, 0, 25))
end

function PANEL:OnSizeChanged()
    self:createModelPanel()
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(nilColor)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(outline)
    surface.DrawOutlinedRect(0, 0, w, h, 4)
end

vgui.Register("scp_049_ingredientPanel", PANEL, "DButton")
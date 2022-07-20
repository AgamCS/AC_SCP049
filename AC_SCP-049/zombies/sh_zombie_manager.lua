AC_SCP49.zombie = AC_SCP49.zombie or {}
AC_SCP49.zombie.list = AC_SCP49.zombie.list or {}

function AC_SCP49.zombie.Add(entity)
    if !SERVER then return end
    table.insert(self.list, entity)
    net.Start("ac_scp049.sendZombieAdd")
        net.WriteEntity(entity)
    net.Broadcast()
end

function AC_SCP49.zombie.Remove(entity)
    table.RemoveByValue(self.list, entity)
end

if CLIENT then
    local zombieOutline = AC_SCP49.config.zombieOutlineColor

    hook.Add("PreDrawHalos", "AC_SCP049.drawZombieOutlines", function()
        if table.IsEmpty(AC_SCP49.zombie.list) then return end
        local ply = LocalPlayer()
        if !ply.is0492() || !ply.isSCP049() then return end
        outline.Add(AC_SCP49.zombie.list, zombieOutline, OUTLINE_MODE_BOTH)
    end)
end


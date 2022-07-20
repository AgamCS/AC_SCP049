AC_SCP49.zombie = AC_SCP49.zombie or {}
AC_SCP49.zombie.list = AC_SCP49.zombie.list or {}

function AC_SCP49.zombie.Add(entity)
    if !SERVER then return end
    table.insert(self.list, entity)
end

if CLIENT then
    local zombieOutline = AC_SCP49.config.zombieOutlineColor
    hook.Add("PreDrawHalos", "AC_SCP049.drawZombieOutlines", function()

    end)
end


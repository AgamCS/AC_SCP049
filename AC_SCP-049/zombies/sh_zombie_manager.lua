AC_SCP49.zombie = AC_SCP49.zombie or {}
AC_SCP49.zombie.list = AC_SCP49.zombie.list or {} // 049 is also in this list, not just zombies

function AC_SCP49.zombie.Add(entity)
    if !SERVER then return end
    table.insert(AC_SCP49.zombie.list, entity)
    net.Start("ac_scp049.sendZombieAdd")
        net.WriteEntity(entity)
    net.Broadcast()
end

function AC_SCP49.zombie.Remove(entity)
    table.RemoveByValue(AC_SCP49.zombie.list, entity)
    net.Start("ac_scp049.sendZombieRemove")
        net.WriteEntity(entity)
    net.Broadcast()
end

if CLIENT then
    hook.Add("PreDrawHalos", "AC_SCP049.drawZombieOutlines", function()
        local ply = LocalPlayer()
        
        if (ply:isSCP049() || ply:is0492()) then 
            if table.IsEmpty(AC_SCP49.zombie.list) then return end
            outline.Add(AC_SCP49.zombie.list, AC_SCP49.config.zombieOutlineColor, OUTLINE_MODE_BOTH)
            //outline.SetRenderType(OUTLINE_RENDERTYPE_BEFORE_VM)
        end
    end)

    net.Receive("ac_scp049.sendZombieAdd", function()
        local ent = net.ReadEntity()
        table.insert(AC_SCP49.zombie.list, ent)
    end)

    net.Receive("ac_scp049.sendZombieRemove", function()
        local ent = net.ReadEntity()
        table.RemoveByValue(AC_SCP49.zombie.list, ent)
    end)

end


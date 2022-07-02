ENT.Base = "base_brush"
ENT.Type = "brush"

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetSolid(SOLID_BBOX)
        self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        //print("Entity spawned")
    end
end


if !SERVER then return end
function ENT:SetBounds(min, max)
    self:SetCollisionBounds(min, max)
    self:SetTrigger(true)
end

function ENT:Touch(ent)
    print(ent)
    if IsValid(ent) && ent != self.Owner then
        ent:TakeDamage(ent:Health())
    end
end

/*function ENT:PhysicsCollide(data, phys)
    print("collide")
    if IsValid(data.Entity) && data.Entity != self.Owner then
        data.Entity:TakeDamage(data.Entity:Health())
    end
end*/


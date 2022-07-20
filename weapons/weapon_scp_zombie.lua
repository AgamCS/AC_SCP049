SWEP.PrintName = "SCP-049-2"
SWEP.Base = "weapon_fists"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Weight = 5
SWEP.SlotPos = 2
SWEP.Slot = 4
SWEP.DrawAmmo = false

SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = ""
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.AutoSwtichTo = true

SWEP.Primary.AttackDelay = 0.15
SWEP.Primary.AttackRange = 65

// The minimum amount of hits needed to break down a door
SWEP.Primary.minHits = 3

// The max amount of hits needed to break down a door
SWEP.Primary.maxHits = 5

// Minimum damage the zombie can deal to a player
SWEP.Primary.minDamage = 15
// Max damage the zombie can deal to a player
SWEP.Primary.maxDamge = 28

local phys_pushscale = GetConVar( "phys_pushscale" )
local SwingSound = Sound( "WeaponFrag.Throw" )
local HitSound = Sound( "Flesh.ImpactHard" )
local doorDestroySound = Sound("physics/metal/metal_barrel_impact_hard5.wav")

local doorClass = {
	["func_door_rotating"] = true,
	["prop_door_rotating"] = true,
	["func_door"] = true,
}

//print(doorDestroySound)

function SWEP:Initalize()
    self:SetHoldType("fist")
end

/*function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    local tr = util.TraceLine( {
        start = owner:EyePos(),
        endpos = owner:EyePos() + owner:EyeAngles():Forward() * self.Primary.AttackRange,
        filter = owner,
        ignoreworld = true,
    })
    self:SetNextPrimaryFire( CurTime() + self.Primary.AttackDelay )
    if tr.Entity == NULL || !tr.Entity then return end
    if tr.Entity:GetClass() == "func_door" then
        if tr.Entity.doorHits && tr.Entity.doorHits > 0 then
            tr.Entity.doorHits = tr.Entity.doorHits - 1
        else
            tr.Entity.doorHits = math.random(self.Primary.minHits, self.Primary.maxHits)
            tr.Entity.doorHits = tr.Entity.doorHits - 1
        end 
        print(tr.Entity.doorHits)
        if tr.Entity.doorHits < 1 then
            tr.Entity.doorHits = nil
            tr.Entity.doorHits:Fire("Open")
        end
    end
end*/


function SWEP:DealDamage()

	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())

	self.Owner:LagCompensation( true )

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( !IsValid( tr.Entity ) ) then
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	-- We need the second part for single player because SWEP:Think is ran shared in SP
	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	local hit = false
	local scale = phys_pushscale:GetFloat()
	if (SERVER && IsValid(tr.Entity)) && (doorClass[tr.Entity:GetClass()]) then
		if !tr.Entity.doorHits then
			tr.Entity.doorHits = math.random(self.Primary.minHits, self.Primary.maxHits)  
		end
		tr.Entity.doorHits = tr.Entity.doorHits - 1
		if tr.Entity.doorHits < 1 then
			tr.Entity.doorHits = nil 
			tr.Entity:Fire("Open")
			tr.Entity:EmitSound(doorDestroySound, 100, 100, 1, CHAN_AUTO)
		end
		hit = true

	elseif ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()

		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( 8, 12 ) )

		if ( anim == "fists_left" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 * scale + self.Owner:GetForward() * 9998 * scale ) -- Yes we need those specific numbers
		elseif ( anim == "fists_right" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 * scale + self.Owner:GetForward() * 9989 * scale )
		elseif ( anim == "fists_uppercut" ) then
			dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 * scale + self.Owner:GetForward() * 10012 * scale )
			dmginfo:SetDamage( math.random( SWEP.Primary.minDamage , SWEP.Primary.maxDamage  ) )
		end

		SuppressHostEvents( NULL ) -- Let the breakable gibs spawn in multiplayer on client
		tr.Entity:TakeDamageInfo( dmginfo )
		SuppressHostEvents( self.Owner )

		hit = true

	
    end

	if ( IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos )
		end
	end


	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	self.Owner:LagCompensation( false )

end
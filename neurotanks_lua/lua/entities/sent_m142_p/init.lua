AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( class )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

	return ent
	
end


function ENT:Initialize()
	
	self.AmmoTypes = 
	{
		{
			PrintName = "140mm MLRS System",
			Type = "sent_tank_missile",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = self.MinDamage,
			MaxDmg = self.MaxDamage,
			Radius = self.BlastRadius,
			
			-- ATACMS stuff
			ImpactDiveDistance = 3000,
			TargetHeight = 10000, 
			IsHoming = true, -- enable heat seeker
			UseTargetVector = true,
			ExhaustPosDistance = 150, -- distance for fire trail 
			CustomParticleEffect = "v1_impact"
		};
		{
			PrintName = "140mm ATACMS System",
			Type = "sent_tank_missile",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = 3000,
			MaxDmg = 4000,
			Radius = 256,
			
			ImpactDiveDistance = 1500,
			TargetHeight = 12000, 
			IsHoming = true, -- enable heat seeker
			UseTargetVector = true,
			ExhaustPosDistance = 150, -- distance for fire trail 
			CustomParticleEffect = "fireboom_explosion_midair",
			NumCluster = 15,
			ClusterType = "sent_tank_armorpiercing",
			ShouldCluster = true
		};
	}
	
	self:TanksDefaultInit()

	self:StartMotionController()
	
						
						
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	self:TankDefaultCollision( data, physobj )
	
end

function ENT:OnTakeDamage(dmginfo)
	
	self:TankDefaultTakeDamage( dmginfo )
	
end

function ENT:OnRemove()
	
	self:TankDefaultRemove()
	
end

function ENT:Use(ply,caller)

	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()
	-- Make sure you get the right ammo post-barrelchange
	self:NextThink( CurTime() )
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	if( self.HasTower ) then
	
		self:TankTowerRotation()
	
	else
		
		self:TankNoTowerRotation()
	
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end


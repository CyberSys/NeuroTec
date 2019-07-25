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
			PrintName = ".50cal Auto",
			Type = "sent_tank_mgbullet",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = self.MinDamage,
			MaxDmg = self.MaxDamage,
			Radius = self.BlastRadius,
			BulletCount = 1,
			TraceRounds = 1,
			Tracer = "tracer",
			Muzzle = "mg_muzzleflash",
			BulletHose = true,
		};
	}
	
	
	self:TanksDefaultInit()

	self:StartMotionController()
	
				
			
	self.InteriorCrocodile = ents.Create("prop_physics")
	self.InteriorCrocodile:SetPos( self:LocalToWorld( Vector( 10, 0, 20  ) ) )
	self.InteriorCrocodile:SetModel( "models/aftokinito/neurotanks/russian/bmp-3_interior_body.mdl" )
	self.InteriorCrocodile:SetAngles( self:GetAngles() )
	self.InteriorCrocodile:SetSolid( SOLID_NONE )
	self.InteriorCrocodile:SetParent( self )
	self.InteriorCrocodile:Spawn()
	

	
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
	if( IsValid( self.MicroTurrets[1] ) ) then
		
		-- self.MicroTurrets[1].InitialHealth = self.InitialHealth
		self.MicroTurrets[1].HealthVal = self.HealthVal
		
	end
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	-- if( self.HasTower ) then
	
		-- self:TankTowerRotation()
	
	-- else
		
		self:TankNoTowerRotation()
	
	-- end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end


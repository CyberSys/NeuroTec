AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( self.FolderName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

    
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end

	return ent
	
end


function ENT:Initialize()
    		self.AmmoTypes = 
	{
		{
			PrintName = "105mm M68E2 HE",
			Type = "sent_tank_shell",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
		};
		{
			PrintName = "105mm M68E2 SABOT",
			Type = "sent_tank_apshell",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
		};
		{
			PrintName = "105mm M68E2 APCR",
			Type = "sent_tank_armorpiercing",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
		};
	}

	self:TanksDefaultInit()
	self:StartMotionController()
	
	self.Alligator = ents.Create("prop_physics")
	self.Alligator:SetPos( self.Tower:LocalToWorld( Vector( -5,0,-50 ) ) )
	self.Alligator:SetAngles( self.Tower:GetAngles() )
	self.Alligator:SetModel( "models/aftokinito/neurotanks/russian/bmp-3_interior_turret.mdl" )
	self.Alligator:SetSolid( SOLID_NONE )
	self.Alligator:SetParent( self.Tower )	
	self.Alligator:Spawn()
	
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

	self:NextThink( CurTime() )
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	self:GetPhysicsObject():Wake()
	
	if( self.HasTower ) then
	
		self:TankTowerRotation()
	
	else
		
		self:TankNoTowerRotation()
	
	end
	
end

-- function ENT:PhysicsSimulate( phys, deltatime )
	
	-- self:TankHeavyPhysics( phys, deltatime )
	
-- end


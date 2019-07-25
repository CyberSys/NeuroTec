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
			PrintName = "20mm GSh-301",
			Type = "sent_tank_mgbullet",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = self.MinDamage,
			MaxDmg = self.MaxDamage,
			Radius = self.BlastRadius,
			BulletCount = 1,
			TraceRounds = 0,
			Tracer = "tracer",
			Muzzle = "mg_muzzleflash",
			BulletHose = true,
		};
	}
	
	self:TanksDefaultInit()

	self:StartMotionController()
	
			
	self.Trailer = ents.Create("ai_pac3")
	self.Trailer:SetPos( self:LocalToWorld(  Vector( -260, 0, 33 ) ) )
	self.Trailer:SetAngles( self:GetAngles() )
	self.Trailer:Spawn()

	-- constraint.Axself.Trailer.TowProp
	-- 
	timer.Simple( 0, function()
		
		if( !IsValid( self ) ) then return end
		
		local weld = constraint.Ballsocket( self, self.Trailer.TowProp, 0, 0, Vector( -0,0,0 ), 0, 0, 1 )
		self:DeleteOnRemove( self.Trailer )
		constraint.NoCollide( self, self.Trailer, 0, 0 )
		constraint.NoCollide( self, self.Trailer.TowProp, 0, 0 )
	
		end )
		
	-- print( weld )				
						
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


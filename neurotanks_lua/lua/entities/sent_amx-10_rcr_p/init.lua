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
			PrintName = "105mm L/48 MECA EO",
			Type = "sent_tank_shell",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = 1500,
			MaxDmg = 2000,
			Radius = self.BlastRadius
		};
		{
			PrintName = "105mm L/48 MECA OOC",
			Type = "sent_tank_armorpiercing",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = 1200,
			MaxDmg = 1700,
			Radius = self.BlastRadius
		};
		{
			PrintName = "105mm L/48 MECA AAF",
			Type = "sent_tank_apshell",
			Delay = 7,
			Sound = self.ShootSound,
			MinDmg = 2000,
			MaxDmg = 2500,
			Radius = 32
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


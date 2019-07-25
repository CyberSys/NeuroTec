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
			PrintName = "TOW Rocket",
			Type = "sent_tank_missile",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = 2000,
			MaxDmg = 3000,
			Radius = self.BlastRadius,
			Muzzle = "mg_muzzleflash",
			IsHoming = true, -- enable heat seeker
			Boosted = true -- enable rocket boost.
		};
	}
	
	self:TanksDefaultInit()

	self:StartMotionController()
	
	timer.Simple( 0, function()
		if( IsValid( self ) ) then
			
			constraint.Keepupright( self, Angle( 0,0,0 ), 0, 125.92 )				
			
		end
		
	end )
	
	
	self.Plow = ents.Create("prop_physics")
	self.Plow:SetPos( self:LocalToWorld( Vector( 88, 0, 10 ) ) )
	self.Plow:SetAngles( self:GetAngles() )
	self.Plow:SetModel( "models/works/bulldozer_blade.mdl" )
	self.Plow:Spawn()
	self.Plow:GetPhysicsObject():SetMass( 15990 )
	self.Plow:SetColor( Color( 80, 100, 55, 255 ) )
	constraint.Weld( self, self.Plow, 0, 0 )
	self.Plow:SetOwner( self )
	self:DeleteOnRemove( self.Plow )
	
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


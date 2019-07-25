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

    -- ent.Barrel:SetBodyGroup( 0, math.random( 0,4 ) )
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end

	return ent
	
end


function ENT:Initialize()
   
	self.AmmoStructure = 
	{
		{	
			Tower = 0,
			Barrel = 0,
			Ammo = {
			{
				PrintName = "400mm High Explosive",
				Type = "sent_artillery_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 5100,
				MaxDmg = 10750,
			};
			};
		};

	}	
	
	self.Train = ents.Create("prop_physics")
	self.Train:SetModel( "models/elpaso/locomotive.mdl" )
	self.Train:SetPos( self:GetPos() )
	local a = self:GetAngles()
	a:RotateAroundAxis( self:GetUp(), 180 )
	self.Train:SetSolid( SOLID_NONE )
	self.Train:SetAngles( a )
	self.Train:Spawn()
	
	self.Train:SetParent( self)
	
	self:TanksDefaultInit()
	self:StartMotionController()
	self:DeleteOnRemove( self.Train )
	
	timer.Simple( 0, function()
		
		constraint.Keepupright( self, self:GetAngles(), 0, 500000 )
		-- constraint.Weld( self, train, 0, 0, 0, true, true )
		
	end ) 

	
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

	-- self.AmmoTypes = self.BodygroupAmmo[ self.Barrel:GetBodygroup( 0 ) ]

	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()

	self:NextThink( CurTime() )
	
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



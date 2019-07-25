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
	
	local rand1 = math.random(0,1)
    rand2 = math.random(0,6)
    ent.Tower:SetBodygroup(0,rand1)
    ent.Barrel:SetBodygroup(0,rand2)

	return ent
	
end


function ENT:Initialize()

	self.AmmoIndex = 1
	self:TanksDefaultInit()
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 50000000000 )
	
	self:StartMotionController()
	self.BodygroupAmmo = 
	{
		{ 	-- First Body group loadout
			{
				PrintName = "76 mm KT-28 AP",
				Type = "sent_tank_apshell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1000,
				MaxDmg = 1300,
				Radius = 64
			};
			{
				PrintName = "76 mm KT-28 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1200,
				MaxDmg = 1700,
				Radius = 400
			};
		};
	}
						
		
	self.Shake = ents.Create( "env_shake" )
	self.Shake:SetOwner( self.Owner )
	self.Shake:SetPos( self.Entity:GetPos() )
	self.Shake:SetParent( self )
	self.Shake:SetKeyValue( "amplitude", "10" )	-- Power of the shake
	self.Shake:SetKeyValue( "radius", "512" )	-- Radius of the shake
	self.Shake:SetKeyValue( "duration", "0.1" )	-- Time of shake
	self.Shake:SetKeyValue( "frequency", "255" )	-- How har should the screenshake be
	self.Shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
	self.Shake:Spawn()
	self.Shake:Activate()
	
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

   	self.AmmoTypes = self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1] -- Since Luas first table index is 1 and bodygroups use 0 we add one

	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	if( IsValid( self.Pilot ) && self.IsDriving && !self.Destroyed && self.Fuel > 0 ) then
		local fw = self.Pilot:KeyDown( IN_FORWARD ) 
		local rw = self.Pilot:KeyDown( IN_BACK )
		local l = self.Pilot:KeyDown( IN_MOVELEFT )
		local r = self.Pilot:KeyDown( IN_MOVERIGHT )
		
	
		if( fw || rw || l || r ) then
			
			self.Shake:Fire( "StartShake", "", 0 )
		
		end
		
	end
	
	self:TankDefaultThink()
	-- Make sure you get the right ammo post-barrelchange
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


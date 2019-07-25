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

    rand2 = math.random(0,3)
    ent.Barrel:SetBodygroup(0,rand2)
    
	return ent
	
end


function ENT:Initialize()

	self.AmmoIndex = 1
	self:TanksDefaultInit()
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
	self:StartMotionController()
	self.BodygroupAmmo = 
	{
		{ 	-- First Body group loadout
			{
				PrintName = "120mm L55 MPAT",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = self.MinDamage,
				MaxDmg = self.MaxDamage,
				Radius = self.Blastradius
			};
			{
				PrintName = "120mm L55 APFSDS",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = self.MinDamage,
				MaxDmg = self.MaxDamage,
				Radius = self.Blastradius
			};	
			{
				PrintName = "120mm L55 LAHAT Missile",
				Type = "sent_tank_missile",
				Delay = self.PrimaryDelay,
				Sound = "bf4/rockets/tow_rocket.wav",
				MinDmg = self.MinDamage,
				MaxDmg = self.MaxDamage,
				IsHoming = true,
				Radius = self.Blastradius
			};
		};    
	}
						
						
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


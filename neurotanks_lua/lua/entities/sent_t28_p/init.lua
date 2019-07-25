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
	self.PhysObj:SetMass( 5000000 )
	
	self:StartMotionController()
	self.BodygroupAmmo = 
	{
		{ 	-- First Body group loadout
			{
				PrintName = "76 mm KT-28 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "76 mm KT-28 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Second boydgroup loadout
			{
				PrintName = "57 mm ZiS-8 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "57 mm ZiS-8 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- I think you get it by now.
			{
				PrintName = "76 mm L-10 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "76 mm L-10 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Incase you didnt't: 4th body group loadout
			{
				PrintName = "76 mm F-32 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "76 mm F-32 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Incase you didnt't: 5th body group loadout
			{
				PrintName = "57 mm ZiS-4 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "57 mm ZiS-4 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Incase you didnt't: 6th body group loadout
			{
				PrintName = "85 mm F-30 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "85 mm F-30 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Incase you didnt't: 7th body group loadout
			{
				PrintName = "85 mm F-30 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "85 mm F-30 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
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


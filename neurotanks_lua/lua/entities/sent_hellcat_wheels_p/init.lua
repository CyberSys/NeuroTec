AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( self.FolderName )  
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(0, self.SkinCount ) )
	
	end

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
		{
			{ -- First turret
				PrintName = "76 mm AT Gun M7 L/50 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1100,
				MaxDmg = 1750,
			};
			{
				PrintName = "76 mm AT Gun M7 L/50 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1100,
				MaxDmg = 1750,
			};
		};
		{
			{
				PrintName = "76 mm AT Gun M1A1 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
			{
				PrintName = "76 mm AT Gun M1A1 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
		};
		{
			{
				PrintName = "76 mm AT Gun M1A2 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
			{
				PrintName = "76 mm AT Gun M1A2 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
		};
		{ -- Second turret
			{	
				PrintName = "76 mm AT Gun M7 L/50 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1100,
				MaxDmg = 1750,
			};
			{
				PrintName = "76 mm AT Gun M7 L/50 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1100,
				MaxDmg = 1750,
			};
		};
		{
			{
				PrintName = "76 mm AT Gun M1A1 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
			{
				PrintName = "76 mm AT Gun M1A1 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
		};
		{
			{
				PrintName = "76 mm AT Gun M1A2 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
			{
				PrintName = "76 mm AT Gun M1A2 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1150,
				MaxDmg = 1850,
			};
		};
		{
			{
				PrintName = "90 mm AT Gun M3 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 2450,
				MaxDmg = 3250,
			};
			{
				PrintName = "90 mm AT Gun M3 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 2450,
				MaxDmg = 3250,
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
	
	for i=1,#self.Wheels do
	
		if( IsValid( self.Wheels[i] ) ) then self.Wheels[i]:Remove() end 
		
	end
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


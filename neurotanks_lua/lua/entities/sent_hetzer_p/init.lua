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
			{ -- First gun
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
		};
		{	
			Tower = 0,
			Barrel = 1,
			Ammo = {
			{ -- First gun
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
		};
		{ 
			Tower = 0,
			Barrel = 2,
			Ammo = {
			{ -- Second gun
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
		};
		{
			Tower = 0,
			Barrel = 3,
			Ammo = {
			{ -- Third gun
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
		};
		{	
			Tower = 0,
			Barrel = 4,
			Ammo = {
			{ -- Fourth gun
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
		};
		{
			Tower = 0,
			Barrel = 5,
			Ammo = {
			{ -- Fiveth gun
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


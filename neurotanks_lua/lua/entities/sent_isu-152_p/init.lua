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
				PrintName = "152mm ML-20S AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay, 
				Sound = self.ShootSound,
				MinDmg = 2300,
				MaxDmg = 3000,
			};
			{
				PrintName = "152mm ML-20S APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 2000,
				MaxDmg = 2500,
			};
			};
		};
		{	
			Tower = 0,
			Barrel = 1,
			Ammo = {
			{ -- First gun
				PrintName = "122mm A-19 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1100,
				MaxDmg = 1750,
			};
			{
				PrintName = "122mm A-19 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1000,
				MaxDmg = 1500,
			};
			};
		};
		{ 
			Tower = 0,
			Barrel = 2,
			Ammo = {
			{ -- Second gun
				PrintName = "122mm D-25 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1300,
				MaxDmg = 2000,
			};
			{
				PrintName = "122mm D-25 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1200,
				MaxDmg = 1800,
			};
			};
		};
		{
			Tower = 0,
			Barrel = 3,
			Ammo = {
			{ -- Third gun
				PrintName = "122mm BL-9S AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 1500,
				MaxDmg = 2300,
			};
			{
				PrintName = "122mm BL-9S APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 1300,
				MaxDmg = 2000,
			};
			};
		};
		{	
			Tower = 0,
			Barrel = 4,
			Ammo = {
			{ -- Fourth gun
				PrintName = "152mm BL-10 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
				MinDmg = 2600,
				MaxDmg = 3100,
			};
			{
				PrintName = "152mm BL-10 APHE",
				Type = "sent_tank_armorpiercing",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
				MinDmg = 2100,
				MaxDmg = 2700,
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


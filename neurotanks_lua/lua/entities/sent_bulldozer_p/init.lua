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
	self.AmmoIndex = 1
               
	self:TanksDefaultInit()

	
	self.Scoop = ents.Create("prop_physics")
	self.Scoop:SetModel( "models/works/bulldozer_blade.mdl" )
	self.Scoop:SetPos( self:LocalToWorld( Vector( 62, 0, -24 ) ) )
	self.Scoop:SetAngles( self:GetAngles() )
	self.Scoop:Spawn()
	self.Scoop.VehicleType = VEHICLE_TANK -- trick the collision callback that we're a tank so we can inflict damage on opponents
	
	self.Scoopweld = constraint.Weld( self, self.Scoop, 0, 0, 0, true, false )
	
	for i=1,#self.TrackEntities do
		
		if( IsValid( self.TrackEntities[i] ) ) then
		
			self.TrackEntities[i]:GetPhysicsObject():SetMass( 5000 )
			self.TrackEntities[i].HealthVal = self.InitialHealth * 2
			self.TrackEntities[i].InitialHealth = self.InitialHealth * 2
			self.TrackEntities[i]:SetSolid( SOLID_NONE )
			constraint.NoCollide( self.Scoop, self.TrackEntities[i], 0, 0 )
			
		end
	
	end
			
	
	local part = ents.Create("prop_physics")
	part:SetModel( "models/works/bulldozer_bracket.mdl" )
	part:SetPos( self.Scoop:LocalToWorld( Vector( -30, 0, 12 ) ) )
	part:SetAngles( self:GetAngles() )
	part:SetParent( self.Scoop )
	part:Spawn()
	
    -- self.Tower:SetBodygroup(0,0)
    self.Barrel:SetBodygroup(0,math.random(0,4))
	
	self.BodygroupAmmo = 
	{
		{
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
		{
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
		{
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
		{
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
		{
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
	}	
    
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 500000 )
	
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
	
	if( self.Destroyed ) then 
		
		if( self.Scoopweld ) then
		
			self.Scoopweld:Remove()
			self.Scoop:Fire("kill","",30)
			
		end
		
	else
	
		if( IsValid( self.Scoop ) ) then
			
			self.Scoop:Remove()
			
		end
		
	end
	
	self:TankDefaultRemove()
	
end

function ENT:Use(ply,caller)

	self.AmmoTypes = self.BodygroupAmmo[ self.Barrel:GetBodygroup( 0 ) ]

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


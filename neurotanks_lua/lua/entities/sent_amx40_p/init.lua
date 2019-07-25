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
	-- ent:Activate()

	return ent
	
end


function ENT:Initialize()

	self.AmmoIndex = 1
	self:TanksDefaultInit()
    self.Tower:SetBodygroup(0,0)
    
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
	self:StartMotionController()
	self.BodygroupAmmo = 
	{
		{ 	-- First Body group loadout
			{
				PrintName = "47 mm SA34 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "47 mm SA34 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Second boydgroup loadout
			{
				PrintName = "47 mm SA35 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "47 mm SA35 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- I think you get it by now.
			{
				PrintName = "47 mm SA34 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "47 mm SA34 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Incase you didnt't: 4th body group loadout
			{
				PrintName = "47 mm SA35 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "47 mm SA35 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
        };
		{	-- Incase you didnt't: 4th body group loadout
			{
				PrintName = "75 mm SA32 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "75 mm SA32 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};            
		};
	}
	
	self.UnUsed = true
		
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
	
	if( self.UnUsed ) then
		
		self.UnUsed = false
		
		local rand1 = 1 -- math.random(0,1)
		local rand2
		
		local ent = self
		
		if rand1 == 0 then
			rand2 = math.random(0,1)
			ent.HasMGun = false
			ent.HasCMGun = false
			ent.ComplexMGun = false        
		elseif rand1 == 1 then  
			rand2 = math.random(2,4)
			ent.HasMGun = true
			ent.HasCMGun = true
			ent.ComplexMGun = true
			ent.MGunTowerModel = "models/aftokinito/wot/french/amx40_mgunturret.mdl"
			ent.MGunTowerPos = Vector(14,-10.5,83.25)
			ent.MGunModel = "models/aftokinito/wot/french/amx40_mgun.mdl"
			ent.MGunPos = Vector(14.5,-9.5,87.75)
			ent.CMGunPos = Vector(14.5,-9.5,87.75)
			ent.CMGunDelay = 0.15
			ent.MGunSound = Sound("wot/global/mgun.wav")        
		end
		
		ent.TowerPos = self.TowersPos[rand1+1].Pos
		ent.BarrelPos = self.BarrelsPos[rand2+1].Pos
		ent.BarrelLength = self.BarrelsPos[rand2+1].BLength
		
		ent:Spawn()
		ent:Activate()

		-- if( self.SkinCount && self.SkinCount > 1 ) then
		
			ent:SetSkin( math.random(0, self:SkinCount() ) )
		
		-- end
		
		ent.Tower:SetBodygroup(0,rand1)
		ent.Barrel:SetBodygroup(0,rand2)
		
	end
	
	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()
	-- Make sure you get the right ammo post-barrelchange
   	self.AmmoTypes = self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1] -- Since Luas first table index is 1 and bodygroups use 0 we add one
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


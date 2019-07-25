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
	
	-- local rand1 = math.random(0,1)
    rand2 = math.random(0,3)
    -- ent.Tower:SetBodygroup(0,rand1)
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
				PrintName = "37 mm M1916 AP",
				Type = "sent_tank_apshell",
				Delay = self.NonBurstDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "37 mm M1916 HE",
				Type = "sent_tank_shell",
				Delay = self.NonBurstDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Second boydgroup loadout
			{
				PrintName = "37 mm M1924 AP",
				Type = "sent_tank_apshell",
				MinDmg = 25,
				MaxDmg = 65,
				Delay = self.APDelay,
				Sound = self.BurstSound,
                Burst = true,
			};
			{
				PrintName = "37 mm M1924 HE",
				Type = "sent_tank_shell",
				MinDmg = 25,
				MaxDmg = 55,
				Delay = self.PrimaryDelay,
				Sound = self.BurstSound,
                Burst = true,
			};
		};
		{	-- I think you get it by now.
			{
				PrintName = "37 mm Browning AP",
				Type = "sent_tank_apshell",
				MinDmg = 100,
				MaxDmg = 110,
				Delay = self.APDelay,
				Sound = self.BurstSound,
                Burst = true,
			};
			{
				PrintName = "37 mm Browning HE",
				Type = "sent_tank_shell",
				MinDmg = 10,
				MaxDmg = 90,
				Delay = self.PrimaryDelay,
				Sound = self.BurstSound,
                Burst = true,
			};
		};
		{	-- Incase you didnt't: 4th body group loadout
			{
				PrintName = "20 mm Hispano-Suiza Birgikt AP",
				Type = "sent_tank_apshell",
				Delay = self.NonBurstDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "20 mm Hispano-Suiza Birgikt HE",
				Type = "sent_tank_shell",
				Delay = self.NonBurstDelay,
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

    -- Make sure you get the right ammo post-barrelchange
    self.AmmoTypes = self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1] -- Since Luas first table index is 1 and bodygroups use 0 we add one
    if self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1][self.AmmoIndex].Burst then
        self.BurstFire = true 
    else
        self.BurstFire = false
    end
    self.PrimaryDelay = self.AmmoTypes[self.AmmoIndex].Delay   
	self:TankDefaultUse( ply, caller )

	
end

function ENT:Think()

	self:TankDefaultThink() 
    
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


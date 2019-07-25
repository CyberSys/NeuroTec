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
    -- ent.Tower:SetBodygroup(0,0)
	-- ent.Barrel:SetBodygroup(0,1)
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end

	return ent
	
end


function ENT:Initialize()
self.AmmoStructure = 
	{
		{
			Barrel = 0,
			Tower = 0,
			BarrelPos = Vector( 55, -9.3, 102 ),
			Ammo = 
			{
				{ -- First turret
					PrintName = "76 mm Gun M1A1 AP",
					Type = "sent_tank_apshell",
					Delay = self.APDelay,
					Sound = self.ShootSound,
					MinDmg = 1150,
					MaxDmg = 1850,
				};
				{
					PrintName = "76 mm Gun M1A1 HE",
					Type = "sent_tank_shell",
					Delay = self.PrimaryDelay,
					Sound = self.ShootSound,
					MinDmg = 1150,
					MaxDmg = 1850,
				};
			};
		};
		{
			Barrel = 1,
			Tower = 0,
			BarrelPos = Vector( 55, -9.3, 102 ),
			Ammo = {
						{
							PrintName = "90 mm DCA 30 AP",
							Type = "sent_tank_apshell",
							Delay = self.APDelay,
							Sound = self.ShootSound,
							MinDmg = 2400,
							MaxDmg = 3200,
						};
						{
							PrintName = "90 mm DCA 30 HE",
							Type = "sent_tank_shell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
							MinDmg = 2400,
							MaxDmg = 3200,
						};
					}
		};
		{	
			Barrel = 2,
			Tower = 1,
			BarrelPos = Vector( 47, 0, 87 ),
			Ammo = {
						{ -- Second turret
							PrintName = "76 mm Gun M1A1 AP",
							Type = "sent_tank_apshell",
							Delay = self.APDelay,
							Sound = self.ShootSound,
							MinDmg = 1150,
							MaxDmg = 1850,
						};
						{
							PrintName = "76 mm Gun M1A1 HE",
							Type = "sent_tank_shell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
							MinDmg = 1150,
							MaxDmg = 1850,
						};
					};
		};
		{	
			Barrel = 3,
			Tower = 1,
			BarrelPos = Vector( 47, 0, 87 ),
			Ammo = {			
					{
						PrintName = "90 mm DCA 30 AP",
						Type = "sent_tank_apshell",
						Delay = self.APDelay,
						Sound = self.ShootSound,
						MinDmg = 2400,
						MaxDmg = 3200,
					};
					{
						PrintName = "90 mm DCA 30 HE",
						Type = "sent_tank_shell",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 2400,
						MaxDmg = 3200,
					};
				};
		};		
		{	
			Barrel = 4,
			Tower = 1,
			BarrelPos = Vector( 47, 0, 87 ),
			Ammo = {			
					{
						PrintName = "90 mm F3 AP",
						Type = "sent_tank_apshell",
						Delay = self.APDelay,
						Sound = self.ShootSound,
						MinDmg = 2400,
						MaxDmg = 3200,
					};
					{
						PrintName = "90 mm F3 HE",
						Type = "sent_tank_shell",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 2400,
						MaxDmg = 3200,
					};
				};
		};
		{
			Barrel = 5,
			Tower = 1,
			BarrelPos = Vector( 47, 0, 87 ),
			Ammo = {
					{	
						PrintName = "105 mm Canon 13TR AP",
						Type = "sent_tank_apshell",
						Delay = self.APDelay,
						Sound = self.ShootSound,
						MinDmg = 3000,
						MaxDmg = 3600,
					};
					{
						PrintName = "105 mm Canon 13TR HE",
						Type = "sent_tank_shell",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 3000,
						MaxDmg = 3600,
					};
				};
		};
		{	
			Barrel = 6,
			Tower = 1,
			BarrelPos = Vector( 47, 0, 87 ),
			Ammo = {
					{
						PrintName = "90 mm DCA 45 AP",
						Type = "sent_tank_apshell",
						Delay = self.APDelay,
						Sound = self.ShootSound,
						MinDmg = 2400,
						MaxDmg = 3200,
					};
					{
						PrintName = "90 mm DCA 45 HE",
						Type = "sent_tank_shell",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 2400,
						MaxDmg = 3200,
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

   	-- self.AmmoTypes = self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1] -- Since Luas first table index is 1 and bodygroups use 0 we add one

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


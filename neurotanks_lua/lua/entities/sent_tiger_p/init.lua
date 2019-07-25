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
	
	if rand1 == 1 then
			rand2 = math.random(0,2)
			ent.Tower:SetBodygroup(0,rand1)
			ent.Barrel:SetBodygroup(0,rand2)
	elseif rand1 == 0 then
			rand2 = math.random(3,5)
			ent.Tower:SetBodygroup(0,rand1)
			ent.Barrel:SetBodygroup(0,rand2)

	end

	return ent
	
end


function ENT:Initialize()

self.AmmoStructure = {
						{ 
							Tower = 1, 
							Barrel = 0, 
							Ammo = {										
										{
											PrintName = "75mm KwK 42 L/70 APCBC-HE",
											Type = "sent_tank_armorpiercing",
											MinDmg = 1700,
											MaxDmg = 2200,
											Radius = 10,
											Delay = self.APDelay,
											Sound = self.ShootSound,
										};
									};
						};
						{
							Tower = 1, 
							Barrel = 1, 
							Ammo = {											
								{
									PrintName = "105mm KwK 42 L/28 HE",
									Type = "sent_tank_shell" ,
									MinDmg = 500,
									MaxDmg = 1000,
									Radius = 1024,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};
								{
									PrintName = "105mm KwK 42 L/28 Canister Shell",
									Type = "sent_tank_clustershell",
									MinDmg = 100,
									MaxDmg = 450,
									Radius = 1024,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};
							};
						};
						{
							Tower = 1, 
							Barrel = 2, 
							Ammo = {					
								{
									PrintName = "75mm KwK 42 L/70 AP",
									Type = "sent_tank_apshell",
									MinDmg = 1700,
									MaxDmg = 2200,
									Radius = 7,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};
								{
									PrintName = "75mm KwK 42 L/70 HE",
									Type = "sent_tank_shell" ,
									MinDmg = 1700,
									MaxDmg = 2200,
									Radius = 7,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};                        
								{
									PrintName = "75mm KwK 42 L/70 APCBC-HE",
									Type = "sent_tank_armorpiercing",
									MinDmg = 550,
									MaxDmg = 950,
									Radius = 128,
									Delay = self.APDelay,
									Sound = self.ShootSound,
								}
							};
						
						};
						{
							Tower = 0,
							Barrel = 3,
							Ammo = {						
									{
										PrintName = "75mm KwK 42 L/70 APCBC-HE",
										Type = "sent_tank_armorpiercing",
										MinDmg = 1700,
										MaxDmg = 2200,
										Radius = 10,
										Delay = self.PrimaryDelay,
										Sound = self.ShootSound,
									};
								};
						
						};
						{
							Tower = 0,
							Barrel = 4,
							Ammo = {						
													
									{
										PrintName = "88mm KwK 36 L/56 HE",
										Type = "sent_tank_shell" ,
										MinDmg = 1250,
										MaxDmg = 1900,
										Radius = self.BlastRadius,
										Delay = self.PrimaryDelay,
										Sound = self.ShootSound,
									};
									{
										PrintName = "88mm KwK 36 L/56 AP",
										Type = "sent_tank_apshell",
										MinDmg = 1250,
										MaxDmg = 1900,
										Radius = self.BlastRadius,
										Delay = self.PrimaryDelay,
										Sound = self.ShootSound,
									};                        
									{
										PrintName = "88mm KwK 36 L/56 APCBC-HE",
										Type = "sent_tank_armorpiercing",
										MinDmg = 550,
										MaxDmg = 950,
										Radius = self.BlastRadius,
										Delay = self.APDelay,
										Sound = self.ShootSound,
									}
								};
						
						};
						{
							Tower = 0,
							Barrel = 5,
							Ammo = {						
								{
									PrintName = "88mm KwK 43 L/71 AP",
									Type = "sent_tank_apshell",
									MinDmg = 1700,
									MaxDmg = 2200,
									Radius = self.BlastRadius,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};
								{
									PrintName = "88mm KwK 43 L/71 HE",
									Type = "sent_tank_shell",
									MinDmg = 1700,
									MaxDmg = 2200,
									Radius = self.BlastRadius,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};                        
								{
									PrintName = "88mm KwK 43 L/71 APCBC-HE",
									Type = "sent_tank_armorpiercing",
									MinDmg = 550,
									MaxDmg = 950,
									Radius = self.BlastRadius,
									Delay = self.APDelay,
									Sound = self.ShootSound,
								}
							};
						
						};
						
					};
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


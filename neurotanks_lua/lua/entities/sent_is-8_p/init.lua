AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 111
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( self.FolderName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

	return ent
	
end


function ENT:Initialize()
self.AmmoStructure = {
                                                {  
                                                        Tower = 0,
                                                        Barrel = 0,
                                                        Ammo = {                                                                               
                                                                {
                                                                        PrintName = "122mm D25T AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1400,
																		MaxDmg = 2000,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "122mm D25T HE",
																		Type = "sent_tank_shell",
																		MinDmg = 1000,
																		MaxDmg = 1600,
																		Radius = 128,
																		Delay = self.APDelay,
																		Sound = self.ShootSound,
																};
                                                        };
                                                };
                                                {  
                                                        Tower = 0,
                                                        Barrel = 1,
                                                        Ammo = {                                                                               
                                                                {
                                                                        PrintName = "122mm BL-9 AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1500,
																		MaxDmg = 2300,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "122mm BL-9 HE",
																		Type = "sent_tank_shell",
																		MinDmg = 1100,
																		MaxDmg = 1800,
																		Radius = 128,
																		Delay = self.APDelay,
																		Sound = self.ShootSound,
																};
                                                        };
                                                };
                                                {  
                                                        Tower = 0,
                                                        Barrel = 2,
                                                        Ammo = {                                                                               
                                                                {
                                                                        PrintName = "122mm M62-T2 AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1700,
																		MaxDmg = 2800,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "122mm M62-T2 APCR",
																		Type = "sent_tank_armorpiercing",
																		MinDmg = 1300,
																		MaxDmg = 2000,
																		Radius = 128,
																		Delay = self.APDelay,
																		Sound = self.ShootSound,
																};
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

	self:TankTowerRotation()
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end


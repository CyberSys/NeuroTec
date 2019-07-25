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

	return ent
	
end


function ENT:Initialize()
self.AmmoStructure = {
                                                {  
                                                        Tower = 0,
                                                        Barrel = 0,
                                                        Ammo = {                                                                               
                                                                {
                                                                        PrintName = "100mm-D10T AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1200,
																		MaxDmg = 2700,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "100mm-D10T2 HE",
																		Type = "sent_tank_shell",
																		MinDmg = 800,
																		MaxDmg = 1700,
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
                                                                        PrintName = "122mm-D25T AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1500,
																		MaxDmg = 2700,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "122mm-D25T HE",
																		Type = "sent_tank_shell",
																		MinDmg = 900,
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
                                                                        PrintName = "122mm-BL9 AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 2100,
																		MaxDmg = 3000,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "122mm-BL9 HE",
																		Type = "sent_tank_shell",
																		MinDmg = 1100,
																		MaxDmg = 1900,
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


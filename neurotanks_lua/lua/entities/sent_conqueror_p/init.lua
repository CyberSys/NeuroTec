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
                                                                        PrintName = "OQF-20pdr Type-A AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 600,
																		MaxDmg = 1200,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "OQF-20pdr Type-A HE",
																		Type = "sent_tank_shell",
																		MinDmg = 800,
																		MaxDmg = 1100,
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
                                                                        PrintName = "OQF-20pdr Type-B AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1000,
																		MaxDmg = 1800,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "OQF-20pdr Type-B HE",
																		Type = "sent_tank_shell",
																		MinDmg = 1100,
																		MaxDmg = 1700,
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
                                                                        PrintName = "120 mm Gun L1A1 AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 1300,
																		MaxDmg = 2000,
																		Radius = 7,
																		Delay = self.PrimaryDelay,
																		Sound = self.ShootSound,
                                                                };
																{
																		PrintName = "120 mm Gun L1A1 HE",
																		Type = "sent_tank_shell",
																		MinDmg = 1700,
																		MaxDmg = 2100,
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
	-- print("what")
	self:TankDefaultRemove()
	-- print("what")
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


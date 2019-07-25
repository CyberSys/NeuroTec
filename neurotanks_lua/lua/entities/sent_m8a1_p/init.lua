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

	return ent
	
end


function ENT:Initialize()
	self.AmmoStructure = { 
						{
							Barrel = 0,
							Tower = 0,
							Ammo = {
										
										{
											PrintName = "38 mm Gun M1 HE",
											Type = "sent_tank_shell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage,
											Radius = 256,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};
										{
											PrintName = "38 mm Gun M1 Canister",
											Type = "sent_tank_clustershell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage,
											Radius = 256,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};
									};
						};
						{
							Barrel = 1,
							Tower = 0,
							Ammo = {
										{
											PrintName = "75 mm AT Howitzer M3 AP",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage*1.25,
											MaxDmg = self.MaxDamage*1.25,
											Radius = 64,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};	
						{
							Barrel = 2,
							Tower = 0,
							Ammo = {
										
										{
											PrintName = "75 mm AT Gun M3 AP",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage*1.5,
											MaxDmg = self.MaxDamage*1.5,
											Radius = 32,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};	
						{
							Barrel = 3,
							Tower = 0,
							Ammo = {
										
										{
											PrintName = "57 mm Gun M1 AP",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage*1.7,
											MaxDmg = self.MaxDamage*1.7,
											Radius = 32,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};
										{
											PrintName = "57 mm Gun M1 HE",
											Type = "sent_tank_shell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage,
											Radius = 512,
											Delay = self.PrimaryDelay,
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
	
	if( self.HasTower ) then
	
		self:TankTowerRotation()
	
	else
		
		self:TankNoTowerRotation()
	
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end


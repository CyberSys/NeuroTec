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
	-- self.AmmoIndex = 1
	self.AmmoStructure = { 
						{
							Barrel = 0,
							Tower = 0,
							Ammo = 
							{
								{
									PrintName = "45 mm 20K AP",
									Type = "sent_tank_apshell",
									MinDmg = self.MinDamage,
									MaxDmg = self.MaxDamage,
									Radius = 10,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};
								{
									PrintName = "45 mm 20K HE",
									Type = "sent_tank_shell",
									MinDmg = self.MinDamage,
									MaxDmg = self.MaxDamage,
									Radius = self.BlastRadius,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								}
							};
								
						};
						{
							Barrel = 1,
							Tower = 0,
							Ammo = 
							{
								{
									PrintName = "37 mm automatic SH-37 HE",
									Type = "sent_tank_autocannon_shell",
									MinDmg = 460,
									MaxDmg = 700,
									Radius = 256,
									Delay = 1,
									Sound = self.ShootSound,
								};
								{
									PrintName = "37 mm automatic SH-37 HE",
									Type = "sent_tank_mgbullet",
									MinDmg = 450,
									MaxDmg = 750,
									Radius = 128,
									Delay = 1,
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


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
	
	local rnd = math.random( 0,2 )
	local rnd2 = math.random( 0,1 )
	
	ent:SetBodygroup( 0,rnd2 )
	ent.Barrel:SetBodygroup( 0,rnd )
	ent.Tower:SetBodygroup( 0,rnd )
	-- print( rnd, rnd2 )
	
	return ent
	
end


function ENT:Initialize()
	-- AP and HE shell fx for tanks, 
	--particle names are he_impact_dirt, 
	--he_impact_wall and ap_impact_dirt, 
	--ap_impact_wall. wall variants are for when a shell hits a vertical surface or another tank.

	self.AmmoIndex = 1
	self.AmmoTypes = { 
					
						{
							PrintName = "OQF 17-pdr Gun Mk. VII HE",
							Type = self.PrimaryAmmo,
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
							CustomParticleEffect = {  "he_impact_wall", "he_impact_dirt" }, -- Decides custom particle effect.
						};
						{
							PrintName = "OQF 17-pdr Gun Mk. VII AP",
							Type = "sent_tank_apshell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
							CustomParticleEffect = {  "ap_impact_wall", "ap_impact_dirt" }
						}

					
					};

	self:TanksDefaultInit()

	
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
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
	
	self.AmmoTables = {
						{ 
							{
								PrintName = "OQF 17-pdr Gun Mk. VII HE",
								Type = self.PrimaryAmmo,
								Delay = self.PrimaryDelay,
								Sound = self.ShootSound,
								MinDmg = 900,
								MaxDmg = 1500,
							};
							{
								PrintName = "OQF 17-pdr Gun Mk. VII AP",
								Type = "sent_tank_apshell",
								Delay = self.PrimaryDelay,
								Sound = self.ShootSound,
								MinDmg = 1500,
								MaxDmg = 1900,
							};
						
						};
					}   
					
			
	self.AmmoTypes = self.AmmoTables[self.Barrel:GetBodygroup(0)+1]
	
	
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


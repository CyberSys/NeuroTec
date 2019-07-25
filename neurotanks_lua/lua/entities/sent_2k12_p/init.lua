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
											PrintName = "9M336 Ground-to-Air missile",
											Type = "sent_tank_missile",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage,
											Radius = self.BlastRadius,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
											Model = "models/killstr3aks/wot/russian/9m336_missile_body.mdl",
											IsHoming = true, -- enable heat seeker
											Boosted = true, -- enable rocket boost. 
											ExhaustPosDistance = 1 -- distance for fire trail 
									};
								   };
							};
						};
	self:TanksDefaultInit()
	self:StartMotionController()

end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
		if( data.DeltaTime < 0.2 ) then return end
		
		self:TankDefaultCollision( data, physobj )
	end)
	
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


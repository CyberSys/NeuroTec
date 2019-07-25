AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr,class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( class )
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
    	self.AmmoTypes = { 
						
						{
							PrintName = "15 cm HE",
							Type = "sent_artillery_shell",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = 1670,
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						{
							PrintName = "15 cm AA",
							Type = "sent_tank_flak",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = 1024,
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};                        

					
					};

	self:TanksDefaultInit()
	self:StartMotionController()
	
	local _materials = {"models/props_pipes/pipeset_metal02", "models/props_pipes/pipeset_metal", "models/props_pipes/destroyedpipes01a" }
	local mat =_materials[math.random(1,#_materials)]
	
	-- self:SetSubMaterial( 0, "models/props_pipes/pipeset_metal" )
	self:SetSubMaterial( 0, mat )
	self:SetSubMaterial( 1, mat )
	self:SetSubMaterial( 2, mat)
	self:SetSubMaterial( 3, mat )
	self.Barrel:SetSubMaterial( 0, mat )
	self.Tower:SetSubMaterial( 0, mat )
	
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
	
	self:GetPhysicsObject():Wake()
	
	if( self.HasTower ) then
	
		self:TankTowerRotation()
	
	else
		
		self:TankNoTowerRotation()
	
	end
	
	if( IsValid( self.TowerProxy ) && IsValid( self.Tower ) ) then 		
	
		self.TowerProxy:SetPos( self.Tower:GetPos() )  
		self.TowerProxy:SetAngles( self.Tower:GetAngles() ) 
		self.TowerProxy:SetBodygroup( 0, self.Tower:GetBodygroup(0) )
		
	end
	
end

-- function ENT:PhysicsSimulate( phys, deltatime )
	
	-- self:TankHeavyPhysics( phys, deltatime )
	
-- end


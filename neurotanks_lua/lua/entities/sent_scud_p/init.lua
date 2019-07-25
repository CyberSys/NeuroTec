AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 150
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( class )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

	return ent
	
end


function ENT:Initialize()
	
	self.AmmoTypes = 
	{
		{
			PrintName = "SCUD Missile",
			Type = "sent_tank_scud_missile",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			Model = "models/aftokinito/neurotanks/russian/scud_scud.mdl",
			IsHoming = true, -- enable heat seeker
			UseTargetVector = true, -- locks on ground vector
			Boosted = true, -- gives rocket boost
			ExhaustPosDistance = 100 -- distance for fire trail 
			
		};
	}
	

	self:TanksDefaultInit()
	
	self.SCUDRamp = ents.Create("prop_physics_override")
	self.SCUDRamp:SetModel("models/aftokinito/neurotanks/russian/scud_launcher.mdl")
	self.SCUDRamp:SetPos( self.Barrel:GetPos() )
	self.SCUDRamp:SetAngles( self.Barrel:GetAngles() )
	self.SCUDRamp:SetSolid( SOLID_NONE )
	self.SCUDRamp:SetParent( self.Barrel )
	self.SCUDRamp:Spawn()
	
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
	-- Make sure you get the right ammo post-barrelchange
	self:NextThink( CurTime() )
	
	self:GetPhysicsObject():Wake()
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	-- if( self.HasTower ) then
	
		-- self:TankTowerRotation()
	
	-- else
		
		self:TankScudTowerRotation()
	
	-- end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end


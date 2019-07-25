AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.AmmoIndex = 1
	self.AmmoTypes = { 
						
						-- {
							-- PrintName = "AP Shell",
							-- Type = "sent_tank_apshell",
							-- MinDmg = self.MinDamage,
							-- MaxDmg = self.MaxDamage,
							-- Radius = 10,
							-- Delay = self.PrimaryDelay,
							-- Sound = self.ShootSound,
						-- };                     
						{
							PrintName = "HE Round",
							Type = "sent_tank_mgbullet",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};

					
					};
               
	self:TanksDefaultInit()
    
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 50000 )
	
	self:StartMotionController()
	self:SetColor( Color( 0,0,0,0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
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

-- function ENT:PhysicsSimulate( phys, deltatime )
	
	-- self:TankHeavyPhysics( phys, deltatime )
	
-- end


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.AmmoTypes = { 
						
						{
							PrintName = "30CM MISERY",
							Type = "sent_tank_38cm_rocket",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/d30_artillery_fire.mp3"),
						};
						{
							PrintName = ".3M DESPAIR",
							Type = "sent_tank_clustershell",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/d30_artillery_fire.mp3"),
						};
					
					};
               
	self:TanksDefaultInit()
    self:GetPhysicsObject():SetMass( 500 )
	self:StartMotionController()
	self:SetColor( Color( 0,0,0,0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
	-- if( IsValid( self.TowerProxy ) ) then
		
		-- self.TowerProxy.Owner = self.Owner
		
	-- end
	self.Barrel:SetAngles( self.Barrel:GetAngles() + Angle( -25, 0,0 ) )
	
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
	
	if( IsValid( self.TowerProxy ) && !self.Destroyed ) then
		
		self.TowerProxy:SetPos( self.Tower:GetPos() )
		self.TowerProxy:SetAngles( self.Tower:GetAngles() )
		
	end
	-- self:TankHeavyPhysics( phys, deltatime )
	
end


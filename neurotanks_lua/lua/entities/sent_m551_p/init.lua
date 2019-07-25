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
	
	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "metal" } ) 
	
	return ent
	
end


function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	self:TankDefaultCollision( data, physobj )
	
end

function ENT:Initialize()
	
	self.AmmoIndex = 1
	self.AmmoTypes = { 
						
						{
							PrintName = "152mm M81E2 HE",
							Type = "sent_tank_shell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						{
							PrintName = "MGM-51 Shillelagh",
							Type = "sent_tank_missile",
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/tunguska_missile_fire.wav"),
						}

					
					};
					
	-- Smoke grenade launcher
	-- self.TubePos = {}
	-- self.TubeAng = {}
	
	self:TanksDefaultInit()
	
	-- for i=1,#self.TrackEntities do
		
		-- if( IsValid( self.TrackEntities[i] ) ) then
			
			-- construct.SetPhysProp( self, self.TrackEntities[i], 0, nil,  { GravityToggle = true, Material = "glass" } ) 
			-- self.TrackEntities[i]:GetPhysicsObject():SetMass( 500 )
			
		-- end
	
	-- end
	
	self:StartMotionController()
	
	-- self:GetPhysicsObject():SetMass( 2000 )
	-- self.Tower:GetPhysicsObject():SetMass( 1 )
	-- self.Barrel:GetPhysicsObject():SetMass( 1 )
	
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
	
	-- self:TankDefaultPhysics( phys, deltatime )
	self:TankHeavyPhysics( phys, deltatime )
	
end


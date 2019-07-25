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
	
	if( ply:IsAdmin() ) then
		
		table.insert( ent.AmmoTypes,
									{
										PrintName = "Admin Nuclear Shell",
										Type = "sent_a2s_nuclear_bomb",
										MinDmg = 7000,
										MaxDmg = 8000,
										Radius = 5000,
										Delay = 10,
										Sound = "bf2/tanks/tunguska_missile_fire.wav",
									} )
	
	end
	
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end
	
	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } ) 
	
	return ent
	
end


function ENT:Initialize()
	
	self.AmmoIndex = 1
	self.AmmoTypes = { 
						
						{
							PrintName = "105MM Shell",
							Type = self.PrimaryAmmo,
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						{
							PrintName = "Tank Missile",
							Type = "sent_tank_missile",
							MinDmg = 800,
							MaxDmg = 2000,
							Radius = 300,
							Delay = 4.20,
							Sound = "bf2/tanks/tunguska_missile_fire.wav",
						}

					
					};
					
	-- Smoke grenade launcher
	-- self.TubePos = {}
	-- self.TubeAng = {}
	
	self:TanksDefaultInit()
	self:StartMotionController()
	
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


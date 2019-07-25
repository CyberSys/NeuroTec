AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
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
self.AmmoTypes = {
					{
						PrintName = "380 mm RW 61 HE",
						Type = "sent_tank_38cm_rocket",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 2500,
						MaxDmg = 4500,
						Radius = 800
					};
					--[[{
						PrintName = "380 mm RW 61 Incendiary Canister",
						Type = "sent_tank_clustershell",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 500,
						MaxDmg = 750,
						Radius = 400,
					};
					{
						PrintName = "380 mm RW 61 Poison Canister",
						Type = "sent_tank_poison_shell",
						Delay = self.PrimaryDelay,
						Sound = self.ShootSound,
						MinDmg = 500,
						MaxDmg = 750,
						Radius = 400,
					};-]]

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
	
	self:TankNoTowerRotation()
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end


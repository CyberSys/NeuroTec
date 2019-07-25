// Use this as base for helicopters with physical rotors.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
function ENT:SpawnFunction( ply, tr, class )
	local SpawnPos = ply:GetPos() + Vector(0,0,15)
	local ent = ents.Create( class )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent:Use( ply, ply, 0, 0 )
	return ent
end
function ENT:Initialize()
	self:HelicopterDefaultInit()
		self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 50000000 )
end
function ENT:OnRemove()
	self:HelicopterDefaultOnRemove()
end
function ENT:OnTakeDamage(dmginfo)
	
	self:HelicopterDefaultDamageScript( dmginfo )
end
function ENT:PhysicsCollide( data, physobj )
	self:DefaultCollisionCallback( data, physobj )
end
function ENT:Use(ply,caller)
	self:NeuroPlanes_DefaultHeloUse( ply )
end
function ENT:Think()
	self:HelicopterDefaultThink2()
end
function ENT:PrimaryAttack()
	self:HelicopterMgunAttack()
end
function ENT:SecondaryAttack( wep, id )
	if ( IsValid( wep ) ) then
		self:NeuroPlanes_FireRobot( wep, id )
	end
end

function ENT:PhysicsSimulate( phys, deltatime )
	self:HelicopterDefaultPhysics( phys, deltatime )
end

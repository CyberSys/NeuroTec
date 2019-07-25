AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 50
	local ent = ents.Create( class )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
		ent:AddAdminEquipment()
	end
	return ent
end
function ENT:Initialize()
	self:CivAir_DefaultInit()
end
function ENT:OnTakeDamage(dmginfo)
	self:CivAir_DefaultDamage(dmginfo)
end
function ENT:OnRemove()
	self:CivAir_OnRemove()
end
function ENT:PhysicsCollide( data, physobj )
	self:CivAir_PhysCollide( data, physobj )
end
function ENT:Use(ply,caller, a, b )
	self:CivAir_DefaultUse( ply,caller, a , b )
end
function ENT:Think()
	self:CivAir_Think()
end
function ENT:PrimaryAttack()
	return
end
function ENT:SecondaryAttack( wep, id )
	return
end
function ENT:PhysicsSimulate( phys, deltatime )
	self:CivAir_DefaultMovement( phys, deltatime )
end

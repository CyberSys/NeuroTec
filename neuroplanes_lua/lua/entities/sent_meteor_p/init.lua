AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
function ENT:SpawnFunction( ply, tr, class )
	local SpawnPos = tr.HitPos + tr.HitNormal * 100
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
	self:JetAir_Init()
end
function ENT:OnTakeDamage(dmginfo)
	self:JetAir_TakeDamage( dmginfo )
end
function ENT:OnRemove()
	self:JetAir_OnRemove()
end
function ENT:PhysicsCollide( data, physobj )
	if ( self.Speed > self.MaxVelocity * 0.55 && data.DeltaTime > 0.4 ) then 
		self:DeathFX()
	end
end
function ENT:Use(ply,caller)
	self:CivAir_DefaultUse( ply,caller, a , b )
end
function ENT:Think()
	self:JetAir_Think()
end
function ENT:PrimaryAttack()
	if ( !IsValid( self.Pilot ) ) then return end
	self:Jet_FireMultiBarrel()
	self.Miniguns[math.random(1,#self.Miniguns)]:EmitSound( self.MinigunSound, 510, math.random( 120, 130 ) )
	self.LastPrimaryAttack = CurTime()
end
function ENT:SecondaryAttack( wep, id )
	if ( IsValid( wep ) ) then
		self:NeuroPlanes_FireRobot( wep, id )
	end
end
function ENT:PhysicsSimulate( phys, deltatime )
	self:JetAir_PhysSim( phys, deltatime )
end

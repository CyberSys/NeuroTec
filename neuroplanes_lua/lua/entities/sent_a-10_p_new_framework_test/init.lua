AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = ply:GetPos() + ply:GetForward() * 400 + ply:GetUp() * 128
	local ent = ents.Create( self.EntityType )
	ent:SetPos( SpawnPos )
	ent:SetAngles( ply:GetAngles() )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:NeuroAir_Default_Jet_Init()

end

function ENT:OnTakeDamage(dmginfo)
	
	self:NA_Default_Jet_TakeDamage( dmginfo )
	
end

function ENT:OnRemove()

	self:NA_GenericOnRemove()
	
end

function ENT:PhysicsUpdate()
				
	self:NA_GenericPhysUpdate()

end

function ENT:PhysicsCollide( data, physobj )

	self:NA_Default_Jet_PhysicsCollide( data, physobj )
	
end

function ENT:Use(ply,caller)

	self:NA_DefaultUseStuff( ply, caller )
	
end

function ENT:Think()
 
	self:NA_GenericJetThink()
	-- self:NextThink( CurTime() )
	
end

function ENT:PrimaryAttack()
	
	self:NA_25mmPrimaryAttack()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:NA_DefaultPhysSim( phys, deltatime )
	
end


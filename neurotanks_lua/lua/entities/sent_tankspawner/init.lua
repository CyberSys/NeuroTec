AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local ent = ents.Create( "sent_tankspawner" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( "models/props_combine/breenconsole.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
		
		self.PhysObj:EnableDrag( true )
		self.PhysObj:Wake()
	
	end
	
	self:SetUseType( SIMPLE_USE )

end

function ENT:OnRemove()
	

end

function ENT:Use(ply,caller)
	
	HangarMenu(ply,self.spawnerpos)

end

function ENT:Think()
return	
end

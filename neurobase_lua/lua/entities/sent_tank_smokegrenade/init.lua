AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = Sound( "ambient/fire/gascan_ignite1.wav" )
ENT.Model = "models/props_junk/PopCan01a.mdl"

function ENT:Initialize()

	self:SetModel( self.Model )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self:SetModel(self.Model)
	self.PhysObj = self:GetPhysicsObject()

	if( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		
	end
	
	self:EmitSound("weapons/smokegrenade/sg_explode.wav", 511, 100 )
	
end

function ENT:Use( activator, caller )

end

function ENT:Think()
	-- self.PhysObj:SetBuoyancyRatio( 10000.0 )
	return true
end

function ENT:OnRemove()

end

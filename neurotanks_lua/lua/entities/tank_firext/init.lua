
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


function ENT:Initialize()

	self:SetModel( "models/props_c17/oildrum001_explosive.mdl" )

	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.LeakPos = {}
	
	-- self:SetPos( self:GetPos() + self:GetUp() * 16 )
	
end

function ENT:Think()
	
	if( self.Destroyed ) then return end
	

end

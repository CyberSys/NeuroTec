AddCSLuaFile()
ENT.Type = "anim"

ENT.Author			= ""
ENT.Contact			= ""
ENT.PrintName		= ""
ENT.Purpose			= ""
ENT.Instructions			= ""
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Model = "models/props_junk/popcan01a.mdl"
ENT.DeployDelay = 25

function ENT:Initialize()

	self:SetModel( self.Model)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	
	if( CLIENT ) then 
		
		self:CreateParticleEffect("microplane_explosion", 0 )
	
	end 
	
end
function ENT:Think()
end
function ENT:Draw()


	
end
function ENT:OnRemove()
end
function ENT:PhysicsUpdate()
end
function ENT:PhysicsCollide(data,phys)
end
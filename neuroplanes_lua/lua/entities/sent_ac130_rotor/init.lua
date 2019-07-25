AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/military2/air/air_130_r.mdl"

function ENT:Initialize()
	self.Entity:SetModel( self.Model )
	self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_NONE )	
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetModel(self.Model)
end


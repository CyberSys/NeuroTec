
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
 	if ( !self:GetModel() ) then
		self:SetModel( "models/hawx/planes/cockpits/a-10 thunderbolt ii_cockpit.mdl" )	
	end
   self:PhysicsInit( SOLID_NONE )  	
    self:SetMoveType( MOVETYPE_NONE )
    self:SetSolid( SOLID_NONE )
	
	self:StartMotionController()

end
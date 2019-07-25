include('shared.lua')

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 600
	self.CamUp = 100
	self.CockpitPosition = Vector( -3, 0, 23 )
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	return DefaultPropPlaneCView( ply, Origin, Angles, Fov )

end

function ENT:Draw()

	self:DrawModel()

end

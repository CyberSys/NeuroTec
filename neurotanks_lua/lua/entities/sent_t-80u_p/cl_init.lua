include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 200
	self.CamUp = 50
	self.CockpitPosition = Vector( -120, -12, 4 )
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end
function ENT:Draw()
	
	self:DefaultDrawInfo()
	
end

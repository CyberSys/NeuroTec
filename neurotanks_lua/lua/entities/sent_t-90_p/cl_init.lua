include('shared.lua')

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end

function ENT:Draw()
	
	self:DefaultDrawInfo()
	
end
include('shared.lua')

function ENT:Initialize()
	
	self:NeuroCarsDefaultInit()

	
end

function ENT:Think()
	
	self:DefaultNeuroCarThink()
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end

function ENT:Draw()
	
	self:NeuroCarsDefaultDraw()
	
end

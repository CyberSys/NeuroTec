include('shared.lua')
function ENT:Initialize()
end
function ENT:CalcView( ply, Origin, Angles, Fov )
	return self:JetAir_CView( ply, Origin, Angles, Fov )
end

function ENT:Draw()
	self:JetAir_Draw()
end

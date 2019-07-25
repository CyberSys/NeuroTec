include('shared.lua')
function ENT:Initialize()
	self:CivAir_CInit()
end
function ENT:CalcView( ply, Origin, Angles, Fov )
	return DefaultPropPlaneCView( ply, Origin, Angles, Fov )
end
function ENT:Draw()
	self:CivAir_Draw()
end

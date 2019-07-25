include('shared.lua')
ENT.AutomaticFrameAdvance = true 
function ENT:Initialize()
	self:HelicopterDefaultCInit()
end
function ENT:CalcView( ply, Origin, Angles, Fov )
	return self:HelicopterDefaultCalcView(  ply, Origin, Angles, Fov )
end
function ENT:Draw()
	self:HelicopterDefaultDraw()
end

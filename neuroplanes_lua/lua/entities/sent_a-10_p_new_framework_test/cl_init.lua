include('shared.lua')
	
function ENT:Initialize()
	
	self:NA_DefaultInit()
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )
	
	return self:NA_DefaultCview( ply, Origin, Angles, Fov )

end

function ENT:OnRemove()
	
	self:NA_DefaultRemove()
	
end

function ENT:Think()
	
	self:NA_DefaultThink()
	
end

function ENT:Draw()

	self:NA_DefaultDraw()
	
end


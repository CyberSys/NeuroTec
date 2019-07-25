include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos , false )
	self.SpriteMat = CreateMaterial("tank_headlight_sprite","UnlitGeneric",{
										["$basetexture"] = "sprites/light_glow02",
										["$nocull"] = 1,
										["$additive"] = 1,
										["$vertexalpha"] = 1,
										["$vertexcolor"] = 1,
									})
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end

function ENT:Draw()

	self:DrawModel()
	
	self:DefaultDrawInfo()
	
end


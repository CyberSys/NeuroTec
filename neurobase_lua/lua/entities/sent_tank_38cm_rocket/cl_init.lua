ENT.Spawnable			= false
ENT.AdminSpawnable		= false

include('shared.lua')

function ENT:Initialize()

end

function ENT:Draw()

	self.Entity:DrawModel()

end


function ENT:Think()
end

function ENT:OnRestore()
end

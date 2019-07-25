include('shared.lua')

function ENT:Initialize()

end

function ENT:Draw()

	local p = LocalPlayer()
	-- self:DrawModel()
	
	if !self:GetNWBool( "Hide", false ) then
	self:DrawModel()
	end			

end
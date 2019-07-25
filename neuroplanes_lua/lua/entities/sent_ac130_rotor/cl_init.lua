
include('shared.lua')


function ENT:Draw()

	self.Ang = self.Ang or 0
	self.Ang = self.Ang + 12

	while self.Ang > 360 do

		self.Ang = self.Ang - 360
	
	end
	
	self:SetAngles( self:GetAngles() + Angle( 0, 0, self.Ang ) )
	self:DrawModel()

end

function ENT:OnRemove()

end





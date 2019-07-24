
include('shared.lua')

function ENT:Initialize()
	self:SetPredictable( true )
end

function ENT:Draw()
	self.Entity:DrawModel()
end


function ENT:OnRemove()
	
	-- if( (LocalPlayer():GetPos() - self:GetPos() ):Length() < 10000 ) then
	
		-- surface.PlaySound( "ambient/explosions/exp"..math.random(1,4)..".wav" )
		
	-- end
	

end





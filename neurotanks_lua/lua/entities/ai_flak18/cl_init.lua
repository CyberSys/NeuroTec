
include('shared.lua')
language.Add("ai_flak18", "Flak 88")
function ENT:Initialize()
end

function ENT:Draw()
	
	local p = LocalPlayer()
	self:DrawModel()
	
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 512 ) then
			
			AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end
end

function ENT:OnRemove()
end





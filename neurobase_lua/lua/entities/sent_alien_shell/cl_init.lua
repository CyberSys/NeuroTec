
include('shared.lua')

function ENT:Initialize()
	self:SetPredictable( true )
		local dlight = DynamicLight( self:EntIndex() )
	if ( dlight && IsValid( self:GetOwner() ) ) then

		local c = Color( 0,55,255, 255 )

		dlight.Pos = self:GetOwner():GetShootPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = .5
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = 256
		dlight.DieTime = CurTime() + 0.25
		
	end 
	
end

function ENT:Draw()
	-- self.Entity:DrawModel()
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 0,55,255, 255 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 1 + math.Rand( 0, 1 )
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = 128
		dlight.DieTime = CurTime() + 0.1

	end
	
end

function ENT:OnRemove()
end




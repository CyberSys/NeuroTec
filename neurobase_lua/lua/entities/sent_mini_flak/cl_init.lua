
include('shared.lua')

function ENT:Initialize()
	self:SetPredictable( true )
end

function ENT:Draw()
	-- self.Entity:DrawModel()
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 1 + math.Rand( 0, 1 )
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = 128
		dlight.DieTime = CurTime() + 0.025

	end
	self.LastPos = self:GetPos() 
	
end

function ENT:OnRemove()
	
	if( !self.LastPos ) then return end 
	local dlight = DynamicLight( self:EntIndex().."_2" )
	if ( dlight ) then

		local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

		dlight.Pos = self.LastPos
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 2 + math.Rand( 0, 1 )
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = 256
		dlight.DieTime = CurTime() + 0.1

	end
	
end




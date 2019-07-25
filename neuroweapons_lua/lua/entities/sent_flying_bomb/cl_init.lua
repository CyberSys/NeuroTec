include('shared.lua')
-- local matHeatWave		= Material( "sprites/heatwave" )
function ENT:Initialize()
	
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	-- print("ran", self.Emitter )
end

function ENT:Draw()

	self:DrawModel()
	
	if( self:GetNetworkedBool("Started", false ) ) then
		

		-- local particle = self.Emitter:Add( "particle/smokesprites_0001" , self:LocalToWorld( Vector( -199, 0, 73 ) ) )

		-- if( particle ) then
			
			-- particle:SetDieTime( 1 )
			-- particle:SetStartAlpha( 255 )
			-- particle:SetEndAlpha( 255 )
			-- particle:SetStartSize( 16 )
			-- particle:SetEndSize( 0 )
			-- particle:SetColor( 255, 255, 255 )
			-- particle:SetCollide( false )
			-- particle:SetRoll( math.random(-1,1) )
			-- particle:SetGravity( self:GetForward() * -5000 )
			-- particle:SetCollide( true )
			
		-- end
	

		
		-- self.Emitter:Finish()
		
	end
	
	
end
function ENT:OnRemove()
end





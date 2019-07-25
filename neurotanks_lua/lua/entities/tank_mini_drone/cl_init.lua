include('shared.lua')
language.Add("tank_mini_drone", "Tank Minidrone")
function ENT:Initialize()

	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos , false )
	
end

local SpriteMat = Material(  "sprites/redglow1.vmt" )

function ENT:Draw()

	self:DrawModel()
	render.SetMaterial( SpriteMat )
	local Col = Color( 0, 255, 0, 255 )
	if( self:GetNetworkedBool("HasTarget", false ) ) then
		
		Col = Color( 255, 0, 0, 255 )
		
	end
	
	render.DrawSprite( self:LocalToWorld( Vector( 35, 0, 30 ) ), 44, 44, Col )

	if( self:GetNetworkedBool("HasTarget", false ) ) then
			
		local x = -58
		local y = 21
		local z = 14
		local pos = { Vector( x, y, z ), Vector( x, -y, z ) }
		
		for i =1,2 do
		
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( pos[i] ) )

			if ( particle ) then
				
				particle:SetVelocity( self:GetForward() * 20 )
				particle:SetDieTime( math.Rand( 1, 3 ) )
				particle:SetStartAlpha( math.Rand( 20, 30 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 3, 5 ) )
				particle:SetEndSize( math.Rand( 10, 26 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
				particle:SetAirResistance( 100 ) 
				particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(70, 110)) ) 	

			end
			
		end
	
	end
	
end

function ENT:OnRemove()

end

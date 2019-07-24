function EFFECT:Init( data )
	self.StartPos= data:GetOrigin()
	local Pos = self.StartPos
	local Normal = Vector(0,0,1)
	
	Pos = Pos + Normal * 2
	
	local emitter = ParticleEmitter( Pos )
	
	local particle = emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:GetPos() )

	if ( particle ) then
		
		particle:SetVelocity( VectorRand() * 1512 )
		particle:SetDieTime( math.Rand( 7, 12 ) )
		particle:SetStartAlpha( math.Rand( 55, 65 ) )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand( 13, 15 ) )
		particle:SetEndSize( math.Rand( 680, 830 )*2 )
		particle:SetRoll( math.Rand(0, 10) )
		particle:SetRollDelta( math.Rand(-.1, .1) )
		particle:SetColor( 255,255,255 ) 
		particle:SetAirResistance( 100 ) 
		particle:SetGravity( VectorRand() * 212 + Vector(0,0,412)) 	
		particle:SetCollide( true )
		

	end
		-- for i=1, 10 do
		 
			-- local particle = emitter:Add( "particles/smokey", Pos + VectorRand()*55 )

			-- particle:SetVelocity( VectorRand() * 250 )
			-- particle:SetDieTime( math.Rand( 5, 7 ) )
			-- particle:SetStartAlpha( math.Rand( 30, 45 ) )
			-- particle:SetStartSize( math.Rand( 552, 762 ) )
			-- particle:SetEndSize( 552 )
			-- particle:SetRoll( math.Rand( 1, 2 ) )
			-- particle:SetRollDelta( math.Rand( -1, 1 ) )
			-- particle:SetColor( 255, 255, 255 )
			-- particle:VelocityDecay( true )
			-- particle:SetAirResistance( 20 )
			-- particle:SetGravity( Vector( math.random(-7,7), math.random(-7,7), 55 ) )
			
		-- end
		
	emitter:Finish()
	
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end




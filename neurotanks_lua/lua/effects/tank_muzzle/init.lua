

/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )

	local Pos = data:GetStart()
	local Scale = data:GetScale()
	local Velocity 	= data:GetNormal()

	Pos = Pos + data:GetNormal() * -32
			
	local emitter = ParticleEmitter( Pos )
		
		for i = 1, 11 do
		
			local particle = emitter:Add( "particles/flamelet"..math.random( 1, 5 ), Pos + Velocity * i * 1 * Scale )

				particle:SetVelocity( Velocity * 0.99 * math.random( 1000, 2200 ) )
				particle:SetDieTime( math.Rand( 0.1, 0.18 ) )
				particle:SetStartAlpha( math.Rand( 240, 250 ) )
				particle:SetStartSize( math.Rand( 22, 30 ) * Scale )
				particle:SetEndSize( math.Rand( 1, 4 ) * Scale )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( math.Rand( 240, 255 ), math.Rand( 230, 255 ), 255 )

			end

		for i = 1, 8 do
		
			local particle = emitter:Add( "particles/flamelet"..math.random( 1, 5 ), ( Pos + Velocity * -45 )  + Velocity * i * 16 * Scale )
			
			if( particle ) then
			
				particle:SetVelocity( Velocity * math.random( 900, 1000 ) )
				particle:SetDieTime( math.Rand( 0.1, 0.18 ) )
				particle:SetStartAlpha( 255 )
				particle:SetStartSize( math.Rand( 20, 30 ) * Scale )
				particle:SetEndSize( math.Rand( 4, 8 ) * Scale )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -0.5, 0.5 ) )
				particle:SetColor( 240,240, 250 )
			
			end
			
		end
		
		for i = 1, 12 do
		
			local particle = emitter:Add( "particles/flamelet"..math.random( 1, 5 ), Pos + Velocity * i * 20 * Scale )
			
			if( particle ) then
			
				particle:SetVelocity( Velocity * math.random( 900, 1000 ) )
				particle:SetDieTime( math.Rand( 0.11, 0.2 ) )
				particle:SetStartAlpha( 255 )
				particle:SetStartSize( math.Rand( 20, 30 ) * Scale )
				particle:SetEndSize( math.Rand( 4, 8 ) * Scale )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -0.5, 0.5 ) )
				particle:SetColor( 120, math.random( 100, 160 ), 255 )
			
			end
			
		end
		
		for i=1,8 do
			
			local particle = emitter:Add( "effects/GAU-8_muzzleSmoke", Pos + ( Velocity * i ) )
			
			if( particle ) then
				
				particle:SetVelocity( Velocity * 150 )
				particle:SetDieTime( math.Rand( 2.4, 4.7 ) )
				particle:SetStartAlpha( math.Rand( 150, 225 ) )
				particle:SetStartSize( math.Rand( 4, 7 ) * i )
				particle:SetEndSize( math.Rand( 16, 68 ) * i )
				particle:SetRoll( math.Rand( -1,1 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( 255, 255, 255 )
				-- particle:VelocityDecay( true )
				particle:SetAirResistance( 10 )
				particle:SetGravity( Vector( math.sin(CurTime()) * 25, math.cos(CurTime()) * 25, 70 + math.random( 32,50) ) )
				
			end
			
		end
		
	emitter:Finish()
	
end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )

	-- Die instantly
	return false
	
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

	-- Do nothing - this effect is only used to spawn the particles in Init
	
end




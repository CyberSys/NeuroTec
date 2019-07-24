

--Initializes the effect. The data is a table of data 
--which was passed from the server.

-- "particles/flamelet"..math.random( 1, 5 )
--.. "particles/smokey"
function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	
	local Pos = self.Position
	local Norm = Vector(0,0,1)
	local scale = data:GetScale() or 1
	scale = math.Clamp( scale, 0, 1 )
	Pos = Pos + Norm * 6

	local emitter = ParticleEmitter( Pos )
	
	--firecloud
		for i=1, 6 do
		
			local particle = emitter:Add( "particles/flamelet"..math.random( 1, 5 ), Pos + Vector(math.random(-12,12),math.random(-12,12),math.random(-2,2)) * scale)
				
				if( particle ) then
				
					particle:SetVelocity( Vector(math.random(-15,15),math.random(-15,15),math.random( -5,55 ) ) * scale )
					particle:SetDieTime( 2 * math.Rand( 0.5, 0.9 ) * scale )
					particle:SetStartAlpha( math.random( 1,5 ) )
					particle:SetEndAlpha( 0 )
					
					particle:SetStartSize( math.random(  10, 15 ) * scale/2 )
					particle:SetEndSize( math.random( 1, 2 ) * scale)
					particle:SetRoll( math.random( 360, 480 ) * scale)
					particle:SetRollDelta( math.Rand( -1, 1 ) * scale)
					particle:SetColor( math.random( 150, 255 ), math.random( 100, 150 ), 100 )
					--particle:VelocityDecay( true )
					
				end
				
			end
			
			-- local fire = emitter:Add("effects/yellowflare", Pos )
			
			-- if( fire ) then 
			
				-- fire:SetVelocity(Vector(0,0,5))
				-- fire:SetDieTime(math.Rand(.03,.05)*25)
				-- fire:SetStartAlpha(math.Rand(15,25))
				-- fire:SetEndAlpha(0)
				-- fire:SetStartSize(4*math.random(5,6))
				-- fire:SetEndSize( 0 )
				-- fire:SetAirResistance(5)
				-- fire:SetRoll(math.Rand(-1,1))
				-- fire:SetRollDelta(math.Rand(-3,3))
				-- fire:SetColor(255,120,0)
				
			-- end 
			
	--smoke cloud
		for i=1, 7 do
		
		local particle = emitter:Add( "particles/smokey", Pos + VectorRand()*2)
			
			if( particle ) then
					
				particle:SetVelocity( Vector(math.random(-25,25),math.random(-25,25),math.random(55,200)) * scale )
				particle:SetDieTime( math.Rand( 2, 7 ) * scale )
				particle:SetStartAlpha( math.random( 5, 155 ) )
				particle:SetEndAlpha( math.random( 0, 1 ) * scale)
				particle:SetStartSize( math.random( 5,20 ) * scale )
				particle:SetEndSize( math.random( 60, 150 ) * scale)
				particle:SetRoll( math.random( 1, 480 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( 20, 20, 20 )
				--particle:VelocityDecay(false)
				
			end
			
		end
			
	emitter:Finish()
	
end

--THINK
-- Returning false makes the entity die
function EFFECT:Think( )
	-- Die instantly
	return false	
end

-- Draw the effect
function EFFECT:Render()
	-- Do nothing - this effect is only used to spawn the particles in Init	
end




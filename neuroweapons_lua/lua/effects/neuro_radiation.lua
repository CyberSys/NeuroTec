if SERVER then 
	AddCSLuaFile()
end 


function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	local Pos = self.Position		
	local Norm = Vector(0,0,1)
	
	Pos = Pos + Norm * 2
	
	local emitter = ParticleEmitter( Pos )

	for i=1, 2 do
			
		local particle = emitter:Add( "sprites/poison/rad"..math.random(1,2), Pos + VectorRand() * 4 )
			
		particle:SetVelocity( VectorRand() * 10  )
		particle:SetDieTime( math.Rand( 2.1, 5.1 ) )
		particle:SetStartAlpha( 55 )
		particle:SetStartSize( math.random( 4, 8 ) * .51  )
		particle:SetEndSize( math.random( 8, 16 ) *  .51 )
		particle:SetRoll( math.random( -1, 1 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		particle:SetColor( 33, 255, 5 )
		particle:SetGravity( VectorRand() * math.random(5,15) )
		
	end
	
	for i=1, 2 do
			
		local particle = emitter:Add( "particles/mat3", Pos + VectorRand() * 4 )
			
		particle:SetVelocity( VectorRand() * 10  )
		particle:SetDieTime( math.Rand( 0.1, 1) )
		particle:SetStartAlpha( math.random( 100, 200 ) )
		particle:SetStartSize( 0 )
		particle:SetEndSize( math.random( 32, 64 ) *  .1)
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		particle:SetColor( 5, 200+math.sin(CurTime())*50, 5 )
		particle:SetGravity( Vector(0,0,math.random(5,100) ) )
		
	end

	-- for i=1, 2 do
			
		-- local particle = emitter:Add( "sprites/poison/poison"..math.random(1,2), Pos + VectorRand() * 4 )
			
		-- particle:SetVelocity( VectorRand() * 10  )
		-- particle:SetDieTime( math.Rand( 0.1, 0.5 ) )
		-- particle:SetStartAlpha( math.random( 100, 200 ) )
		-- particle:SetStartSize( math.random( 4, 8 ) * .1 )
		-- particle:SetEndSize( math.random( 4, 8 ) * .51 )
		-- particle:SetRoll( math.random( -360, 360 ) )
		-- particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		-- particle:SetColor( 55, 200+math.sin(CurTime())*50, 5 )
		-- particle:SetGravity(VectorRand() * 16 )
		
	-- end
	
end

function EFFECT:Think( )

	return false	
end


function EFFECT:Render()
end




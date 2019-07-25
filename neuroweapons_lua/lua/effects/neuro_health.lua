if SERVER then 
	AddCSLuaFile()
end 


function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	local Pos = self.Position		
	local Norm = Vector(0,0,1)
	
	Pos = Pos + Norm * 2
	
	local emitter = ParticleEmitter( Pos )

	-- for i=1, 2 do
			
		local particle = emitter:Add( "sprites/poison/cross"..math.random(1,2), Pos + VectorRand() * 4 )
			
		particle:SetVelocity( VectorRand() * 10  )
		particle:SetDieTime( math.Rand( 2.1, 3.1 ) )
		particle:SetStartAlpha( 255 )
		particle:SetStartSize( math.random( 4, 8 ) * .1 )
		particle:SetEndSize( math.random( 32, 64 ) * .25 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		particle:SetColor( 255,255, 255 )
		particle:SetGravity( Vector(0,0,math.random(5,55) ) )
		
	-- end

end

function EFFECT:Think( )

	return false	
end


function EFFECT:Render()
end




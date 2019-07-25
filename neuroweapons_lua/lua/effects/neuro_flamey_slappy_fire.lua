if SERVER then 
	AddCSLuaFile()
end 


function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	local Pos = self.Position		
	local Norm = Vector(0,0,1)
	local scale = data:GetScale()
	Pos = Pos + Norm * 2
	
	local emitter = ParticleEmitter( Pos )
	if( !emitter ) then return end 
	
	for i=1, 2 do
			
		local particle = emitter:Add( "effects/fire_cloud1", Pos  )
			
		particle:SetVelocity( VectorRand() * 4  )
		particle:SetDieTime( math.Rand( 0.5, 0.55 ) )
		particle:SetStartAlpha( math.random( 100, 200 ) )
		particle:SetStartSize( ( scale * 1 ) + scale )
		particle:SetEndSize( math.random( 32, 64 ) * .25 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		particle:SetColor( 255,255,255 )
		particle:SetGravity( Vector(0,0,math.random(95,100)	 ) )
		
	end

	for i=1, 2 do
			
		local particle = emitter:Add( "particles/dirt", Pos  )
			
		particle:SetVelocity( VectorRand() * 10 )
		particle:SetDieTime( math.Rand( 2.1, 3.1 ) )
		particle:SetStartAlpha( math.random( 25, 255 ) )
		particle:SetStartSize( ( scale * math.random( 4, 8 ) ) * .1 )
		particle:SetEndSize( math.random( 32, 64 ) * .25 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		particle:SetColor( 5, 5, 5 )
		particle:SetGravity( Vector(math.random(-4,5),math.random(-4,5),math.random(5,55) ) )
		
	end
	
end

function EFFECT:Think( )

	return false	
end


function EFFECT:Render()
end




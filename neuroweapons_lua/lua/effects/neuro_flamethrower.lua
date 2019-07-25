if SERVER then 
	AddCSLuaFile()
end 


function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	local Pos = self.Position		
	local Norm =data:GetNormal()
	local ent = data:GetEntity()
		
	local dlight = DynamicLight( ent:EntIndex() )
	if ( dlight ) then

		local c = Color( 0,255,5, 255 )

		dlight.Pos = Pos
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = math.Rand( 0.25, 1 )
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = math.random(128,256)
		dlight.DieTime = CurTime() + 0.1

	end

	Pos = Pos + Norm * 2
	
	local emitter = ParticleEmitter( Pos )

	for i=1, 2 do
			
		local particle = emitter:Add( "sprites/poison/poison"..math.random(1,2), Pos+VectorRand()*2 )
			
		particle:SetVelocity( VectorRand() * 10 + Norm * 200 )
		particle:SetDieTime( math.Rand( 2.1, 3.1 ) )
		particle:SetStartAlpha( math.random( 100, 200 ) )
		particle:SetStartSize( math.random( 4, 8 ) * .1 )
		particle:SetEndSize( math.random( 8, 64 ) * .5 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		-- particle:SetColor( 255, 0, 191 )
		particle:SetColor( 5, 200+math.sin(CurTime())*50, 5 )
		particle:SetGravity(  VectorRand() * 25 )
		particle:SetAirResistance( 10 ) 
		
	end
	for i=1, 6 do
			
		local particle = emitter:Add( "sprites/poison/poison"..math.random(1,2), Pos )
			
		particle:SetVelocity( VectorRand() * 10 + Norm * math.random(100,200) )
		particle:SetDieTime( math.Rand( 2.1, 3.1 ) )
		particle:SetStartAlpha( math.random( 100, 200 ) )
		particle:SetStartSize( math.random( 4, 8 ) * .1 )
		particle:SetEndSize( 0 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		-- particle:SetColor( 255, 0, 191 )
		particle:SetColor( 5, 200+math.sin(CurTime())*50, 5 )
		particle:SetGravity( VectorRand() * 25 + Vector(0,0,math.random(100,150)) )
		particle:SetAirResistance( 10 ) 
		
	end
	
	for i=1, 2 do
			
		local particle = emitter:Add( "particles/dirt", Pos )
			
		particle:SetVelocity( VectorRand() * 10 + Norm * 200 )
		particle:SetDieTime( math.Rand( 2.1, 3.1 ) )
		particle:SetStartAlpha( math.random( 45, 100 ) )
		particle:SetStartSize( math.random( 4, 8 ) * .1 )
		particle:SetEndSize( math.random( 32, 64 ) * .5 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		-- particle:SetColor( 255, 0, 191  )
		particle:SetAirResistance( 10 )
		particle:SetColor( 5, 200+math.sin(CurTime())*50, 5 )
		particle:SetGravity(  VectorRand() * 25 )
		
	end
	
end

function EFFECT:Think( )

	return false	
end


function EFFECT:Render()
end




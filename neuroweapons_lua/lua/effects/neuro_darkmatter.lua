if SERVER then 
	AddCSLuaFile()
end 


function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()
	local Pos = self.Position		
	local Norm = Vector(0,0,1)
	local ent = data:GetEntity()
	-- print( ent )
	if( !IsValid( ent ) ) then return end 
	Pos = Pos + Norm * 2
	
	local emitter = ParticleEmitter( Pos )
	local Rad = 45
	local speed = .75
	local Positions = {
	Vector( math.sin(CurTime()*speed)*Rad,math.cos( CurTime()*speed)*Rad, math.sin( CurTime()*speed)*Rad ),
	Vector( math.cos(CurTime()*speed)*Rad,math.sin( CurTime()*speed)*Rad, -math.cos( CurTime()*speed)*-Rad ),
	Vector( math.cos(CurTime()*speed)*Rad,math.sin( CurTime()*speed)*Rad, math.sin( CurTime()*speed)*-Rad ),
	Vector( -math.cos(CurTime()*speed)*Rad,-math.sin( CurTime()*speed)*Rad, -math.cos( CurTime()*speed)*-Rad ),
	-- Vector( math.cos(CurTime()*speed)*Rad,math.sin( CurTime()*speed)*Rad, 0 ),
	Vector( 0,math.sin( CurTime()*speed)*Rad,  math.cos(CurTime()*speed)*Rad ),
	-- Vector( 0,math.cos( CurTime()*speed)*-Rad,  math.sin(CurTime()*speed)*-Rad ),
	
	
	}

	for i=1, #Positions do
			
		local newpos = Pos + Positions[i]
		
		-- local particle = emitter:Add( "particle/neuro_smoke", newpos )
		local particle = emitter:Add( "effects/fas_glow_debris", newpos )
			
		particle:SetVelocity( (  newpos - Pos ):GetNormalized() * -Rad/2 )
		particle:SetDieTime( 5 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( 0 )
		particle:SetEndSize( 8 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -1, 1 ) )
		particle:SetColor( 255, 0, 191 )
		particle:SetAirResistance( 5 )
		particle:SetColor( 255,255,255  )
		particle:SetGravity( Vector(0,0,0 ) )
		
	end

	for i=1, 1 do
			
		local particle = emitter:Add( "effects/fas_glow_debris", Pos )
			
		particle:SetVelocity( VectorRand() * 16  )
		particle:SetDieTime( 3 )
		particle:SetStartAlpha( 255 )
		particle:SetStartSize( 0 )
		particle:SetEndSize( 16 )
		particle:SetRoll( math.random( -360, 360 ) )
		particle:SetRollDelta( math.random( -0.6, 0.6 ) )
		particle:SetColor( 255,255,255)--100+math.sin(CurTime()*100)*150,100+math.cos(CurTime()*100)*150,100+math.sin(CurTime()*100)*150 )
		particle:SetGravity( Vector(0,0,0) )
		
	end

end

function EFFECT:Think( )

	return false	
end


function EFFECT:Render()
end




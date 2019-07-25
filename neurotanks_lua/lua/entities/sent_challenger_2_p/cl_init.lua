include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos , false )
	self.SpriteMat = CreateMaterial("tank_headlight_sprite","UnlitGeneric",{
										["$basetexture"] = "sprites/light_glow02",
										["$nocull"] = 1,
										["$additive"] = 1,
										["$vertexalpha"] = 1,
										["$vertexcolor"] = 1,
									})
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end

function ENT:Draw()

	
	self:DrawModel()
	
	local DrawHeadlightSprites = self:GetNetworkedBool("Tank_Headlights", false )
	
	if( DrawHeadlightSprites && self.HeadLights != nil ) then
		
		cam.Start3D(EyePos(),EyeAngles())
		
			render.SetMaterial( self.SpriteMat )
			
			for i=1,#self.HeadLights.Pos do
		
				render.DrawSprite( self:LocalToWorld( self.HeadLights.Pos[i] ), 16, 16, Color( 255, 255, 255, 105 ))
		
			end
			
		cam.End3D()
	
	end
	
	
	if( self:GetNetworkedBool("IsStarted", false ) ) then
		-- Exhaust	
		local pos = { Vector( -180, -77, 60 ), Vector( -180, 80, 63 ) }
		
		for i =1,2 do
		
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( pos[i] ) )

			if ( particle ) then
				
				particle:SetVelocity( Vector( math.Rand( -5,-5),math.Rand( -5,-5) ) )
				particle:SetDieTime( math.Rand( 1, 1 ) )
				particle:SetStartAlpha( math.Rand( 10, 10 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 15, 15 ) )
				particle:SetEndSize( math.Rand( 20, 20 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
				particle:SetAirResistance( 0 ) 
				particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(5, 15)) ) 	

			end
		end
	end
	
	self:DefaultDrawInfo()
	
end


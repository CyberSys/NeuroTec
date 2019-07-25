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

	local Pilot = self:GetNetworkedEntity("Pilot", NULL )
	return TankDefaultCalcView( Pilot, Origin, Angles, Fov, self )
	
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
		local pos = { Vector( -147, 18, 46 ), Vector( -147, -11, 46 ) }
		
		for i =1,2 do
		
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( pos[i] ) )
			local fatness = math.Clamp( self:GetVelocity():Length()/10, 0, 16 )
			if ( particle ) then
				
				particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 12.5,15.5)  ) )
				particle:SetDieTime( math.Rand( 2, 4 ) )
				particle:SetStartAlpha( math.Rand( 22, 33 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 6 + fatness, 12 + fatness ) )
				particle:SetEndSize( math.Rand( 18 + fatness, 22 + fatness ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
				particle:SetAirResistance( 100 ) 
				particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(70, 110)) ) 	

			end
			
		end
	
	end
	
	self:DefaultDrawInfo()
	
end


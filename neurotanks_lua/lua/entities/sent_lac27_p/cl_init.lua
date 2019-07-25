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
									
									
	local props = { 
	{ "models/killstr3aks/wot/american/propeller_body.mdl", Vector( -180, 155, 155 ) },
	{ "models/killstr3aks/wot/american/propeller_body.mdl", Vector( -180, -155, 155 ) }
	}
	
	self.Fans = {}
	self.Fins = {}
	for k,v in pairs( props ) do
		
		self.Fans[k] = ClientsideModel( v[1], RENDERGROUP_TRANSLUCENT  )
		self.Fans[k]:SetPos( self:LocalToWorld( v[2] ) )
		self.Fans[k]:SetAngles( self:GetAngles() )
		self.Fans[k]:SetParent( self )
		
		self.Fins[k] = ClientsideModel( "models/killstr3aks/wot/american/fin_body.mdl", RENDERGROUP_TRANSLUCENT  )
		self.Fins[k]:SetPos( self:LocalToWorld( v[2] + Vector( -130,0, -65  ) ) )
		self.Fins[k]:SetAngles( self:GetAngles() )
		self.Fins[k]:SetParent( self )
		-- self:DeleteOnRemove( self.Fans[k] )
		
	end
	
end

function ENT:OnRemove()

 for i=1,#self.Fans do
	
	self.Fans[i]:Remove()
	self.Fins[i]:Remove()
 
 end

end
function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end

function ENT:Draw()

	
	self:DrawModel()
	
	if( self:GetNetworkedBool("IsStarted", false ) ) then
		
		local rotval = math.Clamp( self:GetVelocity():Length() * 4, 25, 89 )
		
		for i=1,#self.Fans do
			
			local a = self.Fans[i]:GetAngles()
			a:RotateAroundAxis( self:GetForward(), rotval )
			self.Fans[i]:SetAngles( a )
			-- self.Fans[i]:DrawModel( )
			-- a:RotateAroundAxis( self:GetForward(), rotval )
			-- self.Fans[i]:SetAngles( a )
			
		end
		
	end
	
	
	
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
		local pos = Vector( 50, -57, 75 )
		
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( pos ) )

			if ( particle ) then
				
				--particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 2.5,15.5)  ) )
                particle:SetVelocity( self:GetForward() * 0 + self:GetRight() * 0 + self:GetUp() )
				particle:SetDieTime( math.Rand( 2, 4 ) )
				particle:SetStartAlpha( math.Rand( 10, 10 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 10, 15 ) )
				particle:SetEndSize( math.Rand( 8, 16 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
				particle:SetAirResistance( 100 ) 
				particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(70, 110)) ) 	

			end
	
	end
	
	self:DefaultDrawInfo()
	
end


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
local linearp = 0
function ENT:CalcView( ply, Origin, Angles, Fov )


	-- if( !IsValid( ent ) ) then return end
	-- print( type(ply),type(Origin),type(Angles),type(Fov), type( ent ) )
	-- if true then return false end
	
	local tank = ply:GetNetworkedEntity("Tank", NULL )
	local ent = tank
	local barrel = ply:GetNetworkedEntity("Barrel",NULL)
	local fov = GetConVarNumber("fov_desired")
	
	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then
		
	
		local ang,pAng,bAng = ply:GetAimVector():Angle(), tank:GetAngles(), barrel:GetAngles()
		
		local pos
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = tank:LocalToWorld( tank.CockpitPosition )
			ang = ang

			
		else
			
			linearp = Lerp( 0.21, linearp, math.floor( ent:GetVelocity():Length()/15 ) )
			-- print( linearp )
			local newpos = ent:GetPos() + ent:GetUp() * ent.CamUp + ply:GetAimVector() * -(ent.CamDist+linearp)
			
		
			local tr, trace = {},{}
			tr.start = ent:GetPos() + ent:GetUp() * 200
			tr.endpos = newpos
			tr.filter = { ent, ply, tank, barrel }
			tr.mask = MASK_WORLD
			trace = util.TraceLine( tr )
			
			local height = 50
			
			newpos = trace.HitPos + trace.HitNormal * 8
			
			if( newpos.z < ent:GetPos().z + height ) then newpos.z = ent:GetPos().z + height end
			
			pos = LerpVector( 0.83, Origin, newpos  )
		
		end

		local tAng = tank:GetAngles()
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, ang.r / 1.95 ),
			fov = fov
			}

	end

	return view

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
		local pos = { Vector( 26,13, 62 ), Vector( 26, 13,62 ) }
		

		for i=1,#pos do
		
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( pos[i] ) )

			if ( particle ) then
				
				local fatness = math.Clamp( self:GetVelocity():Length()/10, 0, 16 )
				
				--particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 2.5,15.5)  ) )
                particle:SetVelocity( self:GetForward() * 1 + self:GetRight() * 10 + self:GetUp() * 1 )
				particle:SetDieTime( math.Rand( 6, 8 ) )
				particle:SetStartAlpha( math.Rand( 20, 30 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 3+fatness, 5+fatness ) )
				particle:SetEndSize( math.Rand( 8+fatness, 16+fatness ) )
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


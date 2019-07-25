include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )
local matSprite 		= Material( "sprites/gmdm_pickups/light"  )

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 850
	self.CamUp = 130
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	local plane = ply:GetScriptedVehicle()

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( plane ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local pos
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = plane:LocalToWorld( Vector( 252, 0, 123 ) ) //Origin//
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		
		end

				local isGuidingRocket = plane:GetNetworkedBool( "DrawTracker", false )
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()

		if ( isGuidingRocket ) then

			pos = plane:GetPos() + plane:GetUp() * -150
			fov = 60
			
		end
		
		if ( ply:KeyDown( IN_ATTACK ) ) then
				
				ang.p = ang.p + math.Rand(-.6,.6)
				ang.y = ang.y + math.Rand(-.6,.6)
					
		end
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, pAng.r / 2.2 ),
			fov = fov
			}

	end

	return view

end

function ENT:Draw()

	local p = LocalPlayer()
	self:DrawModel()
	
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 512 ) then
			
			AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end

	local pos = {}
	pos[1] = self:GetPos() + self:GetForward() * -202 + self:GetRight() * -57 + self:GetUp() * 84
	pos[2] = self:GetPos() + self:GetForward() * -202 + self:GetRight() * 57 + self:GetUp() * 84
	
	for i = 1, 2 do
		
		self:DrawJetFlames( pos[i] )

	end

end

function ENT:DrawJetFlames( pos )

	local vOffset = pos + self:GetForward() * -1
	local vNormal = ( vOffset - pos ):GetNormalized()
	local scroll = CurTime() * -20
	local vel = self:GetVelocity():Length()
	local Scale = 1.0 + ( vel / 2500 )
	
	render.SetMaterial( matHeatWave )
	
	scroll = scroll * 0.9
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 16, scroll, Color( 0, 255, 255, 205 ) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 32, scroll + 0.01, Color( 255, 255, 255, 205 ) )
		render.AddBeam( vOffset + vNormal * 80 * Scale, 32, scroll + 0.02, Color( 0, 255, 255, 15 ) )
	render.EndBeam()

	scroll = scroll * 0.9
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 32, scroll, Color( 0, 255, 255, 255) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 32, scroll + 0.01, Color( 255, 255, 255, 255 ) )
		render.AddBeam( vOffset + vNormal * 80 * Scale, 32, scroll + 0.02, Color( 0, 255, 255, 0 ) )
	render.EndBeam()
	
	scroll = scroll * 0.6
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 32, scroll, Color( 0, 255, 255, 255) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 32, scroll + 0.01, Color( 255, 255, 255, 255 ) )
		render.AddBeam( vOffset + vNormal * 80 * Scale, 32, scroll + 0.02, Color( 0, 255, 255, 0 ) )
	render.EndBeam()

	scroll = scroll * 0.5
	render.UpdateRefractTexture()
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 16 * Scale, scroll, Color( 0, 0, 255, 128) )
		render.AddBeam( vOffset + vNormal * 32 * Scale, 32 * Scale, scroll + 2, Color( 255, 255, 255, 255 ) )
		render.AddBeam( vOffset + vNormal * 80 * Scale, 48 * Scale, scroll + 5, Color( 0, 0, 0, 0 ) )
	render.EndBeam()


	local extra = math.Clamp( vel / 500,0, 60 )
	render.SetMaterial( matSprite )
	render.DrawSprite( pos, 35 + extra, 35 + extra, Color( 25,25,255,105 ) )
end

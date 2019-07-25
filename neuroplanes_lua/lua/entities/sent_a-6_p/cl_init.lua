include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )
local matSprite 		= Material( "sprites/gmdm_pickups/light"  )

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 600
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
		local pilotmodel = ply:GetNetworkedEntity("NeuroPlanes_Pilotmodel", NULL )
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = plane:LocalToWorld( Vector( 83, 15, 117 ) ) //Origin//
			
			if( IsValid( pilotmodel ) ) then
				
				pilotmodel:SetColor( Color( 0,0,0,0 ) )
				pilotmodel:SetRenderMode( RENDERMODE_TRANSALPHA )
				
			end
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
			
			if( IsValid( pilotmodel ) ) then
				
				pilotmodel:SetColor( Color( 255,255,255,255 ) )
				
			end
			
		end

				local isGuidingRocket = plane:GetNetworkedBool( "DrawTracker", false )
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()

		if ( isGuidingRocket ) then

			pos = plane:GetPos() + plane:GetUp() * -150
			fov = 60
			
		end
		
		if ( ply:KeyDown( IN_ATTACK ) ) then
				
				ang.p = ang.p + math.Rand(-.5,.5)
				ang.y = ang.y + math.Rand(-.5,.5)
					
		end
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, pAng.r / 2.55 ),
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
	
	if ( p:GetNetworkedBool( "InFlight", false ) && p:GetNetworkedEntity( "Plane", p ) == self  ) then
	
		local pos = {}
		pos[1] = self:GetPos() + self:GetForward() * -121 + self:GetRight() * -40 + self:GetUp() * 70 
		pos[2] = self:GetPos() + self:GetForward() * -121 + self:GetRight() * 40 + self:GetUp() * 70 
		
		for i = 1, 2 do
			
			self:DrawJetFlames( pos[i] )
			//self:DrawExhaust( pos[i], pos[i] + self:GetForward() * -250, self:GetVelocity():Length(), self.Seed )
		end
		
	end
	
end

function ENT:DrawExhaust( pos, endpos, vel, seed )
	
	local amt = math.Clamp( vel / 32, 30, 255 ) 
	local dec = vel / 2000 // We use this variable to make the exhaust change size depending on throttle.
	local Scroll = CurTime() * -20
	Scroll = Scroll * 0.9
	
	for i=1,18 do

		pos.y = pos.y + math.sin( ( CurTime() - seed ) + i * 20 ) * 20
		pos.z = pos.z + math.cos( ( CurTime() - seed ) + i * 20 ) * 20
		
		endpos.y = endpos.y + math.sin( ( CurTime() - seed ) + i * 20 ) * 5
		endpos.z = endpos.z + math.cos( ( CurTime() - seed ) + i * 20 ) * 5
		
		// Flames
		render.SetMaterial( matFire )
		render.DrawBeam( pos, endpos, 8, Scroll, 0, Color( 255, 215, 35, amt ) )
		// Refract
		render.SetMaterial( matHeatWave )
		render.DrawBeam( pos, endpos, 6, Scroll, 0, Color( 255, 255, 255, 120 ) )
		
	end
	
end

function ENT:DrawJetFlames( pos )

	local vOffset = pos + self:GetForward() * -1
	local vNormal = ( vOffset - pos ):GetNormalized()
	local scroll = CurTime() * -20
	local Scale = 1.7
	
	render.SetMaterial( matHeatWave )
	
	scroll = scroll * 0.9
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 16, scroll, Color( 0, 255, 255, 205 ) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 32, scroll + 0.01, Color( 255, 255, 255, 205 ) )
		render.AddBeam( vOffset + vNormal * 128 * Scale, 32, scroll + 0.02, Color( 0, 255, 255, 15 ) )
	render.EndBeam()

	scroll = scroll * 0.9
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 32, scroll, Color( 0, 255, 255, 255) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 32, scroll + 0.01, Color( 255, 255, 255, 255 ) )
		render.AddBeam( vOffset + vNormal * 128 * Scale, 32, scroll + 0.02, Color( 0, 255, 255, 0 ) )
	render.EndBeam()
	
	scroll = scroll * 0.6
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 32, scroll, Color( 0, 255, 255, 255) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 32, scroll + 0.01, Color( 255, 255, 255, 255 ) )
		render.AddBeam( vOffset + vNormal * 128 * Scale, 32, scroll + 0.02, Color( 0, 255, 255, 0 ) )
	render.EndBeam()

	scroll = scroll * 0.5
	render.UpdateRefractTexture()
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 16 * Scale, scroll, Color( 0, 0, 255, 128) )
		render.AddBeam( vOffset + vNormal * 32 * Scale, 32 * Scale, scroll + 2, Color( 255, 255, 255, 255 ) )
		render.AddBeam( vOffset + vNormal * 128 * Scale, 48 * Scale, scroll + 5, Color( 0, 0, 0, 0 ) )
	render.EndBeam()
	

	local extra = math.Clamp( self:GetVelocity():Length() / 1000,0, 25 )
	render.SetMaterial( matSprite )
	render.DrawSprite( pos, 62 + extra, 62 + extra, Color( 255,120,0,165 ) )

end

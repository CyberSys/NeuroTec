include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )
local matSprite 		= Material( "sprites/gmdm_pickups/light"  )

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )
	
	local view = {
		origin = ply:GetPos(),
		angles = ply:EyeAngles()
		}
		
	if( GetConVarNumber("jet_cockpitview") == 0 ) then
	
		local plane = ply:GetScriptedVehicle()
		
		if( ply:GetNetworkedBool("InFlight", false ) && IsValid( plane ) ) then
		
			local pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
			local LG = self:GetNetworkedEntity( "NeuroPlanes_LaserGuided" )
			local fov = GetConVarNumber("fov_desired")
			local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()

			if ( IsValid( LG ) ) then
				
				pos = LG:GetPos() + LG:GetForward() * 105
				
			end
			
			if ( ply:KeyDown( IN_ATTACK ) ) then
					
				ang.p = ang.p + math.Rand(-.35,.35)
				ang.y = ang.y + math.Rand(-.35,.35)
					
			end
			
			view = {
				origin = pos,
				angles = Angle( ang.p, ang.y, pAng.r / 2.15 ),
				fov = fov
			}
			
		end
		
	end
	
	return view

end

function ENT:Draw()

	local p = LocalPlayer()
	if !p:GetNWBool( "ShowCockpit", false ) then
	self:DrawModel()
	end
	
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 512 ) then
			
			AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end

	for i= 1, #self.ReactorPos do
	self:DrawJetFlames( self:GetPos() + self:GetForward() * self.ReactorPos[i].x + self:GetRight() * -self.ReactorPos[i].y + self:GetUp() * self.ReactorPos[i].z )
	end
	
end

function ENT:DrawJetFlames( pos )

	local vOffset = pos + self:GetForward() * -1
	local vNormal = ( vOffset - pos ):GetNormalized()
	local Throttle = math.Clamp( self:GetVelocity():Length() / (1.8 * 965) + 0.01,0, 10 )
	local scroll = CurTime() * -20
	local Scale = 1.1 * Throttle*Throttle/10
	
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
	render.DrawSprite( pos, 60 + extra, 60 + extra, Color( 255,55,25,125 ) )

end
 

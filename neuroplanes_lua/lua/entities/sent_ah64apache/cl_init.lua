include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 850
	self.CamUp = 128

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
			
			pos = plane:LocalToWorld( Vector( 116, 0, -13 ) )
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
			
		end

		local GotChopperGunner = ply:GetNetworkedBool( "isGunner", false )
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()
		local myAng 
			
		if ( GotChopperGunner ) then
			
			pos = plane:GetPos() + plane:GetForward() * 129 + plane:GetUp() * -100
			fov = 60
			
			// hurr hackfix
			if ( ang.p < 15 || ang.p > 300 ) then ang.p = 15 end // Stupid glitch where the mouse responds faster than the lua engine.
			if ( ang.p > 89 && ang.p < 150 ) then ang.p = 89 end // stupid cl_pitchdown > 89(default) 
			// durr
			
			if ( ply:KeyDown( IN_ATTACK ) ) then
				
				ang.p = ang.p + math.Rand(-.5,.5)
				ang.y = ang.y + math.Rand(-.5,.5)
					
			end
			
			myAng = Angle( ang.p, ang.y, pAng.r / 1.0 )
		
		else
		
			myAng = Angle( ang.p, ang.y, pAng.r / 1.15 )
		
		end
		
		
		view = {
			origin = pos,
			angles = myAng,
			fov = fov
			}

	end

	return view

end

function ENT:Draw()

	local sequence = self:LookupSequence("idle")
	self:SetSequence( sequence )
	self:SetPlaybackRate( 1.0 )
	
	self:DrawModel()
	local p = LocalPlayer()
		
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 512 ) then
			
			AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end
	
	if ( p:GetNetworkedBool( "InFlight", false ) && p:GetNetworkedEntity( "Plane", p ) == self  ) then
	
		local pos = {}
		
	end
	
end

function ENT:DrawJetFlames( pos )
	
	local vOffset = pos + self:GetForward() * -1
	
	if ( self:GetVelocity():Length() < 600 ) then
		
		local x = self:GetVelocity():Length() / 1000
		vOffset = pos + self:GetUp() * ( -0.7 - x ) + self:GetForward() * ( -0.4 - ( x - 0.4 ) )
	
	end
	
	local vNormal = ( vOffset - pos ):GetNormalized()
	local scroll = CurTime() * -20
	local Scale = 1.3
	
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

end

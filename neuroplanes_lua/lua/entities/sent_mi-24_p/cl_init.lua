include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 1000
	self.CamUp = 250
	
	self.MinZoom = 10
	self.MaxZoom = 55
	self.ZoomLevel = self.MaxZoom
	self.ZoomVar = self.ZoomLevel
	self.LastZoom = 0
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	
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
				
			pos = plane:LocalToWorld( Vector( 192, 0, -1 ) )
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		
		end
		
		local gun = ply:GetNetworkedEntity( "ChopperGunnerEnt", NULL )
		local GotChopperGunner = ( ply:GetNetworkedBool( "isGunner", false ) && IsValid( gun ) )
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()
		local myAng 
		
		if ( GotChopperGunner ) then
			
			// hurr hackfix
			if ( ang.p < 4|| ang.p > 300 ) then ang.p = 4 end // Stupid glitch where the mouse responds faster than the lua engine.
			if ( ang.p > 89 && ang.p < 150 ) then ang.p = 89 end // stupid cl_pitchdown > 89(default) 
			// durr
			
			if ( ply:KeyDown( IN_ATTACK ) ) then
				
				self.LastZoom = CurTime()
				 
				local wat = ( self.MaxZoom / 100 ) - ( self.ZoomLevel / 100 )
				ang.p = ang.p + math.Rand( -.3 - wat, .3 + wat )
				ang.y = ang.y + math.Rand( -.3 - wat, .3 + wat )
		
			end
			
			if( ply:KeyDown( IN_ATTACK2 ) && self.LastZoom + 0.8 <= CurTime() ) then
				
				self.LastZoom = CurTime()
				
				if( self.ZoomLevel == self.MinZoom ) then
				
					self.ZoomLevel = self.MaxZoom
					
				elseif( self.ZoomLevel == self.MaxZoom ) then
				
					self.ZoomLevel = self.MinZoom
			
				end
				
			end
			
			self.ZoomVar = math.Approach( self.ZoomVar, self.ZoomLevel, 10 )
			pos = plane:GetPos() + plane:GetForward() * 352 + plane:GetUp() * -100
			fov = self.ZoomVar
			myAng = Angle( ang.p, ang.y, pAng.r / 1.45 )
		
		else
		
			myAng = Angle( ang.p, ang.y, pAng.r / 2.1 )
		
		end
		
		local LaserGuided = plane:GetNetworkedEntity("NeuroPlanes_LaserGuided", NULL )
		
		if( IsValid( LaserGuided ) ) then
			
			pos = LaserGuided:GetPos() + LaserGuided:GetForward() * 100
			myAng = LaserGuided:GetAngles()

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

	self:DrawModel()
	local p = LocalPlayer()
		
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 512 ) then
			
		AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end

	local pilot = self:GetNetworkedEntity( "Pilot", NULL )
	
	if( IsValid( pilot ) ) then
		
		self:DrawJetFlames( self:LocalToWorld( Vector( -157, 74, 7 ) ) )
		self:DrawJetFlames( self:LocalToWorld( Vector( -157, -74, 7 ) ) )
	
	end
	
end

function ENT:DrawJetFlames( pos )

	-- local particle = self.Emitter:Add("sprites/heatwave",pos)
	-- particle:SetDieTime( 0.3 )
	-- particle:SetStartAlpha( 255 )
	-- particle:SetEndAlpha( 255 )
	-- particle:SetStartSize( 50 )
	-- particle:SetEndSize( 25 )
	-- particle:SetColor( 255, 255, 255 )
	-- particle:SetCollide( false )
	-- particle:SetRoll( math.random(-1,1) )
	-- particle:SetGravity( Vector( math.sin(CurTime() - self:EntIndex() * 10 ) * 32, math.cos( CurTime() - self:EntIndex() * 10 ) * 32, math.random(-180,-100) ) )

	-- self.Emitter:Finish()

end

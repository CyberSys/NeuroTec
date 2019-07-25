include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 670
	self.CamUp = 80
	
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


		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()
		local myAng = Angle( ang.p, ang.y, pAng.r / 1.75 )
				
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = plane:LocalToWorld( Vector( 0, -36, 49 ) ) //Origin//
			myAng = pAng
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		
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
		
		self:DrawJetFlames( self:LocalToWorld( Vector( -13, 35, 36 ) ) )
	
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
	-- particle:SetGravity( Vector( math.sin(CurTime() - self:EntIndex() * 10 ) * 32,math.cos(CurTime() - self:EntIndex() * 10 ) * 32, math.random(-180,-100) ) )
	-- //particle:SetVelocity( self:GetVelocity() )
	-- //particle:SetAngleVelocity( self:GetAngleVelocity() )
	
	-- self.Emitter:Finish()

end

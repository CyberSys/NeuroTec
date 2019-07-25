include('shared.lua')

local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )

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
				
			pos = plane:LocalToWorld( self.CockpitPosition ) //Origin//
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		
		end
		
		local gun = ply:GetNetworkedEntity( "ChopperGunnerEnt", NULL )
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()
		local myAng = Angle( ang.p, ang.y, pAng.r / 1.75 )
		
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
	
	self:DefaultDrawInfo()
	
	local pilot = self:GetNetworkedEntity( "Pilot", NULL )
	
	if( IsValid( pilot ) ) then
		
		self:DrawJetFlames( self:LocalToWorld( Vector( -5, 83, 149 ) ) )
		self:DrawJetFlames( self:LocalToWorld( Vector( -5, -83, 149 ) ) )
	
	end
	
end

function ENT:DrawJetFlames( pos )

	-- local particle = self.Emitter:Add("sprites/heatwave",pos)
	
	-- if( particle ) then
		
		-- particle:SetDieTime( 0.3 )
		-- particle:SetStartAlpha( 255 )
		-- particle:SetEndAlpha( 255 )
		-- particle:SetStartSize( 50 )
		-- particle:SetEndSize( 25 )
		-- particle:SetColor( 255, 255, 255 )
		-- particle:SetCollide( false )
		-- particle:SetRoll( math.random(-1,1) )
		-- particle:SetGravity( Vector( math.sin(CurTime() - self:EntIndex() * 10 ) * 32,math.cos(CurTime() - self:EntIndex() * 10 ) * 32, math.random(-180,-100) ) )
		
	-- end
	
	-- self.Emitter:Finish()

end

include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.Mat = Material( self:GetMaterial() )
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	local tank = ply:GetNetworkedEntity("Tank", NULL )
	local barrel = ply:GetNetworkedEntity("Barrel",NULL)

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local fov = GetConVarNumber("fov_desired")
		local ang,pAng,bAng = ply:GetAimVector():Angle(), tank:GetAngles(), barrel:GetAngles()
		
		local pos
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = tank:LocalToWorld( self.CockpitPosition )
			ang = bAng
		
			if( ply:KeyDown( IN_WALK ) ) then
			
				fov = 25
		
			end
			
		
		else
			
			pos = LerpVector( 0.89, Origin, tank:GetPos() + tank:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist )
		
		end
		
		local tAng = tank:GetAngles()
		
		view = {
			origin = pos,
			angles = ang, --Angle( ang.p, ang.y, 0 ),
			fov = fov
			}

	end

	return view

end

function ENT:Draw()
	
	-- self.Mat:SetMaterialFloat( "texturescrollrate", math.sin(CurTime() ) )
	-- self:SetMaterial( self.Mat )
	
	local particle = self.Emitter:Add( "sprites/heatwave", self:LocalToWorld( self.ExhaustPosition ) + self:GetRight() * math.random( -16,16 ) )
	
	if( particle && self:GetNetworkedBool("IsStarted", false ) ) then
		
		particle:SetDieTime( 0.3 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 255 )
		particle:SetStartSize( 50 )
		particle:SetEndSize( 0 )
		particle:SetColor( 255, 255, 255 )
		particle:SetCollide( false )
		particle:SetRoll( math.random(-1,1) )
		particle:SetGravity( Vector( math.sin(CurTime() - self:EntIndex() * 10 ) * 32, math.cos( CurTime() - self:EntIndex() * 10 ) * 32, math.random(70,130) ) )
		particle:SetCollide( true )
		
	end
	
	self.Emitter:Finish()

	self:DefaultDrawInfo()
	
end

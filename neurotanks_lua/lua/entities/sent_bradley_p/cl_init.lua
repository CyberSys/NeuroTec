include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	-- self.Mat = Material( self:GetMaterial() )
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	self.LaserMat = Material( "cable/redlaser" )
	
end

function ENT:CalcView( ply, Origin, Angles, Fov, znear, zfar )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end

function ENT:Draw()
	
	-- self.Mat:SetMaterialFloat( "texturescrollrate", math.sin(CurTime() ) )
	-- self:SetMaterial( self.Mat )
	local TankATGMPod = self:GetNetworkedEntity("TankATGM", NULL )
	local ATGM = self:GetNetworkedEntity( "ATGMRocket", NULL )
	
	if( IsValid( TankATGMPod ) && IsValid( ATGM ) ) then
		
		local pos = TankATGMPod:LocalToWorld(  Vector( 28, -5, 12 ) )
		render.SetMaterial( self.LaserMat )	
		render.DrawBeam( pos, 		
						pos + TankATGMPod:GetForward() * 12500,
						8,					
						 0,					
						 0,				
						 Color( 0, 255, 0, 255 ) )
		
		
	end
	

	
	-- local particle = self.Emitter:Add( "sprites/heatwave", self:LocalToWorld( self.ExhaustPosition ) + self:GetRight() * math.random( -16,16 ) )
	
	-- if( particle && self:GetNetworkedBool("IsStarted", false ) ) then
		
		-- particle:SetDieTime( 0.3 )
		-- particle:SetStartAlpha( 255 )
		-- particle:SetEndAlpha( 255 )
		-- particle:SetStartSize( 50 )
		-- particle:SetEndSize( 0 )
		-- particle:SetColor( 255, 255, 255 )
		-- particle:SetCollide( false )
		-- particle:SetRoll( math.random(-1,1) )
		-- particle:SetGravity( Vector( math.sin(CurTime() - self:EntIndex() * 10 ) * 32, math.cos( CurTime() - self:EntIndex() * 10 ) * 32, math.random(70,130) ) )
		-- particle:SetCollide( true )
		
	-- end
	
	-- self.Emitter:Finish()

	self:DefaultDrawInfo()
	
end

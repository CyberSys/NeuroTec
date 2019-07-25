include('shared.lua')
ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 0, 5, 20 )
function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos , false )
	self.Seed = math.Rand( 0, 10000 )
	self.OnStart = self.OnStart or CurTime()
end
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
	
	
function ENT:Draw()

	-- print( "WallA" )
	local pipe = self:GetNetworkedEntity( "FartCannon", NULL )
	
	if( !IsValid( pipe ) ) then print("nope") return end
	local pos = pipe:GetPos() + pipe:GetForward() * -2 + pipe:GetUp() * 6

	-- local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos )

	if ( particle ) then
		
		local fatness = math.Clamp( self:GetVelocity():Length()/20, 0, 100 )
		
		--particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 2.5,15.5)  ) )
		particle:SetVelocity( -( self:GetVelocity() / 4 ) + VectorRand() * 25 + self:GetRight() * 70 )
		particle:SetDieTime( math.Rand( 4, 6 ) )
		particle:SetStartAlpha( math.Rand( 20, 30 ) + fatness )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand( 4 + fatness, 6 + fatness) )
		particle:SetEndSize( math.Rand( 18+ fatness, 36+ fatness ) )
		particle:SetRoll( math.Rand(0, 360) )
		particle:SetRollDelta( math.Rand(-1, 1) )
		particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
		particle:SetAirResistance( 100 ) 
		particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(70, 110)) ) 	

	end
	self:DefaultDrawInfo()
	
	if( self:GetVelocity():Length() < 800 ) then return end
	// Thanks garry :D
	local vOffset = pos + pipe:GetForward() *-1
	local vNormal = (vOffset - self:GetPos()):GetNormalized()

	local scroll = self.Seed + (CurTime() * -10)
	
	local Scale = math.Clamp( (CurTime() - self.OnStart) * 5, 0, 1 ) * 0.95
		
	render.SetMaterial( matFire )
	
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 8 * Scale, scroll, Color( 0, 0, 255, 128) )
		render.AddBeam( vOffset + vNormal * 60 * Scale, 16 * Scale, scroll + 1, Color( 255, 255, 255, 128) )
		render.AddBeam( vOffset + vNormal * 148 * Scale, 16 * Scale, scroll + 3, Color( 255, 255, 255, 0) )
	render.EndBeam()
	
	scroll = scroll * 0.5
	
	render.UpdateRefractTexture()
	render.SetMaterial( matHeatWave )
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 8 * Scale, scroll, Color( 0, 0, 255, 128) )
		render.AddBeam( vOffset + vNormal * 16 * Scale, 16 * Scale, scroll + 2, Color( 255, 255, 255, 255) )
		render.AddBeam( vOffset + vNormal * 42 * Scale, 24 * Scale, scroll + 5, Color( 0, 0, 0, 0) )
	render.EndBeam()
	
	
	scroll = scroll * 1.3
	render.SetMaterial( matFire )
	render.StartBeam( 3 )
		render.AddBeam( vOffset, 8 * Scale, scroll, Color( 0, 0, 255, 128) )
		render.AddBeam( vOffset + vNormal * 32 * Scale, 8 * Scale, scroll + 1, Color( 255, 255, 255, 128) )
		render.AddBeam( vOffset + vNormal * 42 * Scale, 8 * Scale, scroll + 3, Color( 255, 255, 255, 0) )
	render.EndBeam()
	
	return true 
	
end

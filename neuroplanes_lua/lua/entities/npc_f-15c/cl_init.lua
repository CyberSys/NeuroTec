include('shared.lua')
language.Add("npc_f-15c", "F-15C Eagle")
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local matPlasma			= Material( "effects/strider_muzzle" )

function ENT:Initialize()

	

end

function ENT:Draw()

	local p = LocalPlayer()
	self:DrawModel()
	
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 2048 ) then
			
		AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end

	local pos = {}
	pos[1] = self:GetPos() + self:GetForward() * -240 + self:GetRight() * -28 + self:GetUp() * 69
	pos[2] = self:GetPos() + self:GetForward() * -240 + self:GetRight() * 28 + self:GetUp() * 69	
	
	for i = 1, 2 do
		
		self:DrawJetFlames( pos[i] )
		
	end

	
end

function ENT:DrawJetFlames( pos )

	local vOffset = pos + self:GetForward() * -1
	local vNormal = ( vOffset - pos ):GetNormalized()
	local scroll = CurTime() * -20
	local Scale = 1.9
	
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
function ENT:Think()

end


include('shared.lua')
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )

function ENT:Initialize()
	
	self.Seed = math.Rand( 0, 10000 )
	self:SetColor( Color( 0,0,0,0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
end

function ENT:Draw()

	self.Entity:DrawModel()

end

function ENT:OnRemove()
	
	-- surface.PlaySound(  )
	
end


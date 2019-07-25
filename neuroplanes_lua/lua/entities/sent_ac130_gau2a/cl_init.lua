
include('shared.lua')
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
function ENT:Initialize()
	self.Seed = math.Rand( 0, 10000 )
end


function ENT:Draw()

	self:DrawModel()

end
function ENT:OnRemove()
end

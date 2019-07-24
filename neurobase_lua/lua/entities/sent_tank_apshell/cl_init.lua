include('shared.lua')
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )

function ENT:Initialize()

	self.Seed = math.Rand( 0, 10000 )
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	
end

function ENT:Draw()

	self:DrawModel()
	self.OnStart = self.OnStart or CurTime()
	--self:EffectDraw_Fire()
	
end

function ENT:OnRemove()

end

function ENT:EffectDraw_Fire()

	local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:GetPos() )
	
	if ( particle ) then
		
		particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 2.5,15.5)  ) )
		particle:SetDieTime( math.Rand( 3, 5 ) )
		particle:SetStartAlpha( math.Rand( 30, 50 ) )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand( 2, 4 ) )
		particle:SetEndSize( math.Rand( 6, 11 ) )
		particle:SetRoll( math.Rand(0, 360) )
		particle:SetRollDelta( math.Rand(-1, 1) )
		particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
		particle:SetAirResistance( 100 ) 
		particle:SetGravity( VectorRand():GetNormalized()*math.Rand(5, 11)+Vector(0,0,math.Rand(5, 7)) ) 	

	end
end
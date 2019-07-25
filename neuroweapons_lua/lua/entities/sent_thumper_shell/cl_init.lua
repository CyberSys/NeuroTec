ENT.Spawnable			= false
ENT.AdminSpawnable		= false

include('shared.lua')
language.Add("sent_thumper_shell", "Grenade" )
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )

function ENT:Initialize()

	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos, false  )
	self.Seed = math.Rand( 0, 10000 )
	
end

function ENT:OnRemove()

end

function ENT:Draw()

	self.Entity:DrawModel()
	self.OnStart = self.OnStart or CurTime()
	self:EffectDraw_Smoke()
	
end

function ENT:EffectDraw_Smoke()

	local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:GetPos() )
	
	if( self:GetVelocity():Length() > 50 ) then
		
		if ( particle ) then
			
			particle:SetVelocity( self:GetVelocity()/4 *-1 + Vector( math.Rand( -2.5,2.5),math.Rand( -2.5,2.5),math.Rand( 2.5,15.5)  ) )
			particle:SetDieTime( math.Rand( 0.5, 0.9 ) )
			particle:SetStartAlpha( math.Rand( 55, 75 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand( 1, 2 ) )
			particle:SetEndSize( math.Rand( 6, 9 ) )
			particle:SetRoll( math.Rand( 0, 360 ) )
			particle:SetRollDelta( math.Rand( -1, 1 ) )
			particle:SetColor( math.Rand( 35, 45 ), math.Rand( 25, 45 ), math.Rand( 25, 45 ) ) 
			particle:SetAirResistance( 100 ) 
			particle:SetGravity( VectorRand():GetNormalized()*math.Rand(-140, 140)+Vector(0,0,math.random(-15, 15)) ) 	

		end
	
	end
	
end

function ENT:Think()
end

function ENT:OnRestore()
end

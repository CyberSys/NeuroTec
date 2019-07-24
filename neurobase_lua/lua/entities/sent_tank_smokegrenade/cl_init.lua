
include('shared.lua')

function ENT:Initialize()

	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos , false )
	
end

function ENT:Draw()

	self:DrawModel()
			
	local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:GetPos() )

	if ( particle ) then
		
		particle:SetVelocity( self:GetForward() * -65 )
		particle:SetDieTime( math.Rand( 7, 12 ) )
		particle:SetStartAlpha( math.Rand( 25, 45 ) )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand( 13, 15 ) )
		particle:SetEndSize( math.Rand( 280, 300 ) )
		particle:SetRoll( math.Rand(0, 360) )
		particle:SetRollDelta( math.Rand(-1, 1) )
		particle:SetColor( math.Rand(135,145), math.Rand(135,145), math.Rand(135,145) ) 
		particle:SetAirResistance( 100 ) 
		particle:SetGravity( VectorRand():GetNormalized()*math.random(45, 111)+Vector(0,math.random(55,155),math.random(45, 76)) ) 	
		particle:SetCollide( false )
		

	end
	
end

function ENT:OnRemove()

end

function ENT:IsTranslucent()

	return true
	
end


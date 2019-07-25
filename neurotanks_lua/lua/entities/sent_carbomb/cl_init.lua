include('shared.lua')

function ENT:Initialize()

	local pos = self:GetPos()
	self.Emitter = ParticleEmitter( pos, false )
	
end


function ENT:Draw()

	self.Entity:DrawModel()
	local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( Vector( -105, 23, -10 ) ) )

	if ( particle && self:GetNetworkedBool("Started", false ) ) then
		
		particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 2.5,15.5)  ) )
		particle:SetDieTime( math.Rand( 4, 6 ) )
		particle:SetStartAlpha( math.Rand( 20, 30 ) )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand( 3, 5 ) )
		particle:SetEndSize( math.Rand( 8, 16 ) )
		particle:SetRoll( math.Rand(0, 360) )
		particle:SetRollDelta( math.Rand(-1, 1) )
		particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
		particle:SetAirResistance( 100 ) 
		particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(70, 110)) ) 	

	end
end

function ENT:OnRemove()
	
	surface.PlaySound( "weapons/mortar/mortar_explode2.wav" )
	

end

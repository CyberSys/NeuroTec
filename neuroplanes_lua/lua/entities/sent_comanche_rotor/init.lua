AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )


ENT.PhysgunDisabled  = true 
function ENT:Initialize()

	self:SetModel( "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_rotor.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.ImpactSound = CreateSound(self, "npc/manhack/grind5.wav")
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
	
	end
	

end

function ENT:PhysicsCollide( data, physobj )
	
	-- if true then return end
	
	if( data.HitEntity && data.HitEntity.Owner == self.Owner ) then return end
	
	if ( data.Speed > 350 && data.DeltaTime > 0.2 ) then 
		/*local fx
		
		if ( data.HitEntity:IsWorld() ) then
			
			fx = "ManhackSparks"
		
		else
			
			
		
		end */
		
		//print("Rotor Impact!")
		local e = EffectData()
		e:SetOrigin( data.HitPos )
		e:SetNormal( data.HitNormal + Vector( 0, 0, 4 ) )
		e:SetScale( 15 )
		util.Effect("ManhackSparks", e)
		self.ImpactSound:PlayEx( 1.0, math.random( 70, 100 ) )
	
	else
		
		self.ImpactSound:FadeOut( 0.25 )
	
	end
	
end

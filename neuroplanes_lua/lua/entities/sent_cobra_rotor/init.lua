AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
ENT.PhysgunDisabled  = true 
function ENT:Initialize()

	self:SetModel( "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_rotor.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	-- self.HealthVal = 1000
	
	self.ImpactSound = CreateSound(self, "npc/manhack/grind5.wav")
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
		
		self.PhysObj:EnableDrag( true )
		self.PhysObj:Wake()
	
	end
	

end

function ENT:Think()
	
	if( self.Destroyed ) then return end
	if( self.Owner && self.Owner.Destroyed ) then return end
	
	local chopper,axis = self:GetOwner(), NULL

	if( chopper && IsValid( chopper ) ) then
			
		if( self.isCounterCoaxialRotor ) then
			
			axis = chopper.bottomrotoraxis
			
			if( !IsValid( axis ) ) then
				
				chopper:HelicopterCrash()
				-- self:RotorTrash()
				
				-- self:Remove()
				
			end
				
				return
			
			end

		else
	
			axis = chopper.rotoraxis
			
			if( !IsValid( axis ) ) then
				
				-- self:RotorTrash()
				chopper:HelicopterCrash()
				
				-- self:Remove()
				
				return
				
			end

		-- end
			
		-- if( !self.isTouching ) then return end
		
		self.isTouching = false
		
	end 
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < .2 ) then return end
	
	if( self.Destroyed ) then return end
	if( self.Owner && self.Owner.Destroyed ) then return end
	
	if( data.HitEntity && data.HitEntity.Owner == self:GetOwner() ) then return end
	
	for i =1, 2 do
	
		local e = EffectData()
		e:SetOrigin( data.HitPos )
		e:SetNormal( data.HitNormal + Vector( math.random(-12,12), math.random(-12,12), 4 ) )
		e:SetScale( 20 )
		util.Effect("ManhackSparks", e)
		self.ImpactSound:PlayEx( 1.0, math.random( 100, 120 ) )

	end
	
	-- self:Neuro_DealDamage( DMG_aLWAYSGIB && DMG_SLASH && DMG_SONIC, math.random(50,100), data.HitPos, 16, false, nil )
	util.BlastDamage( self, self, data.HitPos, 32, 300 )
	
	if( data.HitEntity && 
	( data.HitEntity:IsWorld() || 
	( !data.HitEntity:IsNPC() && 
	  !data.HitEntity:IsPlayer() && 
	  !data.HitEntity:GetClass() == "prop_physics"  ) ) ) then
		
		self.isTouching = true
		
		if( chopper && IsValid( chopper ) ) then
			
			chopper.Speed = chopper.Speed / 1.25
			
		end
		
		self:SetVelocity( self:GetVelocity() * 0.7 )
		
	end
	
	-- self:NextThink( CurTime() + 0.8 )


	if ( data.Speed > 350 && data.DeltaTime > 0.2 ) then 
		
		
		--//print( "Rotor Impact Velocity: "..math.floor( data.Speed ) )
			
		local chopper = self:GetOwner()

		if( data.Speed > 4500 ) then
			
			-- self.Destroyed = true
		
			if( chopper && IsValid( chopper ) ) then
				
				-- if( chopper.Destroyed ) then
					
					-- return
					
				-- else
					
					-- chopper.Destroyed = true
					
				
				-- end
				
				self:EmitSound("ambient/explosions/explode_7.wav",511,137)
				
				-- print("boom")
				chopper:DeathFX()
				
				-- self:RotorTrash()
				
				-- self:Remove()
				
				return
				
			end
	
		end
		
	else
		
		self.ImpactSound:FadeOut( 0.25 )
	
	end
	
end



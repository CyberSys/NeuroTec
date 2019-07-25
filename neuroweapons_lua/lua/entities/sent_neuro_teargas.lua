AddCSLuaFile()
ENT.Type 			= "anim"
ENT.PrintName		= "Tear Gas Grenade"
ENT.Author			= "Hoffa"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false 
ENT.AdminOnly 			= true 

ENT.Sound = Sound( "ambient/fire/gascan_ignite1.wav" )
ENT.Model = "models/weapons/w_eq_smokegrenade_thrown.mdl"


if SERVER then 


	function ENT:Initialize()

		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )	
		self:SetSolid( SOLID_VPHYSICS )
		self:SetModel(self.Model)
		self.PhysObj = self:GetPhysicsObject()
		self.IncrementalSize = 0 
		self.LastIncrement = 0 
		
		if( self.PhysObj:IsValid() ) then
		
			self.PhysObj:Wake()
			
		end
		
		self:EmitSound("weapons/smokegrenade/sg_explode.wav", 511, 100 )
		
	end

	function ENT:Use( activator, caller )

	end
		
	function ENT:OnTakeDamage( d ) end 
	
	function ENT:Think()
		
		if( !IsValid( self.Owner ) ) then return end 
		
		if( self.LastIncrement + 1 <= CurTime() ) then 
			
			self.LastIncrement = CurTime()
			self.IncrementalSize = math.Approach( self.IncrementalSize, 720, 128  )
			-- print( self.IncrementalSize )
		
			
			-- for k,v in pairs( ents.FindInSphere( self:GetPos(), self.IncrementalSize  ) ) do 
				
				-- Neuro_DealDamage( Type, Damage, Pos, Radius, DoEffect, Effect )
	
		
			self.Owner:Neuro_DealDamage( DMG_POISON, 4, self:GetPos() + Vector(0,0,32), self.IncrementalSize, false, "" )
				
			-- end 
		end 
	
	end

	function ENT:OnRemove()

	end


end 

if CLIENT then 

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
			particle:SetStartAlpha( math.Rand( 45, 55 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand( 13, 15 ) )
			particle:SetEndSize( math.Rand( 280, 300 ) )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetColor( 235, 235, 255 ) 
			particle:SetAirResistance( 100 ) 
			particle:SetGravity( VectorRand():GetNormalized()*math.random(45, 111)+Vector(0,math.random(55,155),math.random(45, 55)) ) 	
			particle:SetCollide( false )
			

		end
		
	end

	function ENT:OnRemove()

	end

	-- function ENT:IsTranslucent()

		-- return true
		
	-- end

end 

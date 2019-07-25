ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Ba 349 Launch Ramp"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 500				

ENT.Model 			= "models/hoffa/neuroplanes/german/natter/natter_ramp.mdl"

if( SERVER ) then

	AddCSLuaFile(  )
	
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  tr.HitPos + tr.HitNormal * 1
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()

		return ent
	end
	
	function ENT:Initialize()
	
		self:SetModel( self.Model )	
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:GetPhysicsObject():SetMass( 99999999999 )
		self.HealthVal = self.InitialHealth 
		self:CreateBachem()
		constraint.Weld( self, game.GetWorld(), 0, 0, 0, true )
		self.LastUse = 0 
	
	end
	
	function ENT:Use( ply, act, what, lol )
		
		if( IsValid( self.Bachem ) && IsValid( self.BachemWeld ) && self.LastUse + 5.0 <= CurTime() ) then
			
					
			-- ParticleEffectAttach( "scud_launch", PATTACH_ABSORIGIN_FOLLOW, self.Bachem, 0 )
	
			self.LastUse = CurTime()
			self.Bachem:Use( ply, self, 0, 0 )

			self.Bachem:Micro_ToggleEngine()
			self.Boosting = true 
			self.StartBoost = CurTime()
			-- self.Bachem:GetPhysicsObject():ApplyForceCenter( Vector(0,0,5000000000 ) )
			-- self.Bachem.Tail:GetPhysicsObject():ApplyForceCenter( Vector(0,0,5000000000 ) )
			self.Bachem.BoostValue = GLOBAL_FORCE_MULTIPLIER * self.Bachem.MaxVelocity * .1
	
		end 
	
	end  
	
	function ENT:Think()
	
		if( IsValid( self.Bachem ) && self.Boosting && self.StartBoost + 1 <= CurTime() && IsValid(self.BachemWeld ) ) then 
			
			self.BachemWeld:Remove()
			self.BachemWeld2:Remove()
				
			ParticleEffect(  "scud_launch", self.Bachem.Rudders[1]:GetPos() ,Angle(0,0,0), self )
	
		end 
		
		if( !IsValid( self.Bachem ) ) then 
			
			self:CreateBachem()
		
		end 
		
	end

	
	function ENT:CreateBachem()
		
		if( !IsValid( self.Bachem ) ) then 
			self.Boosting = false
			self.Bachem = ents.Create("sent_mini_natter_p")
			self.Bachem:SetPos( self:LocalToWorld( Vector( 13,65, 70 ) ) )
			self.Bachem:SetAngles( self:GetAngles() + Angle( -90, -90, 0 ) )
			self.Bachem:Spawn()
			self.Bachem.Ramp = self 
			self.Bachem.RampLaunched = true 
			self.Bachem:Activate()
			self.Bachem:SetOwner( self )
			self:DeleteOnRemove( self.Bachem )
			-- self.Bachem:GetPhysicsObject():leep()
			-- self.Bachem:SetMoveType( MOVETYPE_NONE )
			timer.Simple( 0.1, function()
				if( IsValid( self ) && IsValid( self.Bachem ) ) then
				
					self.BachemWeld = constraint.Weld( self, self.Bachem, 0, 0, 0, true )
					self.BachemWeld2 = constraint.Weld( self, self.Bachem.Tail, 0, 0, 0, true )
					
				end 
				
			end )
				
		end 
	
	end 
	
	function ENT:OnTakeDamage(dmginfo) 
		
		if( self.Destroyed ) then return end 
		
		local dmg = dmginfo:GetDamage()
		self.HealthVal = self.HealthVal - dmg 
	
		if( self.HealthVal <= 0 ) then
			
			self.Destroyed = true 
			
			self:PlayWorldSound("explosion"..math.random(3,5))
			
			ParticleEffect( "microplane_bomber_explosion", self:GetPos(), Angle( 0,0,0 ), nil )
			util.BlastDamage( self, self, self:GetPos(), 256, 256 )
			
			self:Remove()
			
			return
		
		end 
		
	
	end
	
	
	function ENT:OnRemove() 

		-- self.Roar:Stop()
		
	end
	

end

if( CLIENT ) then 

	function ENT:Initialize() 
	
	end
	
	function ENT:Draw() 
	
		self:DrawModel() 
		
	end
	
end

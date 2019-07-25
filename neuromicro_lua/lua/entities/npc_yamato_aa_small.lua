ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Yamato AA Turret"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Weapons";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.Country = "Japan"
-- ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 500				

ENT.Model 			= "models/props_junk/garbage_metalcan002a.mdl"


if( SERVER ) then

	AddCSLuaFile(  )
	
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  tr.HitPos + tr.HitNormal * 16
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
		self:SetNoDraw( true )
		self.Turret = ents.Create("prop_physics_override")
		self.Turret:SetModel( "models/neuronaval/starchick971/Battleships/yamato_turretgun.mdl" )
		self.Turret:SetPos( self:LocalToWorld( Vector( 0, 0, 2 ) ) )
		self.Turret:SetAngles(self:GetAngles() ) 
		self.Turret:PhysicsInit( SOLID_NONE )
		self.Turret:SetSolid( SOLID_NONE )
		self.Turret:SetMoveType( MOVETYPE_NONE )
		self.Turret:SetParent( self )
		self.Turret.Owner = self 
		
		self.Barrel = ents.Create("prop_physics_override")
		self.Barrel:SetModel("models/neuronaval/starchick971/Battleships/yamato_turretgun_cannon.mdl")
		self.Barrel:SetPos( self.Turret:LocalToWorld( Vector( 1.1, 0, 2.0 ) ) )
		self.Barrel:SetAngles(self:GetAngles() ) 
		self.Barrel:PhysicsInit( SOLID_NONE )
		self.Barrel:SetSolid( SOLID_NONE )
		self.Barrel:SetMoveType( MOVETYPE_NONE )
		self.Barrel:SetParent( self.Turret )
		self.Barrel.Owner = self 
		
		self.Roar = CreateSound( self, "micro/gau8_test.wav" )
		self.RoarEnd = "micro/gau8_end_test.wav"
		
		self.HealthVal = self.InitialHealth 
		self.LastPing = CurTime() 

		self:GetPhysicsObject():Wake()
		
	end

	function ENT:OnTakeDamage(dmginfo) 
		
		if( self.Destroyed ) then return end 
		
		local dmg = dmginfo:GetDamage()
		self.HealthVal = self.HealthVal - dmg 
			
		local edata = EffectData()
		edata:SetEntity(self)
		edata:SetMagnitude(10)
		edata:SetScale(10)
		util.Effect("microplane_damage", edata)

		
		if( self.HealthVal <= 0 ) then
			
			self.Destroyed = true 
			
			self:PlayWorldSound("explosion"..math.random(3,5))
			
			-- ParticleEffect( "microplane_explosion", self:GetPos(), Angle( 0,0,0 ), nil )
			-- util.BlastDamage( self, self, self:GetPos(), 256, 256 )
			
			self:Remove()
			
			return
		
		end 
		
	
	end
	
	
	function ENT:OnRemove() 

		self.Roar:Stop()
		
	end
	
	function ENT:ShootMeanCannon()
		
		if( !IsValid( self ) ) then return end 
		-- local bullet = ents.Create("sent_mini_shell")
		local bullet = {} 
		bullet.Num 		= 1 
		bullet.Src 		= self.Barrel:GetPos() + self.Barrel:GetForward() * 250
		bullet.Dir 		= self.Barrel:GetAngles():Forward()
		bullet.Spread 	= Vector( .15,.15, .15  ) * math.Rand( -.45,.55 )
		bullet.Tracer	= 1
		bullet.Force	= 500
		bullet.Damage	= 0
		bullet.AmmoType = "Ar2" 
		bullet.TracerName 	= "tracer"
		bullet.Attacker = self.Owner.Pilot 
		bullet.Callback    = function (a,b,c) 
			
			if( b.HitSky ) then return end 
			local fx = EffectData()
			fx:SetOrigin( b.HitPos )
			fx:SetScale( .2 )
			fx:SetNormal( b.HitNormal )
			
			if( IsValid( b.HitEntity ) && b.HitEntity != game.GetWorld() ) then 
			
				util.Effect("micro_he_impact_plane", fx )
			
			else
			
				util.Effect("micro_he_impact", fx )
			
			end 
			
			util.BlastDamage( self, self, b.HitPos + b.HitNormal, 36, math.random( 2, 3 ) )
			
		end 
		
		self.Barrel:FireBullets( bullet )
		-- ParticleEffectAttach( "mg_muzzleflash", PATTACH_ABSORIGIN_FOLLOW, self.Barrel, 0 )
		ParticleEffect( "microplane_MG_muzzleflash", self.Barrel:GetPos() + self.Barrel:GetForward() * 15, self.Barrel:GetAngles(), nil )
	end 
	
	function ENT:Think() 
		
		self:GetPhysicsObject():Wake()
		
		if( IsValid( self.Owner ) && IsValid( self.Owner.Target ) ) then 
			
			self.Target = self.Owner.Target 
		
		end 
		
		if( IsValid( self.Target ) ) then 
			
			-- Have a target
			
			local dist = ( self:GetPos() - self.Target:GetPos() ):Length()
			
			if( dist > 5500 ) then 
			
				self.Target = NULL 
				self.LastHadTarget = CurTime()
				
				return
				
			end 
			-- print(inLOS( self.Target, self) )
			if( !neuro_inLOS( self.Target, self ) || self.Target:GetPos().z <= self:GetPos().z +150) then 
				
				self.Target = NULL
				self.LastHadTarget = CurTime()
				
				return 
				
			end
			
			if( IsValid( self.Owner ) && self.Target == self.Owner.Pilot ) then self.Target = NULL return end 
			-- print(self.Target )
			-- print( self.Owner.Pilot, self.Target:GetClass() )
			if( self.Target:GetVelocity():Length() < 400 ) then 
				
				self.Target = NULL 
				return 
				
			end 
			
			local ma = self.Turret:GetAngles()
			local ta = (  ( self.Target:GetPos() + self.Target:GetVelocity() * .5 ) - self:GetPos()  ):Angle()
			local diff = math.AngleDifference( ta.y, ma.y )
			-- print( diff:Length() )
			-- print( diff )
		
			local tr,trace = {},{}
			tr.start = self.Barrel:GetPos() + self.Barrel:GetForward() * 45 
			tr.endpos = tr.start + self.Barrel:GetForward() * 500
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr ) 
					
			if( diff > -10 && diff < 10 && !trace.Hit ) then
			
				-- self.LastShoot = CurTime()
				-- self.Roar:Play()
				self:EmitSound("Cannons/AA_shot_"..math.random(1,3)..".wav")
				-- for i=1,2 do 
						
					-- timer.Simple( math.random(2,4)/i, function() 
						
						if( IsValid( self ) ) then 
						
							self:ShootMeanCannon()
						
						end 
						
					-- end )
					
					
				-- end 
				
			else
				
				-- if( self.LastShoot && self.LastShoot + .1 >= CurTime() ) then 
				
					-- self.Roar:FadeOut( 1 )
					-- self:EmitSound( self.RoarEnd, 511, 100 )
				
				-- end 
				
				
			end 
		
		
		end 
	
	
	end
	function ENT:PhysicsUpdate()
		
		if( IsValid( self.Target ) ) then 

		
			local targetAngle = ( self.Target:GetPos() - self:GetPos()  ):Angle()
			local adiff = math.AngleDifference( targetAngle.y, self:GetAngles().y )
			local angg = self:GetAngles()
			angg:RotateAroundAxis( self:GetUp(), adiff )
			self.Turret:SetAngles( LerpAngle( 0.99, self.Turret:GetAngles(), angg) )
			-- targetAngle:RotateAroundAxis( self:GetUp(), 180 )
			targetAngle = ( self:GetPos() - self.Target:GetPos() ):Angle()
			self.Barrel:SetAngles(  Angle( Lerp( 0.9, self.Barrel:GetAngles().p, -targetAngle.p ), self.Turret:GetAngles().y, self.Turret:GetAngles().r ) )
		
		end 
	
	end 
	
end

if( CLIENT ) then 

	function ENT:Initialize() 
	
	end
	
	function ENT:Draw() 

		self:DrawModel() 
		
	end
	
end

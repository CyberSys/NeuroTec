ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= ""
ENT.Author	= "Hoffa"
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.InitialHealth = 25				
ENT.PhysgunDisabled  = true 
ENT.Model 			= "models/starchick971/hawx/weapons/bgm-109 tomahawk.mdl"

if( SERVER ) then

	AddCSLuaFile(  )

	function ENT:Initialize()
		
		self.Destroyed = false 
	
		-- print("???")
		self:SetModel( self.Model )	
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
	
		self.HealthVal = self.InitialHealth 
		self.StartingTime = CurTime() 
		self.Speed = 0 
		
		local a = self:GetAngles() 
		a.p = -90 
		self:SetAngles( a )
		
		self:GetPhysicsObject():Wake()
		self.Radius = self.Radius or 128 
		
	end
	
	function ENT:NeuroMissile_Detonate()
			
		self.Destroyed = true 
		
		self:PlayWorldSound("explosion"..math.random(3,5)..".wav")
		
		local fx = "rt_impact_tank"
		if( self:WaterLevel() > 0 ) then 
			
			if( math.random(1,3) == 2 ) then 
			
				fx = "water_impact_big"
		
				
			
			end 
			
		end 
		self:PlayWorldSound(  "wt/misc/bomb_explosion_"..math.random(1,6)..".wav" )
		ParticleEffect( fx, self:GetPos(), Angle( 0,0,0 ), nil )
		util.BlastDamage( self, self.Owner, self:GetPos() + self:GetForward() * 2*self.PenetrationDepth, math.Clamp(  self.Radius or 128, 0, 512 ), math.random(self.MinDamage,self.MaxDamage) )
		debugoverlay.Sphere(  self:GetPos() + self:GetUp() * 10 + self:GetForward() * self.PenetrationDepth , self.Radius, 30.1,Color(0,255,0,255 ), true )
		-- print( math.random( self.MinDamage, self.MaxDamage ) )
		
		self:Remove()
			
	end
	
	function ENT:PhysicsCollide( data )
	
		if( data.Speed > 150 && data.DeltaTime > .2 && data.HitEntity != self.Owner && data.HitEntity.Owner != self.Owner ) then 
		
			self:NeuroMissile_Detonate()
			
			return 
			
		end 
		
	end
	
	function ENT:OnTakeDamage(dmginfo) 
		
		if( self.Destroyed ) then return end 
		
		local dmg = dmginfo:GetDamage()
		self.HealthVal = self.HealthVal - dmg 
		local atk = dmginfo:GetAttacker()
		self:SetNWInt( "health" , math.floor(self.HealthVal) )
	
		if( atk:IsPlayer() && dmg > 25 ) then
		
			atk:SendLua("HitMarker("..math.floor(dmg)..")")
			
		end
		ParticleEffect( "microplane_damage",dmginfo:GetDamagePosition(), Angle(0,0,0), nil )
		
		if( self.HealthVal <= 0 ) then
			
			self:NeuroMissile_Detonate()
			
			return
		
		end 
		
	
	end

	function ENT:OnRemove() 

		
	end

	
	function ENT:Think() 
		
		if( IsValid( self.Target ) ) then 
			
			self.ImpactPos = self.TargetPos 
			
		end 
		
		if( self:WaterLevel() > 0 ) then 
		
			self:NeuroMissile_Detonate()
			
			return 
		
		end 
		
		
	end
	
	function ENT:PhysicsUpdate()
		
		if(!self.ImpactPos ) then self.ImpactPos = self:GetPos() + self:GetForward() * 9999999 end 
		
		self.Speed = math.Approach( self.Speed, 5500, 100 )
		local dir =  (  self.ImpactPos - self:GetPos()  ):GetNormalized()
		
		if( self.StartingTime + 2.7 >= CurTime() && self.StartingTime + 2.0 <= CurTime() ) then 
			
			self:GetPhysicsObject():AddAngleVelocity( Vector( 0,2.5,0) )

			self:GetPhysicsObject():ApplyForceCenter( Vector( 0,0,self.Speed * .05 )  )
			self:SetNWBool("FireAdjustmentThruster", true )
			
			if( !self.AdjustSound ) then 
				
				self.AdjustSound = true
				self:EmitSound("npc/dog/dog_pneumatic2.wav", 511, 50  )
				
			end 
			
		end 
		if( self.StartingTime + 2 >= CurTime() ) then 
			
			local a = ( self.ImpactPos - self:GetPos() ):Angle() 
			a.p = -90 
			-- a.r = 0 
			self:SetAngles( a ) 
			-- self:SetVelocity( self.Owner:GetVelocity() )
			self:GetPhysicsObject():ApplyForceCenter( Vector( 0,0,self.Speed) )
	
		else 
			
			if( self.StartingTime + 3 <= CurTime() ) then 
				
				if( !self.Ignited ) then 
					self.Ignited = true 
					self:SetNWBool("Ignited",true)
					local p = self:GetPos() + self:GetForward() * -15
					local TraceScale1 = self.TracerScale1 or .15
					local TraceScale2 = self.TracerScale2 or .15
					local GlowProxy = self.TracerGlowProxy or .15
					local Glow = ents.Create("env_sprite")				
					Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
					Glow:SetKeyValue("rendercolor","255 150 100")
					Glow:SetKeyValue("scale",tostring(TraceScale1))
					Glow:SetPos( p )
					Glow:SetParent(self)
					Glow:Spawn()
					Glow:Activate()
				
					local Shine = ents.Create("env_sprite")
					Shine:SetPos( p )
					Shine:SetKeyValue("renderfx", "0")
					Shine:SetKeyValue("rendermode", "5")
					Shine:SetKeyValue("renderamt", "255")
					Shine:SetKeyValue("rendercolor", "255 130 100")
					Shine:SetKeyValue("framerate12", "20")
					Shine:SetKeyValue("model", "light_glow01.spr")
					Shine:SetKeyValue("scale", tostring( TraceScale2 ) )
					Shine:SetKeyValue("GlowProxySize", tostring( GlowProxy ))
					Shine:SetParent(self)
					Shine:Spawn()
					Shine:Activate()
					
				end 
				
				local dist = ( self:GetPos() - self.ImpactPos )
				local _2d = dist:Length2D()
				local _3d = dist:Length() 
				local pos = self.ImpactPos 
				if( _3d < 45 ) then 
				
					self:NeuroMissile_Detonate()
					
					return 
					
				end 
				-- print( dist )
				local upval = 5220
				if( _2d > upval ) then 
					
					pos = pos + Vector(0,0,upval)
				
				else 
				
					pos = pos + Vector(0,0,upval * _2d/upval )
					
				end 
				local tpos = (pos - self:GetPos()  ):Angle()
				-- tpos.p = 0
				-- print( tpos )
				self:GetPhysicsObject():SetVelocity( self:GetForward() * self.Speed * .15 ) 
				
				if( !self.BoosterSound ) then 
					
					self.BoosterSound = true 
					
					self:EmitSound("bf4/rockets/missile_launch.wav",511,100 )
				
				end 
				local ma = self:GetAngles()
				-- ma.r = 0 
				
				-- tpos.y = tpos.y+math.sin(CurTime())
				
				-- if( dist > 3000 ) then 
				
					-- self:SetAngles( LerpAngle( .1, self:GetAngles(), (  ( self.ImpactPos + Vector( 0,0,dist/4 ) ) - self:GetPos()):Angle() ) )
				
				-- else
			
					self:SetAngles( LerpAngle( .085, ma, tpos ) )
					self:GetPhysicsObject():ApplyForceCenter( VectorRand() * math.sin(CurTime() ) )
				-- end 
				
				-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.Speed )
				
			end 
		
		
		end 
	
	end 
	
end

if( CLIENT ) then 

	local matHeatWave		= Material( "sprites/heatwave" )
	local matFire			= Material( "effects/fire_cloud1" )
	local emitter = ParticleEmitter(Vector(0, 0, 0))

	local scale = Vector(0.3, 0.3, 0.3 )
	
	function ENT:Initialize()
		
		local mat = Matrix()
		mat:Scale(scale)
		self:EnableMatrix("RenderMultiply", mat )

		local pos = self:GetPos() + self:GetForward() * dist
		self.Emitter = ParticleEmitter( pos, false )
		self.Seed = math.Rand( 0, 10000 )
		self.LaunchTime = CurTime() 
		-- self.StartPos = self:GetPos() 
		
	end 
	
	function ENT:Draw() 
	
		local dist = -15 
		local scale = .7 
		local fade = math.random(5,15) 
		self:DrawModel() 
		
		if( self:GetNWBool("FireAdjustmentThruster" ) ) then 
		
			if( !self.Adjusted ) then 
				
				self.Adjusted = true 
				self.AdjustTime = CurTime() 
				
			end 
			
			
		
		end 
	
		if( self.Adjusted && self.AdjustTime + 0.8 >= CurTime() ) then 
		
			local smoke = emitter:Add("effects/smoke_b", self:GetPos() + self:GetForward()*dist/2)
			smoke:SetVelocity(self:GetUp()*-800)
			smoke:SetDieTime(math.Rand(.1,.12))
			smoke:SetStartAlpha(math.Rand(175,255))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(3,5))
			smoke:SetEndSize(math.random(16,22))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor(255, 255, 255)
			smoke:SetAirResistance(601)
			
			local smoke = emitter:Add("effects/smoke_b", self:GetPos() + self:GetForward()*-dist/2)
			smoke:SetVelocity(self:GetUp()*800)
			smoke:SetDieTime(math.Rand(.1,.12))
			smoke:SetStartAlpha(math.Rand(175,255))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(3,5))
			smoke:SetEndSize(math.random(16,22))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor(255, 255, 255)
			smoke:SetAirResistance(601)
		
			
		end 

		if( self:GetNWBool("Ignited") ) then
			
			-- if( !self.LastCorrectionalPuff ) then 
				
				-- self.LastCorrectionalPuff = true 
				-- for i=1,5 do 
					-- timer.Simple( i/10, function() 
					
						-- if( !IsValid( self ) ) then return end 
						-- local smoke = emitter:Add("effects/smoke_b", self:GetPos() + self:GetForward()*-dist)
						-- smoke:SetVelocity(self:GetUp()*-1800)
						-- smoke:SetDieTime(math.Rand(.1,.12))
						-- smoke:SetStartAlpha(math.Rand(175,255))
						-- smoke:SetEndAlpha(0)
						-- smoke:SetStartSize(math.random(3,5)*scale)
						-- smoke:SetEndSize(math.random(16,22)*scale)
						-- smoke:SetRoll(math.Rand(180,480))
						-- smoke:SetRollDelta(math.Rand(-2,2))
						-- smoke:SetGravity( Vector( 0, math.random(1,90), -math.random(251,155) ) )
						-- smoke:SetColor(255, 255, 255)
						-- smoke:SetAirResistance(601)
						
					-- end ) 
				
				-- end 
				
			-- end 
			

			local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*dist)
			smoke:SetVelocity(self:GetForward()*-800)
			smoke:SetDieTime(math.Rand(1.9,3.2))
			smoke:SetStartAlpha(math.Rand(45,65))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(14,18)*scale)
			smoke:SetEndSize(math.random(66,99)*scale)
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor(fade, fade, fade)
			smoke:SetAirResistance(660)

			local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*dist)
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.05,.1))
			fire:SetStartAlpha(math.Rand(67,99))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(15,20)*scale)
			fire:SetEndSize(math.random(11,16)*scale)
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetStartLength(15)
			fire:SetColor(255,100,0)
			fire:SetEndLength(math.Rand(100, 150))

			local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*dist)
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.05,.1))
			fire:SetStartAlpha(math.Rand(55,65))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(11,14)*scale)
			fire:SetEndSize(math.random(15,16)*scale)
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetColor(255,110,0)

			local fire = emitter:Add("effects/yellowflare", self:GetPos() + self:GetForward()*dist)
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.03,.05))
			fire:SetStartAlpha(math.Rand(155,165))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(11,14)*scale)
			fire:SetEndSize(math.random(2,5)*scale)
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetColor(255,120,0)

			self.cooltime = CurTime() + .025
	
	
		else
		
			if( self.LaunchTime + 3 >= CurTime() ) then 
						
				local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward() * -21 )
				smoke:SetVelocity(Vector(0,0,-5))
				smoke:SetDieTime(math.Rand(3.9,4.2))
				smoke:SetStartAlpha(math.Rand(5,15))
				smoke:SetEndAlpha(0)
				smoke:SetStartSize(math.random(2,4)*scale)
				smoke:SetEndSize(math.random(255,355)*scale)
				smoke:SetRoll(math.Rand(-1,1))
				smoke:SetRollDelta(math.Rand(-.2,.2))
				smoke:SetGravity( Vector( 0, math.random(1,90), -math.random(50,65) ) )
				smoke:SetColor(fade, fade, fade)
				smoke:SetAirResistance(155)
				
			end 
			
		end 


	end
	
end

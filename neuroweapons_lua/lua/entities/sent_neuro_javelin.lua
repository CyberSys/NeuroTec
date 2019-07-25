AddCSLuaFile()

ENT.PrintName = "NeuroTec Javelin"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MISSILE

ENT.HealthVal = 16 -- missile health
ENT.Damage = 3512 -- missile damage
ENT.Radius = 1050 -- missile blast radius
ENT.NozzlePos = Vector( -12, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = Sound("bf4/rockets/pods_rocket_engine_wave 2 0 0_2ch.wav") -- Engine sound, precached or string filepath.
ENT.Model = "models/killstr3aks/wot/american/javelin_rocket_body.mdl" -- 3d model
ENT.VEffect = "v1_impact" -- The effect we call with ParticleEffect()
ENT.DrawBigSmoke = false
ENT.ExplosionSound = Sound( "wt/misc/bomb_explosion_"..math.random(1,6)..".wav" ) 
ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )

-- if CLIENT then 
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )


-- end 


function ENT:Initialize()
	if SERVER then
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		self.SpeedValue = 0 
		
		self.PhysObj = self:GetPhysicsObject()
		
		if ( self.PhysObj:IsValid() ) then
			self.PhysObj:Wake()
			self.PhysObj:SetMass( 500 )
			self.PhysObj:EnableDrag( true )
			self.PhysObj:EnableGravity( true )
		end

		self.Speed = 0
		self.Destroyed = false
		self.EngineSound = CreateSound( self, self.EngineSoundPath )

		local a = self:GetAngles()
		a:RotateAroundAxis( self:GetRight(), 22 )
		self:SetAngles( a )
		self:SetPos( self:GetPos() + self:GetRight() * 8 + self:GetForward() * -32 + self:GetUp() * 8 )
		
		self.PhysObj:SetVelocityInstantaneous( self:GetForward() * 108450 )
		self.PhysObj:SetVelocity( self:GetForward() * 108450 )
		
		-- backblast folks, dont stand behind the launcher with open end.
		for i=1,7 do 
			
			util.BlastDamage( self, self.Owner, self:GetPos() + self:GetForward() * ( i * -42 ), 10, 16 )
		
		end 
		
		timer.Simple( 0.75, function() 	
			if( !IsValid( self ) ) then return end  
			self:FireEngine() 
		end )
	end 
	
	
	-- if( SERVER ) then 
	
		-- Launch Muzzle
		local a = self:GetAngles()
		a:RotateAroundAxis( self:GetUp(), 180 )

		ParticleEffect( "navalgun_muzzleflash_3", self:GetPos(), a, nil ) --[[
																	  Watch how smithy forgets this 
																	  particle in the workshop version
																	  then watch how he forgets the textures
																	  and materials. 
																]]

	-- end
	
	self.HealthVal = 50 
	
end 

function ENT:FireEngine( ) 

	self.Damage = math.random(2500,4500)
	self.Radius = math.random(512,760)
	self.EngineSound:PlayEx(511,100)
	self.ActivatedAlmonds = true 
	self:SetNWBool("EngineStarted", true )
	local a = self:GetAngles()
	a:RotateAroundAxis( self:GetUp(), 180 )
	
	local prop = ents.Create("prop_physics")
	prop:SetPos( self:LocalToWorld( Vector( -15,0,0 ) ) )
	prop:SetAngles( a )
	prop:SetParent( self )
	prop:SetModel( "models/items/ar2_grenade.mdl" )
	prop:Spawn()
	prop:SetRenderMode( RENDERMODE_TRANSALPHA )
	prop:SetColor( Color (0,0,0,0 ) )
	local what = ParticleEffectAttach( "scud_trail", PATTACH_ABSORIGIN_FOLLOW, prop, 0 )
	
	ParticleEffect( "tank_muzzleflash", self:GetPos(), a, nil ) --[[
																  Watch how smithy forgets this 
																  particle in the workshop version
																  then watch how he forgets the textures
																  and materials. 
															]]
end 
function ENT:PhysicsCollide( data ) 
	
	self:MissileDoExplosion()

end 
local speedCap = game.SinglePlayer() and 1800 or 2300 

function ENT:PhysicsUpdate()
	if( !self.ActivatedAlmonds ) then return end 
	if( SERVER ) then 
		
		if( !self.Target ) then return end 
		
		if( self:GetVelocity():Length() < speedCap ) then 
		
			self.SpeedValue = self.SpeedValue + 250
		
		end 
		
		if( IsValid( self.TargetEntity ) && !self.UseMovingTargetAiming ) then 
			
			local tpos = self.TargetEntity:GetPos()
			local mpos = self:GetPos()
			local zdiff = mpos.z - tpos.z 
			-- print(zdiff)
			local tspeed = self.TargetEntity:GetVelocity():Length()
			if( zdiff < -200 && tspeed > 200 ) then 
				
				self.UseMovingTargetAiming = true 
			
			end 
			
		end 

		if( self.UseMovingTargetAiming && IsValid( self.TargetEntity ) ) then 
			
			local dist = ( self.TargetEntity:GetPos() - self:GetPos() ):Length() 
			local pos = ( self.TargetEntity:GetPos() + Vector( 0,0, math.Clamp( dist/5, 0, 2500 ) ) )
			self:SetAngles( LerpAngle( .125, self:GetAngles(), ( pos - self:GetPos() ):GetNormalized():Angle() ) )
	
		else 
			
			local pos = nil 
			pos = self.Target  
			
			local mp = self:GetPos() 
			local _2dDistance = ( Vector( mp.x, mp.y, 0 ) - Vector( self.Target.x, self.Target.y, 0 ) ):Length()
			if( !self.InitialDistance ) then self.InitialDistance = _2dDistance end
			local halfway = self.InitialDistance * .9
			local twoThirds  = self.InitialDistance * .4
			local tr,trace={},{}
			tr.start = self:GetPos()
			tr.endpos = tr.start + Vector( 0,0,16000 )
			tr.filter = self 
			tr.mask = MASK_SOLID 
			trace = util.TraceLine( tr )
			local zLimit = trace.HitPos.z - 1024 
			if( !self.Tracking ) then 
				
				if( _2dDistance > halfway ) then 
					pos = self.Target + Vector( 0,0,512 )
				elseif( _2dDistance < halfway && _2dDistance > twoThirds ) then 
					pos = self.Target + Vector( 0,0,math.Clamp( self.InitialDistance * .85, 0, 14500 ) )
				elseif( _2dDistance < twoThirds ) then 
					pos = self.Target
					if( IsValid( self.TargetEntity ) ) then 
						pos = self.TargetEntity:GetPos() 
						self.Tracking = true 
					end 
				
				end 
			
			else
				
				if( IsValid( self.TargetEntity ) ) then 
				
					pos = self.TargetEntity:GetPos() 
				
				end 
				
			end 
			
			local lerpVal = 0.01 
			if( _2dDistance < 1000 ) then 
				lerpVal = .1 
			end 
			
			self:SetAngles( LerpAngle( lerpVal, self:GetAngles(), ( pos - self:GetPos() ):GetNormalized():Angle() ) )
	
		
		end 
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.SpeedValue )
			
	end 
	
end 

function ENT:Think()
	
	if( SERVER ) then 
		
		if( self.UseMovingTargetAiming && IsValid( self.TargetEntity ) && ( self:GetPos() - self.TargetEntity:GetPos() ):Length() < self.Radius * .65 ) then 
			
			self:MissileDoExplosion()
		
		end 
	
	end 
	
end 
function ENT:Draw()
	self:DrawModel()

		if( !self.Emittime ) then self.Emittime = 0 end 

		if( !self.Emitter ) then 
		
			self.Emitter = ParticleEmitter( self:GetPos() , false )
			self.Seed = math.Rand( 0, 10000 )
			
		end 

				
		self:NextThink(CurTime())
		
		if (self.Emittime < CurTime()) then
			
			local dist = 15
		
			if( !self:GetNWBool("EngineStarted" ) ) then 
			
				local smoke = self.Emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
				smoke:SetVelocity(self:GetForward()*-800)
				smoke:SetDieTime(math.Rand(.9,1.2))
				smoke:SetStartAlpha(math.Rand(11,25))
				smoke:SetEndAlpha(0)
				smoke:SetStartSize(math.random(14,18))
				smoke:SetEndSize(math.random(66,99))
				smoke:SetRoll(math.Rand(180,480))
				smoke:SetRollDelta(math.Rand(-2,2))
				smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
				smoke:SetAirResistance(60)
			
			
				return 
			
			end 
				
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then

			local c = Color( 250+math.random(-5,5), 170+math.random(-5,5), 0, 100 )

			dlight.Pos = self:GetPos()
			dlight.r = c.r
			dlight.g = c.g
			dlight.b = c.b
			dlight.Brightness = 1
			dlight.Decay = 0.1
			dlight.Size = 2048
			dlight.DieTime = CurTime() + 0.15

		end
		
		local fire = self.Emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.05,.1))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(4,5))
		fire:SetEndSize(math.random(20,33))
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetStartLength(15)
		fire:SetColor(255,100,0)
		fire:SetEndLength(math.Rand(100, 150))

		local fire = self.Emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.05,.1))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(3,6))
		fire:SetEndSize(math.random(20,33))
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetColor(255,110,0)

		local fire = self.Emitter:Add("effects/yellowflare", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.03,.05))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(1,5))
		fire:SetEndSize(math.random(99,100))
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetColor(255,120,0)
		
		-- self.Emitter:Finish()
		
	end

		
end 

function ENT:Use( p,o,_o,_p ) return end 

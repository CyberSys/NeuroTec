AddCSLuaFile()
ENT.Type 			= "anim"
ENT.BaseClass 		= "anim"
ENT.PrintName		= ""
ENT.Author			= "Hoffa"
ENT.Category		= ""
ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.HealthVal = 150
ENT.InitialHealth = 150
ENT.Destroyed = false
ENT.IsFlying = true -- disable physgun
ENT.IsBurning = false
ENT.PhysgunDisabled  = true 
ENT.AutomaticFrameAdvance = true
   
function ENT:PhysicsUpdate()
		-- function ENT:PhysicsSimulate( phys, deltatime )
	if( self.IsAnimatedLandingGear ) then
	
		-- self.GearPoseParam = math.Approach(  self.GearPoseParam, self:GetNetworkedFloat("lgear_poseparam",  1.0 ), FrameTime()  )
		-- self.GearPoseParam = math.floor( 10000 * Lerp( 0.025, self.GearPoseParam, self:GetNetworkedFloat("lgear_poseparam", 1.0 )) ) / 10000 
		-- print( self.GearPoseParam )
		-- self:SetSequence( "gear_down" ) 
		-- self:SetPoseParameter("gear_down",  self.GearPoseParam )
		-- self:InvalidateBoneCache()
		-- self:SetSequence("idle")
	end	
	
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )

  self.AutomaticFrameAdvance = bUsingAnim

end  

if( CLIENT ) then

	local emitter = ParticleEmitter(Vector(0, 0, 0))
	
	
	function ENT:Draw()
		
		if( self:GetNetworkedBool( "IsPropeller",false) ) then
				
			
			
		else
			
	
			
		end
		
		self:DrawModel()
		-- if( self:GetNetworkedBool("IsAnimatedLandingGear",false ) ) then
		
			-- if( !self.CGearPoseParam ) then self.CGearPoseParam = 1 end
		
			-- self.CGearPoseParam = Lerp( FrameTime(), self.CGearPoseParam, self:GetNetworkedFloat("lgear_poseparam", 1.0 ) )
			
			-- if( self.GearPoseParam > 0 && self.GearPoseParam < 1 ) then
				
				-- self:SetPoseParameter("gear_down", self.CGearPoseParam )
				-- self:InvalidateBoneCache()
			-- end
			
		-- end
		
		if( self.IsPropeller ) then

		end
		
	
	
		if( self.DamagePositions ) then
		
			for k,v in ipairs( self.DamagePositions ) do
				
			if( v[1]    ) then 
				
				if(  v[2] < 133700 ) then 
				
					local smoke = emitter:Add("effects/smoke_b", self:LocalToWorld( v[1] ) )
					smoke:SetVelocity(self:GetForward()*-80)
					smoke:SetDieTime(math.Rand(.9,.2))
					smoke:SetStartAlpha(math.Rand(55,87))
					smoke:SetEndAlpha(0)
					smoke:SetStartSize(math.random(4,7))
					smoke:SetEndSize(math.random(26,32))
					smoke:SetRoll(math.Rand(-15,15))
					smoke:SetRollDelta(math.Rand(-2,2))
					smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
					smoke:SetColor(50, 50, 50)
					smoke:SetAirResistance(60)
					
				end
				
				if( v[2] > 20 && v[2] < 133700 ) then
					
					local smoke = emitter:Add("effects/smoke_a", self:LocalToWorld( v[1] ) )
					smoke:SetVelocity(self:GetForward()*-80)
					smoke:SetDieTime(math.Rand(.6,.2))
					smoke:SetStartAlpha(math.Rand(12,24))
					smoke:SetEndAlpha(0)
					smoke:SetStartSize(math.random(16,20))
					smoke:SetEndSize(math.random(22,26))
					smoke:SetRoll(math.Rand(-15,15))
					smoke:SetRollDelta(math.Rand(-2,2))
					smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
					smoke:SetColor(50, 50, 50)
					smoke:SetAirResistance(60)
					
				end
				if( v[2] == 133701 ) then
					
					local smoke = emitter:Add("particle/water/watersplash_001a_refract", self:LocalToWorld( v[1] ) + self:GetRight() * math.random(-8,8) )
					smoke:SetVelocity(self:GetForward()*-80)
					smoke:SetDieTime(math.Rand(.6,.2))
					smoke:SetStartAlpha(math.Rand(255,255))
					smoke:SetEndAlpha(0)
					smoke:SetStartSize(math.random(2,4))
					smoke:SetEndSize(math.random(12,16))
					smoke:SetRoll(math.Rand(-15,15))
					smoke:SetRollDelta(math.Rand(-2,2))
					smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
					smoke:SetColor(255, 255, 255 )
					smoke:SetAirResistance(60)
					-- 
				
				end
				
				if( v[2] == 133700  ) then
					
			
					local bonepos = self:LocalToWorld( v[1] ) 
					local tr,trace={},{}
					tr.start = bonepos + self:GetUp() * 72
					tr.endpos = bonepos 
					tr.mask = MASK_SHOT_HULL
					trace = util.TraceLine( tr ) 
					
					bonepos = trace.HitPos + trace.HitNormal * -2
					local dlight = DynamicLight( self:EntIndex().."_"..k )
					if ( dlight ) then

						local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

						dlight.Pos = bonepos
						dlight.r = c.r
						dlight.g = c.g
						dlight.b = c.b
						dlight.Brightness = 1 + math.Rand( 0, 1 )
						dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
						dlight.Size = 128
						dlight.DieTime = CurTime() + 0.025

					end
					local fire = emitter:Add("particles/Fire1", bonepos+VectorRand() )
					fire:SetVelocity(self:GetForward()*-1)
					fire:SetDieTime(math.Rand(0.2,.53))
					fire:SetStartAlpha(math.Rand(155,255))
					fire:SetEndAlpha(0)
					fire:SetStartSize(math.random(11,13))
					fire:SetEndSize(math.random(0,0))
					fire:SetAirResistance(5)
					fire:SetRoll(math.Rand(180,480))
					fire:SetRollDelta(math.Rand(-10,10))
					fire:SetColor(255,110,0)
					fire:SetGravity( self:GetForward() * -150 )	
					
					local fire = emitter:Add("effects/smoke_a", bonepos  )
					fire:SetVelocity(self:GetForward()*1)
					fire:SetDieTime(math.Rand(.16,0.4))
					fire:SetStartAlpha(math.Rand(1,5))
					fire:SetEndAlpha(0)
					fire:SetStartSize(math.random(9,12))
					fire:SetEndSize(math.random(0,0))
					fire:SetAirResistance(5)
					fire:SetRoll(math.Rand(180,480))
					fire:SetRollDelta(math.Rand(-3,3))
					fire:SetColor(255,110,0)
					fire:SetGravity( self:GetForward() * -150 )	
					
					local fire = emitter:Add("effects/fas_glow_debris", bonepos )
					fire:SetVelocity(self:GetForward()*-1)
					fire:SetDieTime(math.Rand(.1,.2))
					fire:SetStartAlpha(math.Rand(115,215))
					fire:SetEndAlpha(255)
					fire:SetStartSize(math.random(7,math.random(11,19) ) )
					fire:SetEndSize(math.random(0,0))
					fire:SetAirResistance(15)
					fire:SetRoll(math.Rand(180,480))
					fire:SetRollDelta(math.Rand(-3,3))
					fire:SetColor(255,120,0)
					fire:SetGravity( self:GetForward() * -150 )	
					
					local smoke = emitter:Add("effects/smoke_a", bonepos )
					smoke:SetDieTime(math.Rand(3.6,4.2))
					smoke:SetStartAlpha(math.Rand(45,76))
					smoke:SetEndAlpha(0)
					smoke:SetStartSize(math.random(5,8))
					smoke:SetEndSize(math.random(85,125))
					smoke:SetRoll(math.Rand(-15,15))
					smoke:SetRollDelta(math.Rand(-2,2))
					smoke:SetGravity( self:GetForward() * -150 + VectorRand() * 16)
					smoke:SetColor(50, 50, 50)
					smoke:SetAirResistance(60)
					end
					
				end
					
			end
			
		end
		
	end
	
end
-- if( SERVER ) then  && self:GetVelocity():Length() > 10

function ENT:ToggleLandingGear()
	
	self:SetCycle( 0 )
	
	if( self.IsAnimatedLandingGear ) then
	
		-- if( !self.LastDeploy ) then self.LastDeploy = 0 end
		
		-- if( self.LastDeploy + 2.0 >= CurTime() ) then return end 
		
		-- self.GearDeployed = !self.GearDeployed
		-- self.LastDeploy = CurTime()
		-- set animation playback rate, default 0.5 for 50% of normal speed.
		-- self:SetPlaybackRate( 0.5 )
		
		if( #self:GetSequenceList() == 0 ) then return end
		
		if( self.GearDeployed ) then
	
			self:RemoveLandingGearWheel( self.DeployDuration )
		
		else

			self:CreateLandingGearWheel( self.DeployDuration )
			
		end
		
	end
	-- print("Called the console command:", self.GearDeployed )
end

-- end

function ENT:CreateLandingGearWheel( delay )
	
	if( !self.LastDeploy ) then self.LastDeploy = 0 end
	if( self.LastDeploy + 2.0 >= CurTime() ) then return end 
	self.GearDeployed = !self.GearDeployed	
	self.LastDeploy = CurTime()
	local a,b = self:LookupSequence( "idle_geardown" )
	self:SetPlaybackRate(0.15)
	self:ResetSequence( a )
	self:SetSequence( a )
		
	
	-- print( "Begin Deploy", delay )
	timer.Simple( delay, function() 
		
		if( IsValid( self ) && IsValid( self.Wheel ) && IsValid( self.WheelAxis ) && !self.GearDeployed) then
			
			local bone = self:LookupBone("Spinnythingy")
			if( bone ) then
				
				self.Wheel:SetRenderMode( RENDERMODE_TRANSALPHA )
				self.Wheel:SetColor( Color( 255,255,255,255 ) )
				self:ManipulateBoneScale( bone, Vector( 0,0,0 ) )
				self.Wheel:SetSolid( SOLID_VPHYSICS )
				self.Wheel:GetPhysicsObject():EnableDrag(true)
				-- self:SetNetworkedFloat("lgear_poseparam", 1.0 )
				-- self.Wheel:GetPhysicsObject():EnableGravity(true)
				-- print("Valid Deploy")
			end
			
		end
	
	end )
	
end

function ENT:RemoveLandingGearWheel( delay )
		
	if( !self.LastDeploy ) then self.LastDeploy = 0 end
	if( self.LastDeploy + 2.0 >= CurTime() ) then return end 
	self.GearDeployed = !self.GearDeployed	
	self.LastDeploy = CurTime()
-- timer.Simple( delay, function() 
		
	self:SetPlaybackRate( 0.01 )
	local a,b = self:LookupSequence( "idle" )
	self:ResetSequence( a )
	self:SetSequence( a )
	
	-- print( self:GetPlaybackRate())
	if(  IsValid( self ) && IsValid( self.Wheel ) && IsValid( self.WheelAxis ) ) then
			
			-- print("walla?")
		local bone = self:LookupBone("Spinnythingy")
		if( bone ) then
			-- print("Valid Retract")
			self.Wheel:SetRenderMode( RENDERMODE_TRANSALPHA )
			self.Wheel:SetColor( Color( 0,0,0,0 ) )
			self:ManipulateBoneScale( bone, Vector( 1,1,1 ) )
			self.Wheel:GetPhysicsObject():EnableDrag(false)
			-- self:SetSequence( "idle" ) 
			-- self.Wheel:idle():EnableGravity(false)
			-- self:SetNetworkedFloat("lgear_poseparam", 0.0 )
			
			self.Wheel:SetSolid( SOLID_NONE )
			
		end
		
	end
		
	-- end )
	
end

function ENT:Initialize()
	
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.VehicleType = VEHICLE_TANK
	self.HitTable = {}
	
	self.StartingColor = self:GetColor()
	
	self.Animations = self:GetSequenceList()
	-- PrintTable( self.Animations )
		-- print( table.HasValue(self.Animations, "idle_geardown" )  )

	self:SetNetworkedInt( "Health", math.floor( self.HealthVal or 100 ) )
	
	if (  SERVER && table.HasValue(self.Animations, "idle_geardown" ) ) then 
		
		self:SetAutomaticFrameAdvance( true )

		-- print( self:GetModel() )
		local a,b = self:LookupSequence( "idle_geardown")
		if( b == 0 ) then	
			
			b = 1 
			
		end
		
		self.GearPoseParam = 1.0
		-- print( self:GetModel(), b )
		self:SetPlaybackRate( 0.15 )
		-- print( self:GetSequenceActivity( a )) 
		self:ResetSequence( a )
		self:SetSequence( a ) 
		-- self:SetPoseParameter( "gear_down", self.GearPoseParam )
		-- self:InvalidateBoneCache()
		
		self.LastDeploy = 0
		-- print("animation duration", b )
		self.DeployDuration = math.Clamp( b, 0, 1 )
	
		self.IsAnimatedLandingGear = true
		self.GearDeployed = true
	
		if( !IsValid( self.Wheel ) ) then
		
			local bone = self:LookupBone("Spinnythingy")
			if( bone ) then
			
				local bp, ba = self:GetBonePosition( bone ) --Spinnythingy
				
				-- Wingdex is the wing index from the spawn table.
				-- Left wing should always be first entry
				if( self.Wingdex == 1 ) then
					
					-- adjust to left bone position
					-- ba:RotateAroundAxis( self:GetUp(), 90 )
				
				elseif( self.Wingdex == 2 ) then
					-- adjust to right bone position
					-- ba:RotateAroundAxis( self:GetUp(), -90 )
				
				elseif( self.Wingdex == 3 ) then -- Tail landing gear
					
					ba:RotateAroundAxis( self:GetForward(), 90 )
					ba:RotateAroundAxis( self:GetUp(), 60)
				
				end
				-- print( self.WheelModel )
				self.Wheel = ents.Create("plane_part")
				if( self.TailWheelPositionOverride ) then
					
					bp = self:LocalToWorld( self.TailWheelPositionOverride )
				
				
				end 
				
				self.Wheel:SetPos( bp )
				-- print("created wheel", bp )
				self.Wheel:SetModel( self.WheelModel or "models/error.mdl" )
				self.Wheel:SetAngles( ba )
				self.Wheel.HealthVal = self.HealthVal / 4
				-- self:DrawLaserTracer( self:GetPos()+Vector(0,0,400), self.Wheel:GetPos() )
				self.Wheel:Spawn()
				self.Wheel:SetRenderMode( RENDERMODE_TRANSALPHA )
				self.Wheel:SetColor( Color( 255,255,255,255 ) )
				self.Wheel.IsDumbWheel = true
				self.Wheel:GetPhysicsObject():EnableDrag(true)
				self.Wheel:GetPhysicsObject():EnableGravity(false)
				self.Wheel:GetPhysicsObject():SetMass( 6000 )
				self:ManipulateBoneScale( bone, Vector( 0,0,0 ) )
					-- print("Create wheels ")
				timer.Simple( 0, function() 
					
					if( IsValid( self ) && IsValid( self.Wheel ) ) then
					
						self.WheelAxis = constraint.Axis( self.Wheel, self, 0, 0, Vector(0,1,0) , self:WorldToLocal( bp ), 35000, 0, 15, 0 )
					
					end
					
				end )
				self:DeleteOnRemove( self.Wheel )
					
				-- self:RemoveLandingGearWheel( 2 )
				-- print("created wheel", self.Wheel )
			end
			
		end
	
	end
	
	if( SERVER ) then
	
		self:Micro_SetupBones()
	else	
		
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
	end
	
end

function ENT:OnRemove()
	
	if( self.EngineMux ) then
	
		for i=1,#self.EngineMux do
			
			self.EngineMux[i]:Stop()
		
		end
		
	end
	
	if( self.Destroyed ) then
		
		
		if( self.IsHelicopterRotor  ) then 
		
			for i=1,18 do 
				
				local ang = self:GetAngles() 
				ang:RotateAroundAxis( self:GetUp(), i*20 )
				
				ParticleEffect( "microplane_damage", self:GetPos(),ang , nil )
			
			end 
			
		else
		
			
			local junk = ents.Create("prop_physics")
			junk:SetPos( self:GetPos() )
			junk:SetAngles( self:GetAngles() )
			junk:SetModel( self:GetModel() )
			junk:Spawn()
			-- print("spawned junk")
			if( IsValid( junk:GetPhysicsObject() )) then	
			
				junk:GetPhysicsObject():SetVelocity( self:GetVelocity() )
			
			end
			
			if( self.HealthVal <= 0 ) then 
				
				junk:Fire("Kill","",20)
			
			end 
			
			if( math.random(1,4) == 2 && !self.NoFieryDeath ) then
				
				junk:Ignite( 128,128)
				
			end
			
		
		end 
		
	end
	
end
function ENT:Think()
	
	if CLIENT then return end
	
	self:NextThink(CurTime())
	
	if( self.IsPropeller && self:WaterLevel() > 0 ) then 	
		
		if( IsValid( self.PropellerAxis ) ) then 
			
			constraint.RemoveAll( self )
			-- self.PropellerAxis.Remove 
			
			return
			
		end 
		
	end 
	
	if( self.TurretBones ) then
	
		self:Micro_GunnerThink()
	
	end
	-- if( self.IsArmedWeapon ) then print( "walla?") end 
 	if( self.IsArmedWeapon && !IsValid( self.Weld ) ) then
		
		local bomb = ents.Create( self.Class )
		bomb:SetPos( self:GetPos() )
		bomb:SetModel( self:GetModel() )
		bomb:SetAngles( self:GetAngles() )
		bomb.Owner = self.Owner
		bomb:Spawn()
		
		if( self.HealthVal <= 0 ) then 
			
			bomb:Remove()
			
		end 
		
		self:Remove()
		
		return 
		
	end 
	
	if( IsValid( self.CrossWeld ) && !IsValid( self.Weld ) ) then
							
		self.CrossWeld:Remove()
			
	end
	
	if( IsValid( self.Wheel ) ) then

		if( !IsValid( self.WheelAxis ) ) then
		
			self.Wheel:GetPhysicsObject():EnableGravity(true)
	
		end
	
	end
	
end

function ENT:PhysicsCollide( data )
	if( self.Destroyed ) then return end 
	
	if( data.Speed > 200 && data.DeltaTime > .1 && self.IsHelicopterRotor && data.HitEntity.Owner != self.Owner && data.HitEntity != self.Owner  ) then 

		if( data.HitEntity:IsNPC() || data.HitEntity:IsPlayer() ) then 
			
			local fx = EffectData()
			fx:SetOrigin( data.HitPos )
			fx:SetNormal( data.HitNormal )
			fx:SetEntity( self )
			fx:SetScale( 1 )
			util.Effect( "micro_he_blood", fx )
			
		else
				
			ParticleEffect( "microplane_damage", self:GetPos(), self:GetAngles(), nil )
			ParticleEffect( "microplane_damage",data.HitPos, data.HitNormal:Angle(), nil )
		
		end 
		
		self:EmitSound( "npc/manhack/grind"..math.random(2,5)..".wav", 511, 100 )
		
		if( data.DeltaTime > .5 && data.Speed > 2000 ) then 
			
			if( data.HitEntity:IsNPC() || data.HitEntity:IsPlayer() ) then 
		
			else 
				
				self.Destroyed = true 
			
				self:Remove()
			
			
				return 
		
			end 
	
		end 
			
	
		return
		
	end 
	
	if( data.Speed > 350 && data.DeltaTime > 0.5 && !self.IsDumbWheel ) then
	
		ParticleEffectAttach( "microplane_damage", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
		
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end
	
	local dt = dmginfo:GetDamageType()
	local dmg = dmginfo:GetDamage()
	local inflictor = dmginfo:GetAttacker()
	local dp = dmginfo:GetDamagePosition()
	
	if( inflictor == self.Owner || inflictor == self ) then return end 
	
	self.HealthVal = self.HealthVal - dmg
	self.StartingColor.r = math.Approach( self.StartingColor.r, 35, 1 )
	self.StartingColor.g = math.Approach( self.StartingColor.g, 35, 1 )
	self.StartingColor.b = math.Approach( self.StartingColor.b, 35, 1 )
	
	self:SetNetworkedInt( "Health", self.HealthVal or 0 )
	
	if( self.EngineBones ) then 
		
		if( self.EngineBones ) then
		
			local dist = 999999999
			for k,v in ipairs( self.EngineBones ) do 
					
				local bp, ba = self:GetBonePosition( v.Index )
				local tdist = dp:DistToSqr( bp )
				
				if( GetConVarNumber("developer")>0 ) then
					if( v.EngineBone ) then
					
						debugoverlay.Sphere( bp, math.sqrt( 320 ), 155.1, Color( 55,255,55,255 ), true  )
					
					else
						
						debugoverlay.Sphere( bp, math.sqrt( 320 ), 155.1, Color( 55,55,255,255 ), true  )
					
					
					end
					
				end
				
				if( tdist < 320 ) then
					
					-- print( v.Health, v.Destroyed )
					if( v.Health <= 0 && v.Destroyed && !v.FuelIgnited && !v.TurretBone ) then
					
						-- v.FuelIgnited = true
						self.EngineBones[k].FuelIgnited = true
						-- print("walla?")
						SendDamageVector( v.Pos, self, 133700  )
						-- ParticleEffectAttach( "microplane_fuel_leak_fire", PATTACH_POINT_FOLLOW, self, v.Index )
								
						local obj = v 
						
						timer.Create( self:EntIndex().."_timer_"..k, 0.5, 120, 
						function() 
							
							if( obj && IsValid( self ) && IsValid( self.Owner ) ) then
									
								util.BlastDamage( self, self, self.Owner:GetPos(),32, 2 )
							
							end
							
						end )
						
					end
					
					v.Health = v.Health - dmg
					
					if( v.Health <= 20 && !v.Destroyed ) then
						
						local allStuff = constraint.GetAllConstrainedEntities( self )
						local maxdist = 400
						local cur = NULL
						local propdist = 0 
						local targetdist = 0
	
						for _,z in pairs( allStuff ) do
							
							if( z.IsPropeller ) then 
							
								propdist =  z:GetPos():DistToSqr( bp )
								
								if( propdist < maxdist ) then
									
									maxdist = propdist
									cur = z
									
								end
							
							end
							
						end
						
						if( v.Health <= 0 ) then
						
							self.EngineBones[k].Destroyed = true
								
							if( v.EngineBone ) then
							
								SendDamageVector( v.Pos, self, 133700  ) -- Engine smoke
									timer.Create( self:EntIndex().."_timer_"..k+1, 0.5, 120, 
									function() 
										
										if( IsValid( self ) && IsValid( self.Owner ) ) then
												
											util.BlastDamage( self, self, self.Owner:GetPos(),32, 2 )
										
										end
										
									end )
							else
								
								if( !v.TurretBone ) then
								
									SendDamageVector( v.Pos, self, 133701  ) -- Fuel leak
								-- ParticleEffectAttach( "microplane_fuel_leak", PATTACH_POINT_FOLLOW, self, v.Index )
								else
															
										
										-- v.Destroyed = true
										local fx = EffectData()
										fx:SetOrigin( v.Pos )
										-- self:DrawLaserTracer(self:GetPos() + Vector(0,0,512), pbpos )
										fx:SetNormal( self:GetUp() )
										fx:SetEntity( self )
										fx:SetScale( 1 )
										util.Effect( "micro_he_blood", fx )
								
								end
								
								
							end
							
						end
						
						-- print( propdist )
						if( IsValid( cur ) ) then
							
							if( v.Health <= 0 ) then
						
								cur:SetParent( self )
								cur.IsBurning = true
								if( cur.EngineMux ) then
									
									for k,v in pairs( cur.EngineMux ) do
										
										v:Stop()
									
									end 
									
								end
								
								local rnd = "wt/misc/Engine_destroyed"..math.random(1,3)..".wav"
								cur:EmitSound( rnd, 511, 100 )
								-- self:EmitSound( "wt/misc/fire.wav", 510, 100 )
								
							else
								
								if( IsValid( cur:GetPhysicsObject() ) ) then
									
									cur:GetPhysicsObject():AddAngleVelocity( cur:GetPhysicsObject():GetAngleVelocity()*-1 )
									local rnd = "wt/misc/Engine_destroyed"..math.random(1,3)..".wav"
									cur:EmitSound( rnd, 511, 100 )
									
								end									
									
							end
							
						end
					
					end
					
				end
		
			end
			
		end
		
	else
		-- old damage system 'pre bone system'
		-- if( #self.HitTable <= 4 && dmg > 7 && !self.IsDumbWheel ) then
			
			-- local tr,trace = {},{}
			-- tr.start = dmginfo:GetDamagePosition()
			-- tr.endpos = self:GetPos()
			-- tr.filter = { self.Owner }
			-- tr.mask = MASK_SHOT_HULL 
			-- trace = util.TraceLine( tr )
			
			-- if( IsValid( self:GetPhysicsObject() ) ) then
				
				-- local mins,maxs = self:GetPhysicsObject():GetAABB()
				-- mins = self:WorldToLocal( mins )
				-- maxs = self:WorldToLocal( maxs )
				
				-- local newpos = self:WorldToLocal( trace.HitPos )
				-- if( newpos:WithinAABox( mins, maxs ) ) then
				-- print("close enough")
				
				-- else
					
					-- print("clamping")
					-- print( newpos, mins, maxs )
					-- newpos.x = math.Clamp( newpos.x, mins.x/2, maxs.x/2 )
					-- newpos.y = math.Clamp( newpos.y, mins.y/2, maxs.y/2 )
					-- newpos.z = math.Clamp( newpos.z, mins.z/2, maxs.z/2 )
					
				-- end
				
				-- table.insert( self.HitTable, newpos )
				-- SendDamageVector( newpos, self, math.Clamp( dmg, 0, 500 )  )
				
			-- end
			
		-- end
		
	end
	
	if( self.HealthVal < 30  && !self.IsDumbWheel ) then
		
		ParticleEffectAttach( "microplane_damage", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
		
	end
	
	-- print( self.HealthVal )
	if(	self.HealthVal <= 0 ) then
		
		-- print("self destroyed!")
		-- self:Ignite( 100, 100 )
		self.Destroyed = true
		if( self.IsArmedWeapon ) then 
			
			self:Remove()
		
		else
		
			self:EmitSound("ambient/materials/metal_rattle"..math.random(1,4)..".wav", 511, 100 )
			self:Fire("kill","",math.random(0,10))
		
		end 
		/*

		
		self:Remove()
		
		*/
		
	end
	
end

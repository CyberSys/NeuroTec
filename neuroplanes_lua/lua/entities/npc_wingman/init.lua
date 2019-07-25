AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/hawx/air/f-16a fightingfalcon.mdl"
//Speed Limits
ENT.MaxVelocity = 3000
ENT.MinVelocity = 900

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.DefaultBankingFactor = 1.98
ENT.BankingFactor = 1.98

// MAV = Max Angular Velocity
ENT.MAV_High = 55
ENT.MAV_Low = 35

ENT.InitialHealth = 1500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 2000
ENT.DeathTimer = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 5

ENT.LockOn = false

// Equipment
ENT.MachineGunModel = "models/h500_gatling.mdl"
ENT.MachineGunOffset = Vector( 160, 65, 12 )

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.15


function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	
	self.CycleOffset = Vector( 0, math.random( -512, 512 ), math.random( -512, 512 ) )
	
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.LastWepCycle = CurTime()
	
	self.Pilot = ents.Create("prop_physics_override")
	self.Pilot:SetPos( self:GetPos() )
	self.Pilot:SetModel("models/airboatgun.mdl")
	self.Pilot:SetAngles( self:GetAngles() )
	self.Pilot:SetParent( self )
	self.Pilot:SetOwner( self )
	self.Pilot:SetSolid( SOLID_NONE )
	self.Pilot:SetColor( Color( 0,0,0,0 ) )
	self.Pilot:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Pilot:Spawn()
	
	self.PavePenny = ents.Create("info_target")
	self.PavePenny:SetPos( self:GetPos() )
	self.PavePenny:Spawn()
	
	// Sound
	local esound = {}
	self.EngineMux = {}
	
	esound[1] = "physics/metal/canister_scrape_smooth_loop1.wav"
	esound[2] = "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	esound[3] = "ambient/levels/canals/dam_water_loop2.wav"
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 80
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )
	self.EngineMux[3]:PlayEx( 500 , self.Pitch )
	
	if( self.Armament ) then
		
		// Do nothing. We already have our weapon data.
	
	else
		// Default loadout
		self.Armament = {
						{ 
							PrintName = "Aim-9 Sidewinder"		,		 			// print name, used by the interface
							Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
							Pos = Vector( -28, -188, 1.7), 							// Pos, Hard point location on the plane fuselage.
							Ang = Angle( 0, 0, 45), 								// Ang, object angle
							Type = "Homing", 										// Type, used when creating the object
							Cooldown = 7, 											// Cooldown between weapons
							-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							Class = "sent_a2a_rocket"
						}; 
						{ 
							PrintName = "Aim-9 Sidewinder"		,		 			// print name, used by the interface
							Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",		// model, used when creating the object
							Pos = Vector( -28, 188, 1.7), 							// Pos, Hard point location on the plane fuselage.
							Ang = Angle( 0, 0, 45), 								// Ang, object angle
							Type = "Homing", 										// Type, used when creating the object
							Cooldown = 7, 											// Cooldown between weapons
							-- isFirst	= nil,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							Class = "sent_a2a_rocket"
						}; 
						/* CBU-100 Clusterbomb - Right Wing */
						{ 
							PrintName = "CBU-100 Clusterbomb", 
							Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
							Pos = Vector( -38, -119, -15 ), 
							Ang = Angle( 0, 0, 45), 
							Type = "Bomb",
							Cooldown = 15,
							--isFirst	= true,
							Class = "sent_mk82"
						}; 
						/* CBU-100 Clusterbomb - Right Wing */
						{ 
							PrintName = "CBU-100 Clusterbomb", 
							Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
							Pos = Vector( -38, 119, -15 ), 
							Ang = Angle( 0, 0, 45), 
							Type = "Bomb",
							Cooldown = 15,
							-- isFirst	= false,
							Class = "sent_mk82"
						}; 
						{ 
							PrintName = "AGM-144 Hellfire"		,		 			// print name, used by the interface
							Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  		// model, used when creating the object
							Pos = Vector( -4, -58, 37), 							// Pos, Hard point location on the plane fuselage.
							Ang = Angle( 0, 0, 0), 									// Ang, object angle
							Col = Color( -19, -71, -13), 									// Color
							Type = "Singlelock", 										// Type, used when creating the object
							Cooldown = 8, 											// Cooldown between weapons
							-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							Class = "sent_hellfire_missile",								// the object that will be created.
							Radius = 2048,
							Damage = 5500
						};
						{ 
							PrintName = "AGM-88 HARM"		,		 			
							Mdl = "models/hawx/weapons/agm-88 harm.mdl",  	
							Pos = Vector( -19, 71, -13), 						
							Ang = Angle( 0, 0, 45), 					
							Type = "Homing", 								
							Cooldown = 7, 					
							-- isFirst	= nil,
							Class = "sent_a2a_rocket"
						};
						
					}
	
	end
	
	// Armamanet
	local i = 0
	local c = 0
	self.FireVar = 0
	self.FireMode = 1
	self.EquipmentNames = {}
	self.RocketVisuals = {}
	
	for k,v in pairs( self.Armament ) do
		
		i = i + 1
		self.RocketVisuals[i] = ents.Create("prop_physics_override")
		self.RocketVisuals[i]:SetModel( v.Mdl )
		self.RocketVisuals[i]:SetPos( self:GetPos() + self:GetForward() * v.Pos.x + self:GetRight() * v.Pos.y + self:GetUp() * v.Pos.z )
		self.RocketVisuals[i]:SetAngles( self:GetAngles() + v.Ang )
		self.RocketVisuals[i]:SetParent( self )
		self.RocketVisuals[i]:SetSolid( SOLID_NONE )
		self.RocketVisuals[i].Type = v.Type
		self.RocketVisuals[i].PrintName = v.PrintName
		self.RocketVisuals[i].Cooldown = v.Cooldown
		self.RocketVisuals[i].isFirst = v.isFirst
		self.RocketVisuals[i].Identity = i
		self.RocketVisuals[i].Class = v.Class
		self.RocketVisuals[i]:Spawn()
		self.RocketVisuals[i].LastAttack = CurTime()
		self.RocketVisuals[i]:SetColor( Color( 0,0,0,0 ) )
		self.RocketVisuals[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
		
		if ( v.Damage && v.Radius ) then
			
			self.RocketVisuals[i].Damage = v.Damage
			self.RocketVisuals[i].Radius = v.Radius
		
		end
		
		// Usable Equipment
		if ( v.isFirst == true || v.isFirst == nil /* Single Missile*/ ) then
		
			if ( v.Type != "Effect" && v.Type != "Flarepod" ) then
				
				c = c + 1
				self.EquipmentNames[c] = {}
				self.EquipmentNames[c].Identity = i
				self.EquipmentNames[c].Name = v.PrintName
				
			end
			
		end
		
	end
	
	self.NumRockets = #self.EquipmentNames
	
	local o = self.MachineGunOffset
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( self.MachineGunModel )
	self.Weapon:SetPos( self:GetPos() + self:GetForward() * o.x + self:GetRight() * o.y + self:GetUp() * o.z  )
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:SetSolid( SOLID_NONE )
	self.Weapon:SetColor( Color( 0,0,0,0 ) )
	self.Weapon:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Weapon:SetParent( self )
	self.Weapon:Spawn()
	
	// Misc
	if ( self:GetModel() ) then
		
		self:SetModel( self:GetModel() )
		
	else
	
		--self:SetModel( "models/hawx/air/f-16a fightingfalcon.mdl" )
	self:SetModel( self.Model )	
		
	end

	self:SetSkin( math.random( 0, 1 ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(10000)
		
	end

	self:StartMotionController()

end


function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	if ( self.Target == self.Owner ) then
		
		local a = dmginfo:GetInflictor()
		
		if( IsValid( a ) && a != self.Owner && a != self.Owner.Pilot && a.Owner != self.Owner ) then
			
			self.Owner.LastAttacker = a
			self.Target = a
			
		end
		
	end

	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < 50 && !self.Burning ) then
	
		self.Burning = true
		local pos = {}
		local p = self:GetPos()
		local f = self:GetForward()
		local r = self:GetRight()
		local u = self:GetUp()

		pos[1] = p + f * -330 + r * -80 + u * 17
		pos[2] = p + f * -330 + r * 80 + u * 17
		
		for _i=1,2 do
		
			local f = ents.Create("env_Fire_trail")
			f:SetPos( pos[_i] )
			f:SetParent( self )
			f:Spawn()
			
		end
		
	end
	
	if ( self.HealthVal < 0 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
		self.PhysObj:ApplyForceCenter( self:GetForward()*50000 )
		self.PhysObj:AddAngleVelocity( Vector( 50, 0, 0 ) )
		
		timer.Simple( math.random(2,4), function() self:DeathFX() end )

		return
		
	end
	
end

function ENT:OnRemove()

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
	
	end
	
	self.PavePenny:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.9 && data.DeltaTime > 0.2 ) then 

		self:DeathFX()
			
	end
	
end

function ENT:DoPrimaryAttack()
	
	for i=1,2 do
		
		timer.Simple( i * self.PrimaryCooldown, function() if( IsValid( self ) ) then self:PrimaryAttack() end end )
		
	end

end


function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch,0.01 )
		
	end

	if ( self.Destroyed ) then 
		
		self:EmitSound("lockon/voices/IamHit.mp3",511,100)
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if ( self.DeathTimer > 40 ) then
		
			self:DeathFX()
		
		end
		
	end
	
	if( !IsValid( self.CycleTarget ) ) then
		
		self:DeathFX()
		
		
		return
		
	end
	
	if( IsValid( self.Target ) ) then
		
		if( self.Target.HealthVal && self.Target.HealthVal < 100 ) then
			
			self.Target = self.CycleTarget
			
			return
			
		end
		
		//print( "Have target", self.Target:GetClass() )
		
		// Movement stuff
		local a = ( self.Target:GetPos() - self:GetPos() ):Angle()
		local b =  Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	
		self.Yaw = self:VecAngD( a.y, b.y )
		self.Pitch = self:VecAngD( a.p, b.p )
		
		local trace,tr = {},{}
		tr.start = self.Target:GetPos()
		tr.endpos = tr.start - Vector(0,0,1000)
		tr.filter = { self, self.Target }
		tr.mask = MASK_SOLID_BRUSHONLY
		trace = util.TraceLine( tr )
		
		self.TargetDistance = self:GetPos():Distance( self.Target:GetPos())
		self.MaxAng = self.MaxAng or 100
		
		local logic1 = ( self.TargetDistance > 4000 )
		local logic2 = ( self.Yaw > -10 && self.Yaw < 10 )
		local targetVelocity = self.Target:GetVelocity():Length()
		
		if( self.Target:OnGround() && logic1 && logic2 && self.Target != self.Owner ) then // Fly in, shoot, leave.
			
			self.PavePenny:SetPos( self.Target:GetPos() + self.Target:GetUp() * 32 + self.Target:GetForward() * 128 )
			
			self.Owner:EmitSound("lockon/voices/engagingbandit.mp3",511,100)
			self:DoPrimaryAttack()
			
		elseif( self.Target:OnGround() && !logic1 || trace.HitWorld ) then
		
			local p = self.Target:GetPos() + self.Target:GetUp() * 2048
			
			p.x = p.x + math.sin(CurTime()) * 1024
			p.x = p.y + math.cos(CurTime()) * 1024
			
			self.PavePenny:SetPos( p )
			
			self.MaxVelocity = 3000
			self.MaxAng = self.MAV_Low
			self.BankingFactor = 3
			
		elseif ( !self.Target:OnGround() && !trace.HitWorld ) then
			
			if( self.Target == self.Owner ) then
				
				self.PavePenny:SetPos( self.Target:LocalToWorld( self.CycleOffset + Vector( math.sin( CurTime() * self:EntIndex() * 10 ) * 1200 ), math.cos(CurTime() * self:EntIndex() * 10 ) * 1200, 0 ) )
			
			else
			
				self.PavePenny:SetPos( self.Target:GetPos() + self.Target:GetForward() * 1024 + self.Target:GetUp() * 512 )
			
			end
			
			if ( targetVelocity > 2000 ) then
				
				self.MaxVelocity = targetVelocity // Match opponents speed
				self.MaxAng = self.MAV_High
				self.BankingFactor = self.DefaultBankingFactor
			
			else
			
				self.MaxVelocity = 1200
				self.MaxAng = self.MAV_Low
				self.BankingFactor = 2.5
			
			end
			
		end
		
		
		
		/*
		if ( IsValid( self.Owner) && self.Owner.Speed > 0 && self.Target == self.Owner ) then
		
			self.MaxVelocity = self.Owner.Speed
		
			self.MaxAng = self.MAV_Low
			self.BankingFactor = 4.2
			
		end */
		
		self.Pilot:PointAtEntity( self.PavePenny )
		--print( "Pointing at PavePenny")
		
		// Lock-on method
		local smallcone = ( self.Yaw > -5 && self.Yaw < 5 && self.Pitch > -5 && self.Pitch < 5 && self.TargetDistance < 10000 )
		
		if ( smallcone && self.Owner != self.Target ) then
			
			self:DoPrimaryAttack()
			
		end
		
		// Secondary Attack
		local id = nil
		local wep = NULL
		
		// Cycle through the weapons every 2 sec.
		if ( self.LastWepCycle + 2 <= CurTime() ) then
			
			self.LastWepCycle = CurTime()
			
			self.FireVar = self.FireVar + 1
			
			if ( self.FireVar > self.NumRockets ) then
				
				self.FireVar = 1
			
			end
			
			// Lookup the real weapon ID.	
			id = self.EquipmentNames[ self.FireVar ].Identity
			// Inherit the weapons stats to prepare for the attack method.
			wep = self.RocketVisuals[ self.FireVar ]

			
		end
		
		if ( IsValid( wep ) ) then
		
			if ( wep.LastAttack + wep.Cooldown <= CurTime() ) then
				
				local logic = ( self.Yaw > -45 && self.Yaw < 45 && self.Pitch > -45 && self.Pitch < 45 )
				
				
				if( self.Target:IsPlayer() && !IsValid( self.Target:GetScriptedVehicle() ) && wep.Type == "Singlelock" ) then
					
					self.Owner:EmitSound("lockon/voices/missileAway.mp3",511,100)
					
					local r = ents.Create( wep.Class )
					r:SetPos( wep:GetPos() + wep:GetForward() * 72 )
					r:SetModel( wep:GetModel() )
					r:SetOwner( self )
					r:SetPhysicsAttacker( self.Owner.Pilot )
					r.Target = self.Target
					r:Spawn()
					r:Fire("Kill","",20)
					r:SetAngles( wep:GetAngles() )
					r:SetVelocity( self:GetVelocity() )
					r:EmitSound( "weapons/rpg/rocketfire1.wav", 511, 80 )
					
					return
					
				end
				
				if ( logic && IsValid( self.Target ) && self.Target != self.Owner && wep.Type == "Homing" ) then
		
					self.Owner:EmitSound("lockon/voices/missileAway.mp3",511,100)
					self:SecondaryAttack( wep )
					
					return
					
				end	
				
			end
		
		end
			
	else
	
		self.Target = self.CycleTarget
		
	end
	
end


function ENT:SpawnFlare()
	
	local f = ents.Create("nn_flare")
	f:SetPos( self:GetPos() + self:GetUp() * -8 + self:GetForward() * 256 )
	f:SetAngles( self:GetAngles() )
	f:Spawn()
	f:SetOwner( self )
	f:Fire("kill","",5)
	f:GetPhysicsObject():SetMass( 100 )
	f:SetVelocity( self:GetVelocity() * 5000 )
	f:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 50000 )
	f:EmitSound( "weapons/flaregun/fire.wav",311, 100 )
	
	timer.Simple( math.random(1,2), 
					function(a,b,c)
					
						if ( IsValid( self ) ) then
						
							for k,v in pairs( ents.GetAll() ) do
							
								local c = v:GetClass()
								
								local logic = ( string.find( c, "rocket" ) != nil ||
												string.find( c, "missile" ) != nil ||
												string.find( c, "rpg" ) != nil ||
												string.find( c, "homing" ) != nil ||
												string.find( c, "heatseek" ) != nil ||
												string.find( c, "fire" ) )
								
								local logic2 = ( v:GetOwner() != self )
								
								if ( logic && logic2 && v:GetPos():Distance( self:GetPos() ) < 3000 ) then
									
									if ( !IsValid( v.Target ) ) then
										
										v:ExplosionImproved()
										v:SetNetworkedEntity("Target",nil)
										v:Remove()
										
									else
									
										v.Target = r
										
									end
									
								end
								
							end
							
						end
						
					end	)
	
end

function ENT:PrimaryAttack()
	
 	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 805
 	bullet.Dir 		= self.Weapon:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( .019, .019, .019 )				// Aim Cone 
 	bullet.Tracer	= 1											// Show a tracer on every x bullets  
 	bullet.Force	= 450					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 40, 45 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "GunshipTracer" 
 	bullet.Callback    = function ( a, b, c )
							
							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 4.5 )
							util.Effect("ManhackSparks", e)

							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 1.5 )
							util.Effect("HelicopterMegaBomb", e)
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 256, math.random(20,45) )
							
							return { damage = true, effects = DoDefaultEffect } 
							
						end 
 	
	self.Weapon:FireBullets( bullet )
	
	self.Weapon:EmitSound( "ah64fire.wav", 511, 140 )
	
	local effectdata = EffectData()
	effectdata:SetStart( self.Weapon:GetPos() + self:GetForward() * 140 )
	effectdata:SetOrigin( self.Weapon:GetPos() + self:GetForward() * 140 )
	effectdata:SetEntity( self.Weapon )
	effectdata:SetNormal( self:GetForward() )
	util.Effect( "a10_muzzlesmoke", effectdata )  

	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep )
	
	if ( !IsValid( self.Target ) ) then
		
		return
	
	else
		
		self:LaunchHoming( wep )
		
	end

	wep.LastAttack = CurTime()
	
end

function ENT:LaunchHoming( wep )
	
	
	if ( IsValid( wep ) ) then
	
		local r = ents.Create( wep.Class )
		r:SetPos( wep:GetPos() + wep:GetForward() * 72 )
		r:SetModel( wep:GetModel() )
		r:SetOwner( self )
		r:SetPhysicsAttacker( self.Owner.Pilot )
		r.Target = self.Target
		r:Spawn()
		r:Fire("Kill","",20)
		r:SetAngles( wep:GetAngles() )
		r:SetVelocity( self:GetVelocity() )
		self:EmitSound( "weapons/rpg/rocketfire1.wav", 511, 80 )
	
	end
	
end

function ENT:SetTarget ( t )

	self.Target = t

end

function ENT:ClearTarget()

	self.Target = NULL // Clear Target

end

function ENT:FindAvoidancePoint( pos, dir, length )

	local tr,trace = {},{}
	tr.start = pos
	tr.endpos = pos + dir * length
	tr.filter = self
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	local newPos = nil
	
	if ( trace.Hit ) then
			
		newPos = trace.HitPos + trace.HitNormal * ( length * 2 )
		self:DrawLaserTracer( pos,trace.HitPos )
		self:DrawLaserTracer( trace.HitPos, newPos )
		
	end
	
	return newPos
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	--print( IsValid( self.Pilot ), IsValid( self.Target ) )
	
	if ( IsValid( self.Pilot ) && IsValid( self.Target ) ) then
			
		--print( "Physics Simulate")
		--print( "Speed:", self.Speed )
		
		
		if  ( self.Speed >	self.MaxVelocity ) then
		
			self.Speed = self.Speed - 2
			self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity * 10 )
			
		else
			
			self.Speed = self.Speed + 1
			self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
			
		end
		
		local a = self.Pilot:GetPos() + self.Pilot:GetForward() * 2000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r
		
		local fpos = self:FindAvoidancePoint( self:GetPos(), self:GetForward(), 8000 )

		if ( IsValid( self.PavePenny ) ) then
			
			if ( fpos ) then
				
				self.PavePenny:SetPos( fpos )

			end
		
		end

		local pr = {}
		local pilotAng = self.Pilot:GetForward():Angle()
		
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed
		pr.maxangular		= self.MaxAng // 400
		pr.maxangulardamp	= self.MaxAng // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime

		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			
		end
		
		pr.angle = pilotAng + Angle( 0, 0, r )
		
		
		phys:ComputeShadowControl(pr)
	
	end

end


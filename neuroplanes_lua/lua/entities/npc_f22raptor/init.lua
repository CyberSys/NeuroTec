AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/hawx/air/fa-22 raptor.mdl"
//Speed Limits
ENT.MaxVelocity = 4500
ENT.MinVelocity = 1000

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.DefaultBankingFactor = 2.2
ENT.BankingFactor = 2.2

// MAV = Max Angular Velocity
ENT.MAV_High = 95
ENT.MAV_Low = 50

ENT.InitialHealth = 4000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 2000
ENT.DeathTimer = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 5

ENT.LockOn = false

// Equipment
ENT.MachineGunModel = "models/h500_gatling.mdl"
ENT.MachineGunOffset =  Vector( 250, -65, 90 )

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.15


function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	self.LastPrimaryAttack = CurTime()
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
	
	
	self.Armament = {

					{ 
						PrintName = "AIM-132 ASRAAM"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-132 asraam.mdl",  		// model, used when creating the object
						Pos = Vector( 0, 0, 0 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 20, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.

					}; 

					{ 
						PrintName = "AIM-120 AMRAAM", 
						Mdl = "models/hawx/weapons/aim-120 amraam.mdl",	 
						Pos = Vector( 0, 0, 0 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 20,
						isFirst	= nil,
						Class = "sent_a2a_rocket"
					};

					{ 
						PrintName = "AGM-84 Harpoon", 
						Mdl = "models/hawx/weapons/agm-84 harpoon.mdl",	 
						Pos = Vector( 0, 0, 0 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 25,
						isFirst	= nil,
						Class = "sent_a2a_rocket"
					}; 
					{ 
						PrintName = "AIM-07 Sparrow", 
						Mdl = "models/hawx/weapons/aim-07 sparrow.mdl",	 
						Pos = Vector( 0, 0, 0 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 23,
						isFirst	= nil,
						Class = "sent_a2a_rocket"
					}; 

				}
	
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
	self.Weapon:SetParent( self )
	self.Weapon:SetColor( Color( 0,0,0,0 ) )
	self.Weapon:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Weapon:Spawn()
	
	// reference point on the map, should probably use tracelines to verify the spot so the plane wont fly into stuff.
	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos( self:GetPos() + Vector(1024,1024,1024))
	self.CycleTarget:Spawn()
	
	// Misc
	self:SetModel( self.Model )	
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
	
	if ( self.Target == self.CycleTarget && IsValid( dmginfo:GetInflictor() ) ) then
		
		self.Target = dmginfo:GetInflictor()
	
	end

	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < 600 && !self.Burning ) then
	
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
	
	if ( self.HealthVal < 5 ) then
		self:GetPhysicsObject():AddAngleVelocity( Angle( 0, 10000, 00+0*math.random(0,10) ) )
		self:GetPhysicsObject():ApplyForceCenter( Vector(0,0,-100*math.random(0,10))   )
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
	end
	
end

function ENT:OnRemove()

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
	
	end
	
	self.PavePenny:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.7 && data.DeltaTime > 0.2 ) then 

		local explo = EffectData()
		explo:SetOrigin(self:GetPos())
		explo:SetScale( 1.50 )
		explo:SetNormal(data.HitNormal)
		util.Effect( "nn_explosion", explo )
		
		util.BlastDamage( self, self, data.HitPos, 2048, 500)

		self:ExplosionImproved()
		
		self.Entity:Remove()
			
	end
	
end

function ENT:ScanForEnemiesSpecial()

	local dist = dist or 25600
	local tempd = tempd or 0
	local t = t or self.CycleTarget

	for k,v in pairs( ents.FindInSphere( self:GetPos(), 25600 ) ) do

		if ( v != self && v:GetClass() != self:GetClass() && v:GetClass() != "npc_missile_homer" ) then
		
			if ( v:IsPlayer() || v:IsNPC() || ( v:IsVehicle() && v:GetVelocity():Length() > 1 ) || string.find( v:GetClass(), "npc_" ) )  then
			
				if( v.Destroyed ) then 
				
					return 
				
				end
				
				tempd = self:GetPos():Distance( v:GetPos() )
				
				if ( tempd < dist ) then
					
					dist = tempd
					t = v
					
				end
				
				self.Target = t
				
			end
			
		end
		
		if ( !IsValid( self.Target ) ) then //better safe than sorry
		
			self.Target = self.CycleTarget
			
		end
		
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
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:Remove()
		
		end
		
	end
	
	local tr,trace = {},{}
	tr.start = self:GetPos() + self:GetForward() * 1024
	tr.endpos = self:GetPos() + self:GetForward() * 11000
	tr.filter = { self, self.Pilot }
	tr.mask = MASK_SOLID
	trace = util.TraceEntity( tr, self )
	
	local e = trace.Entity
	
	local logic = ( IsValid( e ) && ( e:IsNPC() || e:IsPlayer() || e:IsVehicle() || type(e) == "CSENT_vehicle" ) )
	
	if ( logic && e != self && e:GetOwner() != self && e:GetOwner() != self.Pilot && e:GetClass() != self:GetClass() ) then
		
		self:ClearTarget()
		self:SetTarget( e )
		self.LockOn = true
		
	else
	
		if ( !self.LockOn ) then
			
			self:ScanForEnemiesSpecial()
			
		end
		
	end
		
	if( IsValid( self.Target ) ) then
	if not(self.Destroyed) then		
		// Movement stuff
		local a = ( self.Target:GetPos() - self:GetPos() ):Angle()
		local b =  Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	
		self.Yaw = self:VecAngD( a.y, b.y )
		self.Pitch = self:VecAngD( a.p, b.p )
		
		local trace2,tr = {},{}
		tr.start = self.Target:GetPos()
		tr.endpos = tr.start - Vector(0,0,1000)
		tr.filter = { self, self.Target }
		tr.mask = MASK_SOLID_BRUSHONLY
		trace2 = util.TraceLine( tr )
		
		self.TargetDistance = self:GetPos():Distance( self.Target:GetPos())
		self.MaxAng = self.MaxAng or 100
		
		local logic1 = ( self.TargetDistance > 4000 )
		local logic2 = ( self.Yaw > -10 && self.Yaw < 10 )
		local targetVelocity = self.Target:GetVelocity():Length()
		local myVelocity = self:GetVelocity():Length()
		
		if( self.Target:OnGround() && logic1 && logic2 ) then // Fly in, shoot, leave.
			
			self.PavePenny:SetPos( self.Target:GetPos() + self.Target:GetUp() * 32 )
			
			self:DoPrimaryAttack()
			
		elseif( self.Target:OnGround() && !logic1 || trace2.HitWorld ) then
		
			local p = self.Target:GetPos() + self.Target:GetUp() * 2048
			
			p.x = p.x + math.sin(CurTime()) * 1024
			p.x = p.y + math.cos(CurTime()) * 1024
			
			self.PavePenny:SetPos( p )
			
			self.MaxVelocity = 3000
			self.MaxAng = self.MAV_Low
			self.BankingFactor = 3
			
		elseif ( !self.Target:OnGround() && !trace2.HitWorld ) then
		
			self.PavePenny:SetPos( self.Target:GetPos() + self.Target:GetForward() * 1024 + self.Target:GetUp() * 512 )
			
			if ( targetVelocity > 2000 ) then
				
				self.MaxVelocity = targetVelocity * 1.2 // Match opponents speed
				self.MaxAng = self.MAV_High
				self.BankingFactor = self.DefaultBankingFactor
			
			else
			
				self.MaxVelocity = 2200
				self.MaxAng = self.MAV_Low
				self.BankingFactor = 2.5
			
			end
			
		end

		if (  self.Target == self.CycleTarget ) then
		
			self.MaxVelocity = 1500
			self.MaxAng = self.MAV_Low
			self.BankingFactor = 4.2
			
		end
		
		// We're flying towards a wall or something
		if ( ( trace.HitWorld || trace.HitSky ) && trace.HitPos:Distance( self:GetPos() ) < myVelocity * 1.5 ) then
			
			// Far from an ideal solution but it'll do for now.
			self.PavePenny:SetPos( self:GetPos() + self:GetForward() * -myVelocity * 2.5 )
			self:NextThink( CurTime() + 0.2 )
			
		end
		
		self.Pilot:PointAtEntity( self.PavePenny )

		// Lock-on method
		local smallcone = ( self.Yaw > -5 && self.Yaw < 5 && self.Pitch > -5 && self.Pitch < 5 && self.TargetDistance < 9001 )
		
		if ( smallcone ) then
			
			self:DoPrimaryAttack()
			
			if ( !self.Target:OnGround() ) then
				
				self.LockOn = true
			
			end
			
		end
		
		// Secondary Attack
		local id = nil
		local wep = nil
		
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
				
				local logic = ( self.Yaw > -11 && self.Yaw < 11 && self.Pitch > -11 && self.Pitch < 11 )
				local logic2 = ( self.Yaw > -4 && self.Yaw < 4 && self.Pitch > -4 && self.Pitch < 4 && self.Target:OnGround() )
				
				if( logic2 ) then
					
					if ( wep.Type == "Lasercannon" ) then
		
						for i = 1, 36 do
							
							timer.Simple( i / 70, function() self:DrawLaser( wep ) end )

						end
						
					end
					
				end
				
				if ( self.LockOn && wep.Type == "Homing" ) then
					
					self.LockOn = false
			
					self:SecondaryAttack( wep )
					
				end	
				
			end
		
		end
			
	else
	
		self.Target = self.CycleTarget
		self.LockOn = false
		
	end
	end
end


function ENT:DrawLaser( wep )
	
	if( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	local p = wep:GetPos()
	local ep = p + wep:GetForward() * 25000
	local tr,trace = {},{}
	tr.start = p
	tr.endpos = ep
	tr.filter = { self, self.Weapon, wep, self.Pilot }
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	local hp = trace.HitPos + Vector( math.random(-32,32),math.random(-32,32),math.random(-32,32) )
	
	for i = 1, 5 do
	
		local fx = EffectData()
		fx:SetOrigin( hp )
		fx:SetStart( p )
		fx:SetScale( 3.0 )
		fx:SetEntity( wep )
		util.Effect( "TraceBeam", fx )
		
	end
	
	local fx = EffectData()
	fx:SetOrigin( hp )
	fx:SetStart( p )
	fx:SetScale( 3.0 )
	fx:SetEntity( wep )
	util.Effect( "LaserTracer", fx )
	
	local fx = EffectData()
	fx:SetOrigin( hp )
	fx:SetStart( hp )
	fx:SetScale( 1.0 )
	fx:SetEntity( wep )
	fx:SetNormal( trace.HitNormal )
	util.Effect( "VortDispel", fx )
	
	local fx = EffectData()
	fx:SetOrigin( hp )
	fx:SetStart( hp )
	fx:SetNormal( trace.HitNormal )
	util.Effect( "HelicopterMegaBomb", fx )
	
	util.BlastDamage( self.Pilot, self.Pilot, hp, 256, 7 )
	

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
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 705
 	bullet.Dir 		= self.Weapon:GetAngles():Forward()		// Dir of bullet 
 	bullet.Spread 	= Vector( .019, .019, .019 )				// Aim Cone 
 	bullet.Tracer	= math.random( 2, 4 )					// Show a tracer on every x bullets  
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
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 150, 8 )
							
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
		r:SetPos( wep:GetPos() )
		r:SetModel( wep:GetModel() )
		r:SetOwner( self )
		r:SetPhysicsAttacker( self.Pilot )
		r.Target = self.Target
		r:Spawn()
		r:Fire("Kill","",20)
		r:SetAngles( wep:GetAngles() )
		r:SetVelocity( self:GetVelocity() )
		self:EmitSound( "weapons/rpg/rocketfire1.wav", 511, 80 )
		
		self:ClearTarget()
		
	end
	
end

function ENT:SetTarget ( t )

	self.Target = t

end

function ENT:ClearTarget()

	self.Target = nil // Clear Target

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
			
		newPos = trace.HitPos + trace.HitNormal * -( length * 2 )
		self:DrawLaserTracer( pos,trace.HitPos )
		self:DrawLaserTracer( trace.HitPos, newPos )
		
	end
	
	return newPos
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	if ( IsValid( self.Pilot ) && IsValid( self.Target ) ) then
		
	if not (self.Destroyed) then
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


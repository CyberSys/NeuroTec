AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.PrintName = "AH-64 Apache"
ENT.Model = "models/usmcapachelicopter.mdl"
//Speed Limits
ENT.MaxVelocity = 1350
ENT.MinVelocity = -800

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 2.9

ENT.InitialHealth = 3000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 50
ENT.DeathTimer = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/ac-130/gatling.mdl"
ENT.MachineGunOffset = Vector( 160, 0, -60 )
ENT.CrosshairOffset = -850

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.SecondaryCooldown = 5.0
ENT.SecondaryFireMode = true // Initial secondary firemode: true = dumbfire, false = homing

ENT.GotChopperGunner = false

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_ah64apache" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)

	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.ChopperGunAttack = CurTime()
	self.LastChopperGunToggle = CurTime() 
	self.LastSecondaryKeyDown = CurTime()
	
	self.MinigunRevolve = 0
	self.HoverVal = 100
	self.MoveRight = 0
	
	
	/* List of types:
		Homing
		Laser // Laser Guided - Optional: specify Damage / Radius for these, see below.
		Bomb
		Dumb
		Pod
		Effect
	*/
	 

	self.Armament = {
					{ 
						PrintName = "LAU-131A Rocket Pod"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
						Pos = Vector( 15, 82, -47), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 17, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					}; 
					{ 
						PrintName = "LAU-131A Rocket Pod"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
						Pos = Vector( 15, -82, -47), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 17, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					};
					


					{ 
						PrintName = "Python 5"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  		// model, used when creating the object
						Pos = Vector( 1, 91, -5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 17, 0, 45), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
					{ 
						PrintName = "Python 5"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  		// model, used when creating the object
						Pos = Vector( 1, -91, -5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 17, 0, 45), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
				}
	
	// Armamanet
	local i = 0
	local c = 0
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
		
		if ( v.Damage && v.Radius ) then
			
			self.RocketVisuals[i].Damage = v.Damage
			self.RocketVisuals[i].Radius = v.Radius
		
		end
		
		// Usuable Equipment
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
	
	self.LoopSound = CreateSound(self.Entity,Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
	self.LoopSound:PlayEx(511,110)
	self.LoopSound:SetSoundLevel(511)
	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = nil
	/*
	local o = self.MachineGunOffset
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( self.MachineGunModel )
	self.Weapon:SetPos( self:GetPos() + self:GetForward() * o.x + self:GetRight() * o.y + self:GetUp() * o.z  )
	self.Weapon:SetAngles( self:GetAngles() + Angle( 17, 0, 0 ) )
	self.Weapon:SetSolid( SOLID_NONE )
	self.Weapon:SetParent( self )
	self.Weapon:Spawn()
	*/
	self.ChopperGun = ents.Create("prop_physics_override")
	self.ChopperGun:SetModel( "models/airboatgun.mdl" )
	self.ChopperGun:SetPos( self:GetPos() + self:GetForward() * 175 + self:GetUp() * -99  )
	self.ChopperGun:SetAngles( self:GetAngles() + Angle( 25, 0, 0 ) )
	self.ChopperGun:SetSolid( SOLID_NONE )
	self.ChopperGun:SetParent( self )
	self.ChopperGun:Spawn()
	
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	self.Rotorwash = ents.Create("env_rotorwash_emitter")
	self.Rotorwash:SetPos( self:GetPos() )
	self.Rotorwash:SetParent( self )
	self.Rotorwash:SetKeyValue("altitude","",1024)
	self.Rotorwash:Spawn()
		
	self.PassengerSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PassengerSeat:SetPos( self:LocalToWorld( Vector( 60, 0, -15 ) ) )
	self.PassengerSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PassengerSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PassengerSeat:SetKeyValue( "LimitView", "60" )
	self.PassengerSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
	self.PassengerSeat:SetAngles( self:GetAngles() + Angle( -17, -90, 0 ) )
	self.PassengerSeat:SetParent( self )
	self.PassengerSeat:SetNoDraw( true )
	self.PassengerSeat:Spawn()
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(2000)
		self.PhysObj:EnableGravity( true )
		
	end

	self:StartMotionController()

end


function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	if( IsValid( self.Pilot ) ) then
	
		self.Pilot:ViewPunch( Angle( math.random(-2,2),math.random(-2,2),math.random(-2,2) ) )
	
	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -85 + self:GetRight() * -32 + self:GetUp() * 41 
		p[2] = self:GetPos() + self:GetForward() * -85 + self:GetRight() * 32 + self:GetUp() * 41 
		for _i=1,2 do
		
			local f = ents.Create("env_Fire_trail")
			f:SetPos( p[_i] )
			f:SetParent( self )
			f:Spawn()
			
		end
		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
	end
	
end

function ENT:OnRemove()

	self.LoopSound:Stop()
		
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.5 && data.DeltaTime > 0.2 ) then 
		
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.7 ) then
			
			self.HealthVal = self.HealthVal * 0.3
		
		else
			
			local explo = EffectData()
			explo:SetOrigin(self:GetPos())
			explo:SetScale(0.50)
			explo:SetNormal(data.HitNormal)
			util.Effect("nn_explosion", explo)
			
			util.BlastDamage( self, self, data.HitPos, 1024, 80)
			self:EjectPilotSpecial()
			self.Entity:Remove()
		
		end
		
		self:SetNetworkedInt("health",self.HealthVal)
		
	end
	
end

function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	self.Pilot:UnSpectate()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )
	self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Plane", NULL ) 
	self:SetNetworkedEntity("Pilot", NULL )
	self:SetNetworkedBool("ChopperGunner",false)
	self.GotChopperGunner = false
	self.Pilot:SetNetworkedBool( "isGunner", false )
	self.Pilot:SetNetworkedEntity("ChopperGunnerEnt", NULL )
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -80 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = nil
	-- self.Pilot:SetScriptedVehicle( nil )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity( Vector(0,0,0) )
	self.Pilot = nil
	
end
/*
function ENT:Use(ply,caller)

	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 

		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsFlying = true
		self.Pilot = ply
		self.Owner = ply
		
		ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Plane", self ) 
		self:SetNetworkedEntity("Pilot", ply )
		
		ply:SetNetworkedBool( "isGunner", true )
		ply:SetNetworkedEntity( "ChopperGunEnt", self.ChopperGun )
		
		self.Entered = CurTime()
		
	else
		
		local d = self.PassengerSeat:GetDriver()
		
		if( !IsValid( d ) ) then
			
			ply:EnterVehicle( self.PassengerSeat )
		
		end
		
	end
	
end
*/

function ENT:Use(ply,caller)
	
	self:NeuroPlanes_DefaultHeloUse( ply )
	
end

function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 50 + 100 ),0,205 )
	
	self.LoopSound:ChangePitch( self.Pitch, 0.01 )
	local seq = self:LookupSequence( "idle" )
	self:ResetSequence( seq )
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			self:Remove()
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 72 )
		
		// HUD Stuff
		self:UpdateRadar()
		
		// Lock On method
		self:Jet_LockOnMethod()
		
		// Clear Target 
		if ( self.Pilot:KeyDown( IN_SPEED ) && IsValid( self.Target ) ) then
			
			self:ClearTarget()
			self.Pilot:PrintMessage( HUD_PRINTCENTER, "Target Released" )
			
		end
		
		// Attack
		if ( self.Pilot:KeyDown( IN_ATTACK ) ) then
		
			if ( self.GotChopperGunner ) then
			
				if ( self.ChopperGunAttack + 0.2 <= CurTime() ) then
					
					self:FuselageAttack()
					
				end
				
			else
				
				if ( self.ChopperGunAttack + 0.2 /* self.LastPrimaryAttack + 0.2 self.PrimaryCooldown */ <= CurTime() ) then
					
					self:FuselageAttack()
					
					/*
					self.MinigunRevolve = self.MinigunRevolve + 0.1
					
					if ( self.MinigunRevolve >= 2 ) then
						
						self:PrimaryAttack()
					end
					*/
					
				end
			
			end
			
		end
		/*	
		if ( !self.GotChopperGunner ) then
			
			// Ugly
			local eyeAng = self.Pilot:EyeAngles()
			local myAng = self:GetAngles()
			
			if ( eyeAng.y > myAng.y + 50 ) then
			
				eyeAng.y = myAng.y + 50
				
			elseif( eyeAng.y < myAng.y -50 ) then
			
				eyeAng.y = myAng.y -50
				
			end

			eyeAng.r = myAng.r
			
			self.ChopperGun:SetAngles( LerpAngle( 0.123, self.ChopperGun:GetAngles(), eyeAng ) )
		
		end
		*/
		
		if ( self.LastSecondaryKeyDown + 0.5 <= CurTime() && self.Pilot:KeyDown( IN_ATTACK2 ) && !self.Pilot:GetNetworkedBool( "isGunner", false ) ) then
		
			local id = self.EquipmentNames[ self.FireMode ].Identity
			local wep = self.RocketVisuals[ id ]
			self.LastSecondaryKeyDown = CurTime()
			
			if ( wep.LastAttack + wep.Cooldown <= CurTime() ) then
			
				self:SecondaryAttack( wep, id )
				
			else
			
	
				local cd = math.ceil( ( wep.LastAttack + wep.Cooldown ) - CurTime() ) 
				
				if ( cd == 1 ) then 
				
					self.Pilot:PrintMessage( HUD_PRINTTALK, self.PrintName..": "..wep.PrintName.." ready in "..tostring( cd ).. " second." )
				
				else
				
					self.Pilot:PrintMessage( HUD_PRINTTALK, self.PrintName..": "..wep.PrintName.." ready in "..tostring( cd ).. " seconds." )	
				
				end
				
			end
	
		end
		
		/*
		if ( self.Pilot:KeyDown( IN_ZOOM ) && self.LastChopperGunToggle + 1.0 <= CurTime() ) then
			
			self.LastChopperGunToggle = CurTime() 
			self.GotChopperGunner = !self.GotChopperGunner
			self:SetNetworkedBool("ChopperGunner",self.GotChopperGunner)
			self.Pilot:SetNetworkedBool( "isGunner", !self.GotChopperGunner )
			
		end	*/
		
		local eyeAng
		local myAng = self:GetAngles()

		if( IsValid( d ) && d:IsPlayer() ) then 
			
			eyeAng = d:EyeAngles()
			
			if ( d:KeyDown( IN_ZOOM ) && self.LastChopperGunToggle + 1.0 <= CurTime() && !IsValid( self.LaserGuided ) ) then
								
		
				self.LastChopperGunToggle = CurTime()
				self.GotChopperGunner = !self.GotChopperGunner
				d:SetNetworkedBool( "isGunner", self.GotChopperGunner )
				d:SetNetworkedEntity( "ChopperGunEnt", self.ChopperGun )
				d:SetNetworkedEntity( "NeuroPlanes_Helicopter", self )
				
			end
		
		else
			
			eyeAng = self.Pilot:EyeAngles()
			
			if ( self.Pilot:KeyDown( IN_ZOOM ) && self.LastChopperGunToggle + 1.0 <= CurTime() && !IsValid( self.LaserGuided ) ) then
				
				self.LastChopperGunToggle = CurTime()
				self.GotChopperGunner = !self.GotChopperGunner
				self.Pilot:SetNetworkedBool( "isGunner", self.GotChopperGunner )
				self.Pilot:SetNetworkedEntity( "ChopperGunEnt", self.ChopperGun )
				
				//print( "Values: ", self.GotChopperGunner, self.Pilot:GetNetworkedBool("isGunner", false), self.Pilot:GetNetworkedEntity("ChopperGunnerEnt",nil) )
	
			end
		
		end
		
		eyeAng.r = myAng.r

		if ( eyeAng.y > myAng.y + 85 ) then
		
			eyeAng.y = myAng.y + 85
			
		elseif( eyeAng.y < myAng.y -85 ) then
		
			eyeAng.y = myAng.y -85
			
		end
		
		if ( eyeAng.p > myAng.p + 70 ) then
		
			eyeAng.p = myAng.p + 70
			
		elseif( eyeAng.p < myAng.p -4 ) then
		
			eyeAng.p = myAng.p -4
			
		end
		
		self.ChopperGun:SetAngles( LerpAngle( 0.223, self.ChopperGun:GetAngles(), eyeAng ) )
		
		// Firemode 
		if ( self.Pilot:KeyDown( IN_RELOAD ) && self.LastFireModeChange + 0.5 <= CurTime() ) then
			
			//self.LastFireModeChange = CurTime()
			//self.FireMode = self:IncrementFireVar( self.FireMode, self.NumRockets, 1 )
			//self.Pilot:PrintMessage( HUD_PRINTCENTER, "Selected Equipment: "..self.EquipmentNames[ self.FireMode ].Name )
			self:CycleThroughWeaponsList()
			
		end
		
		// Flares
		if ( self.Pilot:KeyDown( IN_SCORE ) && !self.isHovering && self.FlareCount > 0 && self.LastFlare + self.FlareCooldown <= CurTime() && self.LastFireModeChange + 0.2 <= CurTime() ) then
			
			self.LastFireModeChange = CurTime()
			self.FlareCount = self.FlareCount - 1
			self:SetNetworkedInt( "FlareCount", self.FlareCount )
			self:SpawnFlare()
			
			if ( self.FlareCount == 0  ) then
			
				self.LastFlare = CurTime() 
				self.FlareCount = self.MaxFlares
				
			end
			
		end
	
		if ( self.Pilot:KeyDown( IN_USE ) && self.Entered + 1.0 <= CurTime() ) then

			self:EjectPilotSpecial()
			
		end	
		
		// Ejection Situations.
		if ( self:WaterLevel() > 0 ) then
		
			self:EjectPilotSpecial()
			
		end

	end
	
		
	self:NextThink( CurTime() )
		
	return true
	
end


function ENT:FuselageAttack()

	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.ChopperGun:GetPos() + self.ChopperGun:GetForward() * 45
 	bullet.Dir 		= self.ChopperGun:GetAngles():Forward()						// Dir of bullet 
 	bullet.Spread 	= Vector( .019, .019, .019 )								// Aim Cone 
 	bullet.Tracer	= 1															// Show a tracer on every x bullets  
 	bullet.Force	= 50					 									// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 15, 25 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c )
								
							self:ChopperGunCallback( a, b, c )
							
						end 
 	local e = EffectData()
	e:SetStart( self.ChopperGun:GetPos()+self:GetForward() * 62 )
	e:SetOrigin( self.ChopperGun:GetPos()+self:GetForward() * 62 )
	e:SetEntity( self.ChopperGun )
	e:SetAttachment( 1 )
	util.Effect( "StriderMuzzleFlash", e )
	
	self.ChopperGun:FireBullets( bullet )
	
	self.ChopperGun:EmitSound( "helo.wav", 510, 98 )

	self.ChopperGunAttack = CurTime()
	
end

function ENT:ChopperGunCallback( a, b, c )
	if ( IsValid( self.Pilot ) ) then
	
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
		
		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 512, math.random( 15, 45 ) )
		
		end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
 	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 125 + self:GetUp() * -16
 	bullet.Dir 		= self.Weapon:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( .021, .021, .021 )				// Aim Cone 
 	bullet.Tracer	= 3											// Show a tracer on every x bullets  
 	bullet.Force	= 450					 					// Amount of force to give to phys objects 
 	bullet.Damage	= 0
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
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
							util.Effect("impact_Fx", e)
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 512, math.random(5,8) )
							
							return { damage = true, effects = DoDefaultEffect } 
							
						end 
						
	 local effectdata = EffectData()
	effectdata:SetStart( self.Weapon:GetPos() + self.Weapon:GetForward() * 100 )
	effectdata:SetOrigin( self.Weapon:GetPos() + self.Weapon:GetForward() * 100 )
	effectdata:SetEntity( self.Weapon )
	effectdata:SetNormal( self:GetForward() )
	util.Effect( "a10_muzzlesmoke", effectdata )
	
	self.Weapon:FireBullets( bullet )
	
	self.Weapon:EmitSound( "move.mp3", 510, 98 )
	
	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local a = self:GetAngles()
	local p,r = a.p,a.r
	//local stallAng = ( p > 90 || p < -90 || r > 90 || r < -90 )
	
	if ( self.IsFlying ) then
		
		phys:Wake()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
	
		local maxang = 60

		local vel = self:GetVelocity():Length()
		
		if ( vel > -200 && vel < 700 ) then
			
			self.isHovering = true
			
			self.BankingFactor = 7
		
		else
		
			self.isHovering = false

			self.BankingFactor = 4.8
			
	
		end
	
		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 2.15
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 2.25
		
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -500, 500 )
		
		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			
		end
		
		if ( self:GetVelocity():Length() < 1000 ) then 
		
			if ( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
				
				self.MoveRight = self.MoveRight - 9
				r  = -25
				
			elseif (  self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
				
				self.MoveRight = self.MoveRight + 9
				r = 25
				
			else
				
				self.MoveRight = math.Approach( self.MoveRight, 0, 1 )
			
			end

			self.MoveRight = math.Clamp( self.MoveRight, -656, 656 )
		
		else
		
			self.MoveRight = math.Approach( self.MoveRight, r * 4.5, 1.15 )
		
		end
		
		if ( ma.p > -4 ) then
			
			local x = ma.p
			
			if ( x < 0 ) then
				
				x = 1.25
			
			else
				
				x = ma.p / 2.5
			
			end

			self.Speed = self.Speed + x
		
		elseif ( ma.p < -22 ) then
			
			self.Speed = self.Speed + ma.p / 5.5
		
		elseif ( ma.p > -5 && ma.p < 0 ) then
		
			self.Speed = self.Speed / 1.005
		
		end
		
		if ( self.GotChopperGunner && !IsValid( self.PassengerSeat:GetDriver() )  ) then
			
			if ( pilotAng.p < 15 || pilotAng.p > 300 ) then pilotAng.p = 15 end
			
			self.ChopperGun:SetAngles( pilotAng )
			
			if ( self.Pilot:KeyDown( IN_FORWARD ) ) then
			
				pilotAng.p = 25
			
			elseif ( self.Pilot:KeyDown( IN_BACK ) ) then
				
				pilotAng.p = -10	
				
			else
			
				pilotAng.p = 5
			
			end

		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) ) then
			
			// Pull up the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 500 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
				
				if( self.Speed > 100 ) then
				
					pilotAng.p = -35
					
				elseif( self.Speed < -100 ) then
				
					pilotAng.p = 35
				
				end
				
				self.HoverVal = self.HoverVal / 1.05
				
			else
				
				pilotAng.p = 1.0 + ( math.sin( CurTime() - (self:EntIndex() * 10 ) ) / 2 )
			
			end
			
			self.Speed = self.Speed / 1.0051
		
		end
		
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		local pr = {} 
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight
		
		pr.secondstoarrive	= 1
		pr.pos 				= desiredPos
 		pr.maxangular		= maxang // 400
		pr.maxangulardamp	= maxang // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = pilotAng + Angle( -17, 0, r )
		
		phys:ComputeShadowControl(pr)
		
	end
	
end


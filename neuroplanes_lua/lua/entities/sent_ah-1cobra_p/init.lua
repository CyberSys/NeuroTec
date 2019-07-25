// Use this as base for helicopters with physical rotors.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_ah-1cobra_p" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastSecondaryKeyDown = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.ChopperGunAttack = CurTime()
	self.LastChopperGunToggle = CurTime() 
	self.LastLaserUpdate = CurTime()

	self.MinigunRevolve = 0
	self.HoverVal = 0
	self.MoveRight = 0
	self.RotorVal = 0
	self.MaxRotorVal = 1600
	self.RotorMult = self.MaxRotorVal / 2000
	self.Started = false
	self.SpinUp = 0
	
	
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
						Pos = Vector( 5, 45, -23), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					}; 
					{ 
						PrintName = "LAU-131A Rocket Pod"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
						Pos = Vector( 5, -45, -23), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_rocket"								// the object that will be created.
					};
					


					{ 
						PrintName = "AIM-9 Sidewinder"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( 19, 81, -32), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
					{ 
						PrintName = "AIM-9 Sidewinder"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( 19, -81, -32), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
					{ 
						PrintName = "Python 5"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  		// model, used when creating the object
						Pos = Vector( 19, 81, -16), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
					{ 
						PrintName = "Python 5 \"Jericho\""		,		 		// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  				// model, used when creating the object
						Pos = Vector( 19, -81, -5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 								// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 20, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_jericho"								// the object that will be created.
					}; 
					{
						PrintName = "AGM-65 Maverick"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",  		// model, used when creating the object
						Pos = Vector( 30, -66, -32), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 								// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 5, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",
						Damage = 400,
						Radius = 2000
					}; 
					{ 
						PrintName = "AGM-65 Maverick"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",  		// model, used when creating the object
						Pos = Vector( 30, 66, -32), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 								// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",
						Damage = 400,
						Radius = 2000
					}; 
					{
						PrintName = "ALQ-131 ECM",
						Mdl = "models/hawx/weapons/alq 131 ecm.mdl",
						Pos = Vector( -25, 0, -47 ),
						Ang = Angle( 0, 0, 0 ),
						Type = "Flarepod",
						Cooldown = 0,
						isFirst = false,
						Class = ""
					};
				}
	
	self:NeuroPlanes_DefaultAttachEquipment()
	
	
--	self.LoopSound = CreateSound(self.Entity,Sound("bf2/AH1_start_idle_stop.wav"))
	-- self.LoopSound = CreateSound(self.Entity,Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
	-- 
	self.LoopSound = CreateSound(self.Entity,Sound( self.RotorSound ) )

	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = nil
	
	if( self.MountedGunModel != nil ) then
		
		self.ChopperGun = ents.Create("prop_physics_override")
		self.ChopperGun:SetModel( self.MountedGunModel )
		self.ChopperGun:SetPos( self:LocalToWorld( self.MountedGunPosition ) )
		self.ChopperGun:SetAngles( self:GetAngles() )
		self.ChopperGun:SetSolid( SOLID_NONE )
		self.ChopperGun:SetParent( self )
		self.ChopperGun:Spawn()
		self.ChopperGun:SetOwner( self )
		
		self.ChopperGunProp = ents.Create("prop_physics_override")
		self.ChopperGunProp:SetModel( "models/airboatgun.mdl" )
		self.ChopperGunProp:SetPos( self.ChopperGun:GetPos() + self.ChopperGun:GetForward() * 32 )
		self.ChopperGunProp:SetParent( self.ChopperGun )
		self.ChopperGun:SetSolid( SOLID_NONE )
		self.ChopperGunProp:SetAngles( self:GetAngles() )
		self.ChopperGunProp:Spawn()
		self.ChopperGunProp:SetColor( Color( 0,0,0,0 ) )
		self.ChopperGunProp:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.ChopperGunProp:SetOwner( self.ChopperGun )
		
	end
	
	self.RotorPropeller = ents.Create("sent_cobra_rotor")
	self.RotorPropeller:SetModel( self.RotorModel )
	self.RotorPropeller:SetPos( self:LocalToWorld( self.RotorPropellerPos  ) )
	self.RotorPropeller:SetAngles( self:GetAngles() )
	self.RotorPropeller:SetSolid( SOLID_VPHYSICS )
	self.RotorPropeller:Spawn()
	self.RotorPropeller.isTouching = false
	self.RotorPropeller:SetOwner( self )
	
	self.RotorPhys = self.RotorPropeller:GetPhysicsObject()	
	
	if ( self.RotorPhys:IsValid() ) then
	
		self.RotorPhys:Wake()
		self.RotorPhys:SetMass( self.MaxRotorVal )
		self.RotorPhys:EnableGravity( false )
		self.RotorPhys:EnableDrag( true )
		
	end

	self.TailPropeller = ents.Create("prop_physics")
	self.TailPropeller:SetModel( self.TailRotorModel )
	self.TailPropeller:SetPos( self:LocalToWorld( self.TailPropellerPos  ) )
	self.TailPropeller:SetAngles( self:GetAngles() )
	//self.TailPropeller:SetSolid( SOLID_NONE )
	self.TailPropeller:Spawn()
	self.TailPropeller:SetOwner( self )
	
	self.TailPhys = self.TailPropeller:GetPhysicsObject()
	
	if ( self.TailPhys:IsValid() ) then
	
		self.TailPhys:Wake()
		self.TailPhys:SetMass( 100 )
		self.TailPhys:EnableGravity( false )
		self.TailPhys:EnableCollisions( false )
		
	end
	
	if( self.MGunTurretPosition != nil ) then
	
		self.Turret = ents.Create("prop_physics_override")
		self.Turret:SetModel( self.MGunTurretModel )
		self.Turret:SetPos( self:LocalToWorld( self.MGunTurretPosition  ) )
		self.Turret:SetAngles( self:GetAngles() )
		self.Turret:SetSolid( SOLID_NONE )
		self.Turret:SetParent( self )
		self.Turret:Spawn()

	end
	
	if( self.RadarCamPos != nil ) then

		self.RadarCam = ents.Create("prop_physics_override")
		self.RadarCam:SetModel( self.RadarCamModel )
		self.RadarCam:SetPos( self:LocalToWorld( self.RadarCamPos ) )
		self.RadarCam:SetAngles( self:GetAngles() )
		self.RadarCam:SetSolid( SOLID_NONE )
		self.RadarCam:SetParent( self )
		self.RadarCam:Spawn()
		
	end
	
	if( self.PassengerSeatPos != nil ) then
		
		
		self.PassengerSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		self.PassengerSeat:SetPos( self:LocalToWorld( self.PassengerSeatPos ) )
		self.PassengerSeat:SetModel( "models/nova/jeep_seat.mdl" )
		self.PassengerSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.PassengerSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.PassengerSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		self.PassengerSeat:SetParent( self )
		self.PassengerSeat:SetColor( Color( 0,0,0,0 ) )
		self.PassengerSeat:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.PassengerSeat:Spawn()
		self.PassengerSeat.IsPassengerSeat = true
		
	end
	
	
	self.PilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PilotSeat:SetPos( self:LocalToWorld( Vector( 94, 0, 1 ) ) )
	self.PilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PilotSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
	self.PilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
	self.PilotSeat:SetParent( self )
	self.PilotSeat:Spawn()
	
	
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	constraint.NoCollide( self, self.RotorPropeller, 0, 0 )	
	constraint.NoCollide( self, self.TailPropeller, 0, 0 )	
	self.rotoraxis = constraint.Axis( self.RotorPropeller, self, 0, 0, Vector(0,0,1) , self.RotorPropellerPos, 0, 0, 1, 0 )
	self.tailrotoraxis = constraint.Axis( self.TailPropeller, self, 0, 0, Vector(0,1,0) , self.TailPropellerPos, 0, 0, 1, 0 )
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 200000 )
		self.PhysObj:EnableGravity( true )
		
	end

	self:SetNetworkedInt( "health", self.HealthVal )
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth", self.InitialHealth )
	self:SetNetworkedInt( "MaxSpeed", self.MaxVelocity )
	self:SetNetworkedEntity("NeuroPlanesMountedGun", self.ChopperGun )
	
	self:SetSkin( math.random( 0, 4 ) )
	self:StartMotionController()
	
end



function ENT:OnTakeDamage(dmginfo)

	self:NeuroPlanes_DefaultChopperTakeDmg( dmginfo )
	
end

function ENT:OnRemove()

	self:NeuroPlanes_DefaultChopperOnRemove()
	
end



function ENT:PhysicsCollide( data, physobj )

	self:NeuroPlanes_DefaultChopperPhysImpact( data, physobj )
	
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
	self.Pilot:SetNetworkedBool( "isGunner", false )
	self.GotChopperGunner = false
	self.Pilot:SetNetworkedEntity("ChopperGunnerEnt", NULL )
	
	self.Pilot:ExitVehicle()
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = nil
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
end

function ENT:Use(ply,caller)
	
	self:NeuroPlanes_DefaultHeloUse( ply )
	
end


function ENT:Think()

	self:NeuroPlanes_DefaultChopperWithGunnerThink()
		
	return true
	
end



function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local a = self:GetAngles()
	local p,r = a.p,a.r
	local stallAng = ( p > 90 || p < -90 || r > 90 || r < -90 )
	local topval = ( self.Pilot != nil && ( self.MaxRotorVal / 2 ) ) or 0 // Should not be > 500
	self.RotorVal = math.Approach( self.RotorVal, topval, self.RotorMult )	
	self.Started = ( self.RotorVal >= 350 ) // Loving the hard coded values <^.^> 


	if( IsValid( self.TailPropeller ) && IsValid( self.RotorPropeller ) ) then
	
		if( self.Started ) then

			self.TailPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, self.RotorVal * 2, 0 ) )
			self.RotorPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.RotorVal * 2 ) )
	
		else
		
			if ( self.RotorVal > 1 ) then
			
				self.SpinUpForce = self.SpinUpForce + 0.5
				
				self.TailPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, self.SpinUpForce, 0 ) )
				self.RotorPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.SpinUpForce ) )
	
			end
			
		end


	end

	
	if ( stallAng ) then
		
		self.Speed = self.Speed / 1.15
		
	end
	
	if ( self.IsFlying && !stallAng && self.Started && !self.Destroyed && !self.RotorPropeller.isTouching ) then
		
		phys:Wake()
		self:CreateRotorwash()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
		local maxang = 42

		local vel = self:GetVelocity():Length()
		if ( vel > -600 && vel < 600 ) then
			
			self.isHovering = true
			self.BankingFactor = 15
		
		else
		
			self.isHovering = false
			self.BankingFactor = 4
			
		end
	
		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 2.15
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 2.35
		
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -550, 600 )

		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0

		else

			r = ( self.offs / self.BankingFactor ) * -1

		end

		if ( self:GetVelocity():Length() < 1000 ) then 
		
			if ( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
				
				self.MoveRight = self.MoveRight - 7.5
				r  = -25
				
			elseif (  self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
				
				self.MoveRight = self.MoveRight + 7.5
				r = 25
				
			else
				
				self.MoveRight = math.Approach( self.MoveRight, 0, 0.995 )
			
			end

			self.MoveRight = math.Clamp( self.MoveRight, -556, 556 )
		
		else
		
			self.MoveRight = math.Approach( self.MoveRight, r * 10, 0.555 )
		
		end
		
		
		if ( self.GotChopperGunner && !IsValid( self.PassengerSeat:GetDriver() )  ) then
			
			if ( pilotAng.p < 5 || pilotAng.p > 300 ) then pilotAng.p = 5 end
			
			--self.ChopperGun:SetAngles( pilotAng )
			
			if ( self.Pilot:KeyDown( IN_FORWARD ) ) then
			
				pilotAng.p = 6
			
			elseif ( self.Pilot:KeyDown( IN_BACK ) ) then
				
				pilotAng.p = -6	
				
			else
			
				pilotAng.p = math.cos( CurTime() - ( self:EntIndex() * 10 ) ) * 1.25
			
			end

		end
		
		if ( ma.p > 2.5 ) then
	
			self.Speed = self.Speed + ma.p / 2.9
		
		elseif ( ma.p < -3 ) then
			
			self.Speed = self.Speed + ma.p / 2.5
		
		elseif ( ma.p > -3 && ma.p < 3 ) then
		
			self.Speed = self.Speed / 1.005
		
		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) || IsValid( self.LaserGuided ) ) then
			
			--// Pull up ( or down ) the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 400 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
				if( self.Speed > 0 ) then
					
					pilotAng.p = -15
				
				elseif( self.Speed < 0) then
					
					pilotAng.p = 25
					
				end
				
				self.HoverVal = self.HoverVal / 1.05
				
			else
				
				pilotAng.p = 1.0 + ( math.sin( CurTime() - (self:EntIndex() * 10 ) ) / 2 )
			
			end
			
			self.Speed = self.Speed / 1.0035
		
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		local pr = {}
		local wind = Vector( math.sin( CurTime() - ( self:EntIndex() * 2 ) ) * 6, math.cos( CurTime() - ( self:EntIndex() * 2 ) ) * 5.8, math.sin( CurTime() - ( self:EntIndex() * 3 ) ) * 7 )
		
		if( self.HealthVal < 400 ) then
		
			local t = t or 0.15
			t = math.Approach( t, 4.5, 0.15 )
			
			wind = Vector( math.sin(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64),math.cos(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64), -0.01 ) 
			pilotAng.y = pilotAng.y + t
			self.HoverVal = self.HoverVal / 2 - 5
			
		end

		pilotAng.p = math.Approach( pilotAng.p, self:GetAngles().p, 0.11 )
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight// + wind
		pr.secondstoarrive	= 1
		pr.pos 				= desiredPos
 		pr.maxangular		= maxang // 400
		pr.maxangulardamp	= maxang // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = pilotAng + Angle( 0, 0, r  )
		
		phys:ComputeShadowControl(pr)
	
	else
			
		self:RemoveRotorwash()
	
	end
	
end


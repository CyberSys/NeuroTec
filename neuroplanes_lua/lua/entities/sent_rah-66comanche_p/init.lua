// Use this as base for helicopters with physical rotors.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.PrintName = "RAH-66 Comanche"
ENT.Model = "models/bf2/helicopters/rah-66 comanche/rah-66 comanche.mdl"
//Speed Limits
ENT.MaxVelocity = 1450
ENT.MinVelocity = -1400

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 3

ENT.InitialHealth = 3600
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 20
ENT.FlareCount = 15
ENT.MaxFlares = 15

// Equipment
ENT.MachineGunModel = "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_cannon.mdl"
ENT.MachineGunOffset = Vector( 244, 0, 2 )
ENT.CrosshairOffset = -53

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
	local ent = ents.Create( "sent_rah-66comanche_p" )
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
	
	self.LastSecondaryKeyDown = CurTime()
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
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
	self.MaxRotorVal = 1700
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
						Pos = Vector( 15, -81, 20), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					}; 
					{ 
						PrintName = "LAU-131A Rocket Pod"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
						Pos = Vector( 15, 81, 20), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					};
					{ 
						PrintName = "Python 5"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  		// model, used when creating the object
						Pos = Vector( 15, 57, 19), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
					{ 
						PrintName = "Python 5 \"Jericho\""		,		 		// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  				// model, used when creating the object
						Pos = Vector( 15, -57, 19), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( -3, 0, 0), 								// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 20, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_jericho"								// the object that will be created.
					}; 
					{
						PrintName = "AGM-65 Maverick"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",  		// model, used when creating the object
						Pos = Vector( -20, -21, 11), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",
						Damage = 400,
						Radius = 2000
					}; 
					{ 
						PrintName = "AGM-65 Maverick"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",  		// model, used when creating the object
						Pos = Vector( -20, 21, 11), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",
						Damage = 400,
						Radius = 2000
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
	
--	self.LoopSound = CreateSound(self.Entity,Sound("bf2/AH1_start_idle_stop.wav"))
	self.LoopSound = CreateSound(self.Entity,Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
	self.LoopSound:PlayEx(511,110)
	self.LoopSound:SetSoundLevel(511)
	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = nil

	self.ChopperGun = ents.Create("prop_physics_override")
	self.ChopperGun:SetModel( "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_cannon.mdl" )
	self.ChopperGun:SetPos( self:GetPos() + self:GetForward() * 212 + self:GetUp() * 2  )
	self.ChopperGun:SetAngles( self:GetAngles() )
	self.ChopperGun:SetSolid( SOLID_NONE )
	self.ChopperGun:SetParent( self )
	self.ChopperGun:Spawn()
	
	self.ChopperGunProp = ents.Create("prop_physics_override")
	self.ChopperGunProp:SetModel( "models/airboatgun.mdl" )
	self.ChopperGunProp:SetPos( self.ChopperGun:GetPos() + self.ChopperGun:GetForward() * 32 )
	self.ChopperGunProp:SetParent( self.ChopperGun )
	self.ChopperGunProp:SetSolid( SOLID_NONE )
	self.ChopperGunProp:SetAngles( self:GetAngles() )
	self.ChopperGunProp:Spawn()
	self.ChopperGunProp:SetNoDraw( true )
	
	self.RotorPropellerPos = ( self:GetForward() * -18 ) + ( self:GetUp() *121.5 )
	self.TailPropellerPos = ( self:GetForward() * -368 ) + ( self:GetRight() * 0 ) + ( self:GetUp() * 43 )

	self.RotorPropeller = ents.Create("sent_cobra_rotor")
	self.RotorPropeller:SetPos( self:GetPos() + self.RotorPropellerPos  )
	self.RotorPropeller:SetAngles( self:GetAngles() )
	self.RotorPropeller:SetSolid( SOLID_VPHYSICS )
	self.RotorPropeller:Spawn()
	self.RotorPropeller:SetOwner( self )
	self.RotorPropeller:SetModel( "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_rotor.mdl" )
	self.RotorPropeller.isCommancheRotor = true // hackfix to make this rotor more sensitive to impact.
	
	self.RotorPhys = self.RotorPropeller:GetPhysicsObject()	
	if ( self.RotorPhys:IsValid() ) then
	
		self.RotorPhys:Wake()
		self.RotorPhys:SetMass( self.MaxRotorVal )
		self.RotorPhys:EnableGravity( false )
		//self.RotorPhys:EnableDrag( true )
		
	end

	self.TailPropeller = ents.Create("prop_physics")
	self.TailPropeller:SetModel( "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_tail.mdl" )
	self.TailPropeller:SetPos( self:GetPos() + self.TailPropellerPos  )
	self.TailPropeller:SetAngles( self:GetAngles() + Angle(0,180,-15))
	--self.TailPropeller:SetMoveType( MOVETYPE_VPHYSICS )
	self.TailPropeller:SetSolid( SOLID_NONE )
	self.TailPropeller:Spawn()
	self.TailPropeller:SetOwner( self.RotorPropeller )
	
	self.TailPhys = self.TailPropeller:GetPhysicsObject()
	if ( self.TailPhys:IsValid() ) then
	
		self.TailPhys:Wake()
		self.TailPhys:SetMass( 100 )
		self.TailPhys:EnableGravity( false )
		self.TailPhys:EnableCollisions( false )
		
	end

/*	self.Wings = ents.Create("prop_physics_override")
	self.Wings:SetModel( "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_wings.mdl" )
	self.Wings:SetPos( self:GetPos() + self:GetForward() * 172 + self:GetUp() * -38  )
	self.Wings:SetAngles( self:GetAngles() )
	self.Wings:SetSolid( SOLID_NONE )
	self.Wings:SetParent( self )
	self.Wings:Spawn()
*/	
	self.Radar = ents.Create("prop_physics_override")
	self.Radar:SetModel( "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_radar.mdl" )
	self.Radar:SetPos( self:GetPos() + self:GetForward() * 228 + self:GetUp() * 46  )
	self.Radar:SetAngles( self:GetAngles() + Angle(-4,0,0) )
	self.Radar:SetSolid( SOLID_NONE )
	self.Radar:SetParent( self )
	self.Radar:Spawn()
	
	self.PassengerSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PassengerSeat:SetPos( self:LocalToWorld( Vector( 69, 0, 40 ) ) )
	self.PassengerSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PassengerSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PassengerSeat:SetKeyValue( "LimitView", "60" )
	self.PassengerSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
	self.PassengerSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
	self.PassengerSeat:SetParent( self )
	self.PassengerSeat:SetNoDraw( true )
	self.PassengerSeat:Spawn()
	
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
	self:SetNetworkedInt( "health",self.HealthVal )
	
	if ( dmginfo:GetDamagePosition():Distance( self.RotorPropeller:GetPos() ) < 90 && dmginfo:GetDamage() > 500 ) then // Direct blow to the rotor
		
		self:Crash()
	
	end
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -62 + self:GetRight() * -35 + self:GetUp() * 88
		p[2] = self:GetPos() + self:GetForward() * -62 + self:GetRight() * 35 + self:GetUp() * 88
		for _i=1,2 do
		
			local f = ents.Create("env_Fire_trail")
			f:SetPos( p[_i] )
			f:SetParent( self )
			f:Spawn()
			
		end
		
	end
	
	if ( self.HealthVal < 100 ) then
		
		if( !self.Destroyed ) then
				
			self:Crash()
			
		end
		
	end
	
end

function ENT:OnRemove()

	self.LoopSound:Stop()
	
	if( self.RotorPropeller && IsValid( self.RotorPropeller ) ) then
		
		self.RotorPropeller:Remove()
		
	end
	
	if( self.TailPropeller && IsValid( self.TailPropeller ) ) then
		
		self.TailPropeller:Remove()
	
	end
	
	if( self.Destroyed ) then
		
		for i=1,7 do
			
			local fx = EffectData()
			fx:SetOrigin( self:GetPos()+ Vector(math.random(-100,100),math.random(-100,100),math.random(16,72)) )
			util.Effect("super_explosion", fx)
		
		end

	end
	
	if( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end
	
end



function ENT:Crash()
	
	for k,v in pairs( self.RocketVisuals ) do
		
		if( v && IsValid( v ) && math.random(1,2) == 1 ) then
			
			v:SetParent(nil)
			v:SetSolid( SOLID_VPHYSICS )	
			v:Fire("kill","",25)
			
			if( self.HealthVal < self.InitialHealth * 0.5 ) then
				
				v:Ignite(25,25)
			
			end
			
			local p = v:GetPhysicsObject()
			if( p ) then
				
				p:Wake()
				p:EnableGravity( true )
				p:EnableDrag( true )
				
			end
		
		end
		
	end
	
	if( self.rotoraxis && IsValid( self.rotoraxis ) ) then
		
		self.rotoraxis:Remove()
		
	end
	
	if( self.tailrotoraxis && IsValid( self.tailrotoraxis ) ) then
		
		if( math.random( 1,4 ) == 1 ) then
			
			self.tailrotoraxis:Remove()
		
		end
	
	end
	
	self.RotorPropeller:GetPhysicsObject():EnableGravity( true )
	self.TailPropeller:GetPhysicsObject():EnableGravity( true )
	self.RotorPropeller:SetOwner(nil)
	self.TailPropeller:SetOwner(nil)
	
	// bye bye
	self.RotorPhys:ApplyForceCenter( self:GetUp() * ( self.RotorVal * 100 ) + self:GetRight() * ( math.random( -1, 1 ) * ( self.RotorVal * 100 ) ) + self:GetForward() * ( math.random( -1, 1 ) * ( self.RotorVal * 100 ) )  )
	local ra = self.RotorPhys:GetAngles()
	self.RotorPhys:SetAngles( ra + Angle( math.random(-5,5),math.random(-5,5),math.random(-5,5) ) )
	
	self.RotorPropeller:Fire( "kill", "", 25 )
	self.TailPropeller:Fire( "kill", "", 25 )
	
	if( self.HealthVal < self.InitialHealth * 0.5 ) then
			
		self:Ignite( 25, 25 )
		
	end

	self.LoopSound:Stop()
	
	if( self.RotorVal > 200 ) then
		
		self:EmitSound("npc/combine_gunship/gunship_explode2.wav",511,130)
	
	end
	
	self:Fire( "kill", "", 25 )
	self.PhysObj:Wake()
	self.PhysObj:EnableGravity( true )
	self.PhysObj:EnableDrag( true )
	self.Destroyed = true
	
end
--[[
function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	self.Pilot:UnSpectate()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )
	self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Plane", nil ) 
	self:SetNetworkedEntity("Pilot", nil )
	self:SetNetworkedBool("ChopperGunner",false)
	self.GotChopperGunner = false
	self.Pilot:SetNetworkedBool( "isGunner", false )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = nil
	self.Pilot:SetScriptedVehicle( nil )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = nil
	
end

function ENT:Use(ply,caller)
	
	if( ply == self.Pilot ) then return end
	
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
		ply:SetNetworkedEntity( "NeuroPlanesMountedGun", self.ChopperGun )
		
		self.Entered = CurTime()
	else
		
		local d = self.PassengerSeat:GetDriver()
		
		if( !IsValid( d ) ) then
			
			ply:EnterVehicle( self.PassengerSeat )
		
		end
		
	end
	
end
]]--

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
	
	self.Pilot:SetPos( self:GetPos() + self:GetForward() * 300 )
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


function ENT:PhysicsCollide( data, physobj )
	
	if ( data.Speed > self.MaxVelocity * 0.45 && data.DeltaTime > 0.2 ) then 
		
		if( self.Destroyed ) then
		
			self:EmitSound("physics/metal/metal_large_debris2.wav",511,100)
			self.ChopperGun:EmitSound( "ambient/explosions/explode_3.wav", 511, 100 )
			
		else
		
			self:EmitSound("physics/metal/metal_box_break1.wav", 250, 60 )
		
		end
			
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.7 ) then
			
			self.HealthVal = self.HealthVal * ( 0.3 + ( math.random(10,25) / 100 ) )
			self:SetNetworkedInt("health",self.HealthVal)
			
		else
			
			if( !self.Destroyed ) then
				
				self:Crash()
			
			end
			
		end
	
	end
	
end

function ENT:ToggleChopperGunner()

	self.LastChopperGunToggle = CurTime() 
	self.GotChopperGunner = !self.GotChopperGunner
	self:SetNetworkedBool("ChopperGunner",self.GotChopperGunner)
	self.Pilot:SetNetworkedBool( "isGunner", !self.GotChopperGunner )
	self:SetNetworkedEntity("NeuroPlanesMountedGun", self.ChopperGun )
	
end

function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 100 + 100 ),0,205 )
	self.LoopSound:ChangePitch( self.Pitch, 0.01 )
	if ( self.Destroyed && self.HealthVal < self.InitialHealth * 0.5 && self:WaterLevel() < 2 ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-32,32) + self:GetForward() * math.random(-32,32)  )
		util.Effect( "immolate", effectdata )
		
		if( math.random(1,10 ) == 5 ) then
			
			self:DeathFX()
			
			return
		
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
	
		local d = self.PassengerSeat:GetDriver()
		
		// Attack
		if ( ( self.Pilot:KeyDown( IN_ATTACK ) && !IsValid( d ) ) || ( IsValid( d ) && d:KeyDown( IN_ATTACK ) ) ) then

			if ( self.ChopperGunAttack + 0.095 <= CurTime() ) then
				
				self:FuselageAttack()
			
			end
			
		end

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
				print( "", "GotChopperGunner", "Networked", "Entity")
				print( "Values: ", self.GotChopperGunner, self.Pilot:GetNetworkedBool("isGunner", false), self.Pilot:GetNetworkedEntity("ChopperGunnerEnt", NULL ) )
				
			end
		
		else
			
			eyeAng = self.Pilot:EyeAngles()
			
			if ( self.Pilot:KeyDown( IN_ZOOM ) && self.LastChopperGunToggle + 1.0 <= CurTime() && !IsValid( self.LaserGuided ) ) then
				
				self.LastChopperGunToggle = CurTime()
				self.GotChopperGunner = !self.GotChopperGunner
				self.Pilot:SetNetworkedBool( "isGunner", self.GotChopperGunner )
				self.Pilot:SetNetworkedEntity( "ChopperGunEnt", self.ChopperGun )
				print( "", "GotChopperGunner", "Networked", "Entity")
				print( "Values: ", self.GotChopperGunner, self.Pilot:GetNetworkedBool("isGunner", false), self.Pilot:GetNetworkedEntity("ChopperGunnerEnt", NULL) )

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
		self.Radar:SetAngles( Angle( myAng.p, eyeAng.y, myAng.r ) )	
		--[[// Attack
		if ( self.Pilot:KeyDown( IN_ATTACK ) ) then
		
			if ( self.GotChopperGunner ) then
			
				if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					self:FuselageAttack()
					
				end
				
			else
				
				if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					self:FuselageAttack()
					
				end
			
			end
			
		end
				

		// Ugly
		local eyeAng = self.Pilot:EyeAngles()
		local myAng = self:GetAngles()
		
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
		
		//print( self.Pilot:EyeAngles().p )
		
		eyeAng.r = myAng.r
		self.ChopperGun:SetAngles( LerpAngle( 0.223, self.ChopperGun:GetAngles(), eyeAng ) ) 
		self.Radar:SetAngles( Angle( myAng.p, eyeAng.y, myAng.r ) )	

		if ( self.Pilot:KeyPressed( IN_ATTACK2 ) && !self.GotChopperGunner ) then
		
			local id = self.EquipmentNames[ self.FireMode ].Identity
			local wep = self.RocketVisuals[ id ]
			
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
		
		if ( self.Pilot:KeyDown( IN_ZOOM ) && self.LastChopperGunToggle + 1.0 <= CurTime() && !IsValid( self.LaserGuided ) ) then
			
			self:ToggleChopperGunner()
			
		end	]]--
		
		// Firemode 
		if ( self.Pilot:KeyDown( IN_RELOAD ) && self.LastFireModeChange + 0.5 <= CurTime() ) then

			self:CycleThroughWeaponsList()
			
		end
		
		// Flares
		if ( self.Pilot:KeyDown( IN_SCORE ) && !self.isHovering && self.FlareCount > 0 && self.LastFlare + self.FlareCooldown <= CurTime() && self.LastFireModeChange + 0.2 <= CurTime() ) then
			
			self.LastFireModeChange = CurTime()
			self.FlareCount = self.FlareCount - 1
			self:SetNetworkedInt( "FlareCount", self.FlareCount )
			self:SpawnFlare()
			
			if ( self.FlareCount == 0 ) then
			
				self.LastFlare = CurTime() 
				self.FlareCount = self.MaxFlares
				
			end
			
		end
	
		if ( self.Pilot:KeyDown( IN_USE ) && self.Entered + 1.0 <= CurTime() ) then

			self:EjectPilotSpecial()
			
		end	
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
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
 	bullet.Spread 	= Vector( .02, .023, .014 )								// Aim Cone 
 	bullet.Tracer	= 1															// Show a tracer on every x bullets  
 	bullet.Force	= 50					 									// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 45, 75 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c )
								
							self:ChopperGunCallback( a, b, c )
							
						end 
 	local e = EffectData()
	e:SetStart( self.ChopperGunProp:GetPos()+self.ChopperGunProp:GetForward() * 72 )
	e:SetOrigin( self.ChopperGunProp:GetPos()+self.ChopperGunProp:GetForward() * 72 )
	e:SetEntity( self.ChopperGunProp )
	e:SetAttachment( 1 )
	util.Effect( "StriderMuzzleFlash", e )
	
	self.ChopperGun:FireBullets( bullet )
	
	self.ChopperGun:EmitSound( "ah64fire.wav", 510, math.random(115,134) )

	self.ChopperGunAttack = CurTime()
	
end

function ENT:ChopperGunCallback( a, b, c )

	if ( IsValid( self.Pilot ) ) then
	
		local e = EffectData()
		e:SetOrigin(b.HitPos)
		e:SetNormal(b.HitNormal)
		e:SetScale( 4.5 )
		util.Effect("ManhackSparks", e)

		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 100, math.random(15,59) )
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
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
	self.RotorVal = math.Approach( self.RotorVal, topval, 1 )	
	self.Started = ( self.RotorVal >= 350 ) // Loving the hard coded values <^.^> 

	if( IsValid( self.RotorPropeller ) ) then
		
		self.RotorPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.RotorVal * 2 ) )
		
	end
	
	if( IsValid( self.TailPropeller ) ) then
	
		self.TailPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, self.RotorVal / 4, 0 ) )
	
	end
	
	if ( self.IsFlying && !stallAng && self.Started && !self.Destroyed ) then
		
		phys:Wake()
		self:CreateRotorwash()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
		local maxang = 46

		local vel = self:GetVelocity():Length()
		if ( vel > -600 && vel < 600 ) then
			
			self.isHovering = true
			self.BankingFactor = 15
		
		else
		
			self.isHovering = false
			self.BankingFactor = 4
			
		end
	
		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 2.45
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 3.0
		
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
		
		
		if ( self.GotChopperGunner && !IsValid( self.PassengerSeat:GetDriver() ) ) then
			
			if ( pilotAng.p < 5 || pilotAng.p > 300 ) then pilotAng.p = 5 end
			
			--self.ChopperGun:SetAngles( pilotAng )
			
			if ( self.Pilot:KeyDown( IN_FORWARD ) ) then
			
				pilotAng.p = 5
			
			elseif ( self.Pilot:KeyDown( IN_BACK ) ) then
				
				pilotAng.p = -5	
				
			else
			
				pilotAng.p = math.cos( CurTime() - ( self:EntIndex() * 10 ) ) * 1.65
			
			end

		end
		
		if ( ma.p > 3 ) then
	
			self.Speed = self.Speed + ma.p / 2.95
		
		elseif ( ma.p < -3 ) then
			
			self.Speed = self.Speed + ma.p / 2.5
		
		elseif ( ma.p > -3 && ma.p < 3 ) then
		
			self.Speed = self.Speed / 1.0055
		
		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) || IsValid( self.LaserGuided ) ) then
			
			--// Pull up the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 500 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
			
				if( self.Speed > 0 ) then
					
					pilotAng.p = -15
				
				elseif( self.Speed < 0) then
					
					pilotAng.p = 25
					
				end
				
				self.HoverVal = self.HoverVal / 1.05
				
			else
				
				pilotAng.p = 0 + ( math.sin( CurTime() - (self:EntIndex() * 10 ) ) / 2 ) * 1.9
				pilotAng.r = pilotAng.r + math.cos( CurTime() - ( self:EntIndex() * 2 ) / 4 ) * 1.45
				
			end
			
			self.Speed = self.Speed / 1.0055
		
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
		
		//print( r.." "..self.offs )
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight + wind
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

function ENT:CreateRotorwash()
	
	if( !self.IsRotorwashing ) then
	
		self.Rotorwash = ents.Create("env_rotorwash_emitter")
		self.Rotorwash:SetPos( self:GetPos() )
		self.Rotorwash:SetParent( self )
		self.Rotorwash:SetKeyValue("altitude","",1024)
		self.Rotorwash:Spawn()
		
		self.IsRotorwashing = true
	
	end

end

function ENT:RemoveRotorwash()
	
	if( IsValid( self.Rotorwash ) ) then
		
		self.Rotorwash:Remove()
		self.IsRotorwashing = false
	
	end

end


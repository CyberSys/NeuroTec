AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.PrintName	= "UH-60 Black Hawk"
ENT.Model = "models/bf2/helicopters/uh-60 blackhawk/uh-60 blackhawk.mdl"
//Speed Limits
ENT.MaxVelocity = 1200
ENT.MinVelocity = -500

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 6

ENT.InitialHealth = 5000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Timers
ENT.LastAttack = nil
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/bf2/helicopters/rah-66 comanche/rah-66 comanche_cannon.mdl"
ENT.MachineGunOffset = Vector( 180, 0, -53 )
ENT.CrosshairOffset = -53

ENT.NumRockets = nil

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_uh-60blackhawk_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
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
	self.MaxRotorVal = 1600
	self.RotorMult = self.MaxRotorVal / 2000
	self.Started = false
	self.SpinUp = 0
	
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
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
						PrintName = ""		,		 							// print name, used by the interface
						Mdl = "models/hawx/weapons/lau-131 a.mdl",  			// model, used when creating the object
						Pos = Vector( 15, 0, -41 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Flarepod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = ""											// the object that will be created.
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
	self.Pilot = NULL

	self.RotorPropellerPos = ( self:GetUp() * 70 )
	self.TailPropellerPos = ( self:GetForward() * -486 ) + ( self:GetRight() * 9 ) + ( self:GetUp() * 108 )

	self.RotorPropeller = ents.Create("sent_cobra_rotor")
	self.RotorPropeller:SetPos( self:GetPos() + self.RotorPropellerPos  )
	self.RotorPropeller:SetAngles( self:GetAngles() )
	self.RotorPropeller:SetSolid( SOLID_VPHYSICS )
	self.RotorPropeller:Spawn()
	self.RotorPropeller.isTouching = false
	self.RotorPropeller:SetOwner( self )
	self.RotorPropeller:SetModel( "models/bf2/helicopters/uh-60 blackhawk/uh-60 blackhawk_rotor.mdl" )
	
	self.RotorPhys = self.RotorPropeller:GetPhysicsObject()	
	
	local wheelpos = {}
	wheelpos[1] = Vector( 58, -84, -50 )
	wheelpos[2] = Vector( 58, 84, -50 )
	
	self.Wheels = {}
	//self.WheelWelds = {}
	
	for i = 1, 2 do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( wheelpos[i] ) )
		self.Wheels[i]:SetModel( "models/bf2/helicopters/mil mi-28/mil mi-28_wheel.mdl" )
		self.Wheels[i]:SetAngles( self:GetAngles() )
		self.Wheels[i]:Spawn()
		self.Wheels[i]:SetParent( self )
		
		//self.WheelWelds[i] = constraint.Weld( self, self.Wheels[i], 0, 0, 0, true )
	
	end
	
	self.Wheels[3] = ents.Create("prop_physics")
	self.Wheels[3]:SetPos( self:LocalToWorld( Vector( -385, 0, -53 ) ) )
	self.Wheels[3]:SetModel( "models/bf2/helicopters/mil mi-28/mil mi-28_tailwheel.mdl" )
	self.Wheels[3]:SetAngles( self:GetAngles() )
	self.Wheels[3]:Spawn()
	self.Wheels[3]:SetParent( self )
	
	//self.WheelWelds[3] = constraint.Weld( self, self.Wheels[3], 0, 0, 0, true )

	
	if ( self.RotorPhys:IsValid() ) then
	
		self.RotorPhys:Wake()
		self.RotorPhys:SetMass( self.MaxRotorVal )
		self.RotorPhys:EnableGravity( false )
		self.RotorPhys:EnableDrag( true )
		
	end

	self.TailPropeller = ents.Create("prop_physics")
	self.TailPropeller:SetModel( "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_tail.mdl" )
	self.TailPropeller:SetPos( self:GetPos() + self.TailPropellerPos  )
	self.TailPropeller:SetAngles( self:GetAngles() )
	self.TailPropeller:Spawn()
	self.TailPropeller:SetOwner( self )
	
	self.TailPhys = self.TailPropeller:GetPhysicsObject()
	
	if ( self.TailPhys:IsValid() ) then
	
		self.TailPhys:Wake()
		self.TailPhys:SetMass( 100 )
		self.TailPhys:EnableGravity( false )
		self.TailPhys:EnableCollisions( false )
		
	end

	self.Wings = ents.Create("prop_physics_override")
	self.Wings:SetModel( "models/bf2/helicopters/uh-60 blackhawk/uh-60 blackhawk_wings.mdl" )
	self.Wings:SetPos( self:GetPos() + self:GetForward() * -449 + self:GetUp() * 10  )
	self.Wings:SetAngles( self:GetAngles() )
	self.Wings:SetSolid( SOLID_NONE )
	self.Wings:SetParent( self )
	self.Wings:Spawn()

	// Passenger Seats - Gunners
	self.GunnerSeats = {}
	self.MountedGuns = {}
	local gunnerseats,mgpos,gunnerangles,mgang = {},{},{},{}
	
	// Seat pos
	gunnerseats[1] = Vector( 82, -36, -22 )
	gunnerseats[2] = Vector( 82, 36, -22 )
	gunnerseats[3] = Vector( 38, -44, -22 )
	gunnerseats[4] = Vector( 38, 44, -22 )
	gunnerseats[5] = Vector( -55, -43, -22 )
	gunnerseats[6] = Vector( -55, 43, -22 )
	
	// Mounted gun pos
	mgpos[1] = Vector( 77, -70, 3 )
	mgpos[2] = Vector( 77, 70, 3 )
	
	// Seat angle
	gunnerangles[1] = Angle( 0, 180, 0 )
	gunnerangles[2] = Angle( 0, 0, 0 )
	gunnerangles[3] = Angle( 0, 90, 0 )
	gunnerangles[4] = Angle( 0, 90, 0 )
	gunnerangles[5] = Angle( 0, -90, 0 )
	gunnerangles[6] = Angle( 0, -90, 0 )
	
	// Mounted gun angles
	mgang[1] = Angle( 0, -90, 0 )
	mgang[2] = Angle( 0, 90, 0 )
	
	self.MGWelds = {}
	
	for i=1,6 do 
		
		if( i < 3 ) then 
		
			self.MountedGuns[i] = ents.Create( "prop_physics_override" )
			self.MountedGuns[i]:SetPos( self:LocalToWorld( mgpos[i] ) )
			self.MountedGuns[i]:SetAngles( self:GetAngles() + mgang[i] )
			self.MountedGuns[i]:SetModel( "models/weapons/hueym60/m60.mdl"  )
			self.MountedGuns[i]:SetParent( self )
			self.MountedGuns[i]:SetSolid( SOLID_NONE )
			self.MountedGuns[i].LastAttack = now
			self.MountedGuns[i]:Spawn()
			
			self.MGWelds[i] = constraint.Weld( self.MountedGuns[i], self, 0, 0, 0, true )
			
			self.GunnerSeats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
			self.GunnerSeats[i]:SetPos( self:LocalToWorld( gunnerseats[i] ) )
			self.GunnerSeats[i]:SetModel( "models/nova/jeep_seat.mdl" )
			self.GunnerSeats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
			self.GunnerSeats[i]:SetKeyValue( "LimitView", "60" )
			self.GunnerSeats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
			self.GunnerSeats[i]:SetAngles( self:GetAngles() + gunnerangles[i] )
			self.GunnerSeats[i]:SetParent( self )
			self.GunnerSeats[i].MountedWeapon = self.MountedGuns[i]
			self.GunnerSeats[i].MountedWeapon.LastAttack = CurTime()
			self.GunnerSeats[i]:Spawn()
			self.GunnerSeats[i].isChopperGunnerSeat = true
			self.GunnerSeats[i]:SetNoDraw( true )
			
		else
		
			self.GunnerSeats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
			self.GunnerSeats[i]:SetPos( self:LocalToWorld( gunnerseats[i] ) )
			self.GunnerSeats[i]:SetModel( "models/nova/jeep_seat.mdl" )
			self.GunnerSeats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
			self.GunnerSeats[i]:SetKeyValue( "LimitView", "60" )
			self.GunnerSeats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
			self.GunnerSeats[i]:SetAngles( self:GetAngles() + gunnerangles[i] )
			self.GunnerSeats[i]:SetParent( self )
			self.GunnerSeats[i]:Spawn()
		
		end
		
		
	end


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
	
	if ( dmginfo:GetDamagePosition():Distance( self.RotorPropeller:GetPos() ) < 100 && dmginfo:GetDamage() > 500 ) then // Direct blow to the rotor
		
		self:Crash()
	
	end
	
	if ( self.HealthVal < self.InitialHealth * 0.2 && !self.Burning ) then
	
		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -104 + self:GetRight() * -58 + self:GetUp() * 38
		p[2] = self:GetPos() + self:GetForward() * -104 + self:GetRight() * 58 + self:GetUp() * 38
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
	
	for i = 1, #self.Wheels do
		
		if ( IsValid( self.Wheels[i] ) ) then
			
			self.Wheels[i]:Remove()
		
		end
		
		//if ( IsValid( self.WheelWelds[i] ) ) then
			
		//	self.WheelWelds[i]:Remove()
		
		//end
		
	end
	
	for i=1,#self.MountedGuns do
		
		self.MountedGuns[i]:Remove()
	
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end
	
end


function ENT:PhysicsCollide( data, physobj )
	
	if ( data.Speed > self.MaxVelocity * 0.25 && data.DeltaTime > 0.2 ) then 
		
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.7 ) then
		
			if( self.Destroyed && IsValid( self.Pilot ) ) then
				
				self:EmitSound("physics/metal/metal_large_debris2.wav",511,100)
				self.Pilot:EmitSound( "ambient/explosions/explode_3.wav", 511, 100 )
			else
			
				self:EmitSound("physics/metal/metal_box_break1.wav"..math.random(1,2)..".wav", 250, 60 )
			
			end
			
			self.HealthVal = self.HealthVal * 0.3 + ( math.random(10,25) / 100 )
		
		else
			
			if( !self.Destroyed ) then
				
				self:Crash()
			
			end
			
		end
		
		self:SetNetworkedInt("health",self.HealthVal)
		
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
	
	timer.Simple( 5, function()	if ( !self || !IsValid( self ) ) then return end self:EjectPilotSpecial() end )
	
	self.LoopSound:Stop()
	
	if( self.RotorVal > 200 ) then
		
		self:EmitSound("npc/combine_gunship/gunship_explode2.wav",511,125)
	
	end
	
	self:Fire( "kill", "", 25 )
	self.PhysObj:Wake()
	self.PhysObj:EnableGravity( true )
	self.PhysObj:EnableDrag( true )
	self.Destroyed = true
	
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

	self.Pilot:SetPos( self:LocalToWorld( Vector( 140, 95, -40 ) ) )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	-- self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
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
		
		ply:SetNetworkedBool( "InFlight", true )
		ply:SetNetworkedEntity( "Plane", self ) 
		self:SetNetworkedEntity("Pilot", ply )

		self.Entered = CurTime()
	
	else

		for i=1,#self.GunnerSeats do
			
			if( !IsValid( self.GunnerSeats[i]:GetDriver() ) ) then
				
				ply:EnterVehicle( self.GunnerSeats[i] )
				
				return
				
			end
		
		end
	
	end
	
end

function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 100 + 100 ),0,205 )
	self.LoopSound:ChangePitch( self.Pitch, 0.01 )
	
	if ( self.Destroyed && self.HealthVal < self.InitialHealth * 0.5 && self:WaterLevel() < 2 ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-32,32) + self:GetForward() * math.random(-32,32)  )
		util.Effect( "immolate", effectdata )
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 72 )
		
		// HUD Stuff
		self:UpdateRadar()

		local wingAng = self.Pilot:EyeAngles()
		local myAng = self:GetAngles()

		if ( wingAng.p > myAng.p + 15 ) then
		
			wingAng.p = myAng.p + 15
			
		elseif( wingAng.p < myAng.p -60 ) then
		
			wingAng.p = myAng.p -60
			
		end

		self.Wings:SetAngles( Angle( wingAng.p, myAng.y, myAng.r ) )
	
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


	local seat
	local gunner
	local wep
	// Gunners
	for i=1,#self.GunnerSeats do
	
		seat = self.GunnerSeats[i]
		gunner = seat:GetDriver()
		wep = seat.MountedWeapon
		
		if( IsValid( seat ) && IsValid( gunner ) && IsValid( wep ) ) then
		
			local ang = gunner:EyeAngles()
			
			if ( gunner:KeyDown( IN_ATTACK ) && wep.LastAttack + .0955 <= CurTime() ) then
				
				ang = ang + Angle( math.Rand(-.8,.8), math.Rand(-.8,.8), 0 )
				
				local bullet = {} 
				bullet.Num 		= 1
				bullet.Src 		= wep:GetPos() + wep:GetForward() * 55
				bullet.Dir 		= wep:GetAngles():Forward()					// Dir of bullet 
				bullet.Spread 	= Vector( .03, .03, .03 )				// Aim Cone 
				bullet.Tracer	= 3											// Show a tracer on every x bullets  
				bullet.Force	= 0						 				// Amount of force to give to phys objects 
				bullet.Damage	= math.random( 14, 38 )
				bullet.AmmoType = "Ar2" 
				bullet.TracerName = "AirboatGunHeavyTracer" 
				bullet.Callback = function ( a, b, c )
				
										local effectdata = EffectData()
											effectdata:SetOrigin( b.HitPos )
											effectdata:SetStart( b.HitNormal )
											effectdata:SetNormal( b.HitNormal )
											effectdata:SetMagnitude( 100 )
											effectdata:SetScale( 25 )
											effectdata:SetRadius( 30 )
										util.Effect( "ImpactGunship", effectdata )
										
										util.BlastDamage( gunner, gunner, b.HitPos, 256, 25 )
										
										return { damage = true, effects = DoDefaultEffect } 
										
									end 
									
				wep:FireBullets( bullet )
		        wep:EmitSound( "npc/turret_floor/shoot"..math.random(2,3)..".wav", 511, 60 )

				local effectdata = EffectData()
					effectdata:SetStart( wep:GetPos() )
					effectdata:SetOrigin( wep:GetPos() )
				util.Effect( "RifleShellEject", effectdata )  

				local e = EffectData()
					e:SetStart( wep:GetPos()+wep:GetForward() * 62 )
					e:SetOrigin( wep:GetPos()+wep:GetForward() * 62 )
					e:SetEntity( wep )
					e:SetAttachment(1)
				util.Effect( "ChopperMuzzleFlash", e )

				wep.LastAttack = CurTime()
	
			end

			
			wep:SetAngles( ang )
		end
		
	end
	
	local seq = self:LookupSequence("spin")
	self:SetPlaybackRate( 3.0 )
	self:SetSequence( seq )
	self:ResetSequence( seq )	
		
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
 	bullet.Spread 	= Vector( .021, .021, .019 )								// Aim Cone 
 	bullet.Tracer	= 1															// Show a tracer on every x bullets  
 	bullet.Force	= 50					 									// Amount of force to give to phys objects 
 	bullet.Damage	= 0
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
	
	self.ChopperGun:EmitSound( "ah64fire.wav", 510, math.random(130,138) )

	self.ChopperGunAttack = CurTime()
	
end

function ENT:ChopperGunCallback( a, b, c )

	if ( IsValid( self.Pilot ) ) then
	
		local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetNormal( b.HitNormal )
		e:SetScale( 4.5 )
		util.Effect("ManhackSparks", e)

		local effectdata = EffectData()
		effectdata:SetOrigin( b.HitPos )
		effectdata:SetStart( b.HitNormal )
		effectdata:SetNormal( b.HitNormal )
		effectdata:SetMagnitude( 10 )
		effectdata:SetScale( 2 )
		effectdata:SetRadius( 8 )
		util.Effect( "AR2Explosion", effectdata )
		
		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 200, math.random(10,16) )
		
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
	local topval = ( self.Pilot != NULL && ( self.MaxRotorVal / 2 ) ) or 0 // Should not be > 500
	self.RotorVal = math.Approach( self.RotorVal, topval, self.RotorMult )	
	self.Started = ( self.RotorVal >= 350 ) // Loving the hard coded values <^.^> 
	
//	print( p )
	
	if( IsValid( self.RotorPropeller ) ) then
	
		self.RotorPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.RotorVal * 2 ) )
		
	end
	
	if( IsValid( self.TailPropeller ) ) then
	
		self.TailPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, self.RotorVal * 2, 0 ) )
	
	end
	
	if ( stallAng ) then
		
		self.Speed = self.Speed / 1.1
		
	end
	
	if ( self.IsFlying && !stallAng && self.Started && !self.Destroyed && !self.RotorPropeller.isTouching ) then
		
		phys:Wake()
		
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
			
			self.HoverVal = self.HoverVal + 2.15
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 3.5
		
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
		
		
		if ( self.GotChopperGunner ) then
			
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
	
			self.Speed = self.Speed + ma.p / 3.1
		
		elseif ( ma.p < -6.1 ) then
			
			self.Speed = self.Speed + ma.p / 1.5
		
		elseif ( ma.p > -6.1 && ma.p < 3 ) then
		
			self.Speed = self.Speed / 1.005
		
		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) || IsValid( self.LaserGuided ) ) then
			
			--// Pull up the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 500 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
				pilotAng.p = -20
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
		
		pilotAng.p = math.Approach( pilotAng.p, self:GetAngles().p, 0.15 )
		
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
	
	
	end
	
		
end


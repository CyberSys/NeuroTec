// Use this as base for helicopters with physical rotors.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 150
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle( 0, vec.y + 180,0 )
	local ent = ents.Create( "sent_ka-50blackshark_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	
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
	self.LastLaserUpdate = CurTime()
	self.LastSecondaryKeyDown = 0
	
	self.MinigunRevolve = 0
	self.HoverVal = 0
	self.MoveRight = 0
	self.BottomVal = 0
	self.MaxBottomVal = 2000
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
						Pos = Vector( 38, -120, -50), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					}; 
					{ 
						PrintName = "LAU-131A Rocket Pod"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
						Pos = Vector( 38, 120, -50), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Pod", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2s_dumb"								// the object that will be created.
					};
					{ 
						PrintName = "Python 5"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  		// model, used when creating the object
						Pos = Vector( 34, -197, -39), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 
					{ 
						PrintName = "AGM-114 Cluster Hellfire"		,		 		// print name, used by the interface
						Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  				// model, used when creating the object
						Pos = Vector( 34, 197, -39), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Singlelock", 										// Type, used when creating the object
						Cooldown = 20, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						SubType = "Cluster",
						Class = "sent_hellfire_missile"								// the object that will be created.
					}; 
					{
						PrintName = "AGM-114 Hellfire"		,		 			// print name, used by the interface
						Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  		// model, used when creating the object
						Pos = Vector( 41, -149, -40), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Singlelock", 										// Type, used when creating the object
						Cooldown = 5, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_hellfire_missile",
						Damage = 900,
						Radius = 1200
					}; 
					{ 
						PrintName = "AGM-65 Maverick"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",  		// model, used when creating the object
						Pos = Vector( 41, 149, -40), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",
						Damage = 800,
						Radius = 1000
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
		
		if( v.SubType ) then
			
			//print( v.SubType )
			
			self.RocketVisuals[i].SubType = v.SubType
		
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

	self.Turret = ents.Create("prop_physics_override")
	self.Turret:SetModel( "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 Blackshark_turret.mdl" )
	self.Turret:SetPos( self:LocalToWorld( Vector( 9, 47, -40 ) ) )
	self.Turret:SetAngles( self:GetAngles() )
	self.Turret:SetSolid( SOLID_NONE )
	self.Turret:SetParent( self )
	self.Turret:Spawn()

	self.ChopperGun = ents.Create("prop_physics_override")
	self.ChopperGun:SetModel( "models/bf2/helicopters/ka-50 blackshark/ka-50 blackshark_cannon.mdl" )
	self.ChopperGun:SetPos( self:LocalToWorld( Vector( 9, 55, -40 ) ) )
	self.ChopperGun:SetAngles( self.Turret:GetAngles() )
	self.ChopperGun:SetSolid( SOLID_NONE )
	self.ChopperGun:SetParent( self.Turret )
	self.ChopperGun:Spawn()
	
	self.ChopperGunProp = ents.Create("prop_physics_override")
	self.ChopperGunProp:SetModel( "models/airboatgun.mdl" )
	self.ChopperGunProp:SetPos( self.ChopperGun:LocalToWorld( Vector( 145, 0, 0 ) ) )
	self.ChopperGunProp:SetParent( self.ChopperGun )
	self.ChopperGunProp:SetSolid( SOLID_NONE )
	self.ChopperGunProp:SetAngles( self.ChopperGun:GetAngles() )
	self.ChopperGunProp:Spawn()
	self.ChopperGunProp:SetNoDraw( true )
	
	self.BottomPropellerPos = self:LocalToWorld( Vector( 9, 0, 48 ) )

	self.BottomPropeller = ents.Create("sent_cobra_rotor")
	self.BottomPropeller:SetPos( self.BottomPropellerPos  )
	self.BottomPropeller:SetAngles( self:GetAngles() )
	self.BottomPropeller:SetSolid( SOLID_VPHYSICS )
	self.BottomPropeller:Spawn()
	self.BottomPropeller:SetOwner( self )
	self.BottomPropeller.Owner = self
	self.BottomPropeller:SetModel( "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_bottom.mdl" )

	self.BottomPhys = self.BottomPropeller:GetPhysicsObject()	
	if ( self.BottomPhys:IsValid() ) then
	
		self.BottomPhys:Wake()
		self.BottomPhys:SetMass( self.MaxBottomVal )
		self.BottomPhys:EnableGravity( true )
		self.BottomPhys:EnableDrag( true )
		
	end

	self.TopPropellerPos = ( self:GetForward() * 10 ) + ( self:GetUp() * 181 )
	self.TopPropellerPos2 = ( self.BottomPropeller:GetUp() * 134 )

	self.TopPropeller = ents.Create("sent_cobra_rotor")
	self.TopPropeller:SetPos( self:GetPos() + self.TopPropellerPos  )
	self.TopPropeller:SetAngles( self.BottomPropeller:GetAngles() )
	self.TopPropeller:SetSolid( SOLID_VPHYSICS )
	self.TopPropeller:Spawn()
	self.TopPropeller:SetOwner( self )
	self.TopPropeller.Owner = self
	self.TopPropeller.isCounterCoaxialRotor = true
	self.TopPropeller:SetModel( "models/bf2/helicopters/ka-50 blackshark/ka-50 blackshark_top.mdl" )

	self.TopPhys = self.TopPropeller:GetPhysicsObject()
	
	if ( self.TopPhys:IsValid() ) then
	
		self.TopPhys:Wake()
		self.TopPhys:SetMass( self.MaxBottomVal * 0.6 )
		self.TopPhys:EnableGravity( true )
		
	end
	
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	self.Radar = ents.Create("prop_physics_override")
	self.Radar:SetModel( "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_Ftgear.mdl" )
	self.Radar:SetPos( self:GetPos() + self:GetForward() * 232 + self:GetUp() * -45  )
	self.Radar:SetAngles( self:GetAngles() + Angle(-4,0,0) )
	self.Radar:SetSolid( SOLID_NONE )
	self.Radar:SetParent( self )
	self.Radar:Spawn()
	
	local Wheels = {
					{ 
						Model = "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_Ftgear.mdl", 
						Ang = Angle(  0, 0, 0 ), 
						Pos = Vector( 232, 0, -45 ),
						Type = 0,
						Mass = 2000,
						Solid = SOLID_NONE,
					};
					{ 
						Model = "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_wheel.mdl", 
						Ang = Angle(  0, 0, 0 ), 
						Pos = Vector( 232, 0, -95 ),
						Type = 0,
						Mass = 2000,
						Solid = SOLID_VPHYSICS,
					};
					{ 
						Model = "models/bf2/helicopters/ka-50 blackshark/ka-50 blackshark_rtgear.mdl", 
						Ang = Angle(  0, 0, 0 ), 
						Pos = Vector( -102 + 45, 44, -45 ),
						Type = 0,
						Mass = 2000,
						Solid = SOLID_NONE,
					};
					{ 
						Model = "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_wheel.mdl", 
						Ang = Angle(  0, 0, 0 ), 
						Pos = Vector( -26, 10, -52 ),
						Type = 1,
						Mass = 2000,
						Solid = SOLID_VPHYSICS,
					};
					{ 
						Model = "models/bf2/helicopters/ka-50 blackshark/ka-50 blackshark_rtgear.mdl", 
						Ang = Angle(  0, 0, 0 ), 
						Pos = Vector( -102 + 45, -44, -45 ),
						Type = 0,
						Mass = 2000,
						Solid = SOLID_NONE,
					};
					{ 
						Model = "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_wheel.mdl", 
						Ang = Angle(  0, 0, 0 ), 
						Pos = Vector( -26, -10, -52 ),
						Type = 1,
						Mass = 2000,
						Solid = SOLID_VPHYSICS,
					};

				}
	
	self.WheelObjects = {}
	
	local i = 0
	for k,v in pairs( Wheels ) do
		
		i = i + 1
		self.WheelObjects[i] = ents.Create( "prop_physics_override" )
		self.WheelObjects[i]:SetModel( v.Model )
		self.WheelObjects[i]:SetAngles( self:GetAngles() + v.Ang )
		self.WheelObjects[i]:SetSolid( v.Solid )
		
		if( v.Type == 1 ) then
			
			// Thanks StarChick for using vectors local to the gear rather than the helicopter.
			if( IsValid( self.WheelObjects[i-1] ) ) then
				
				self.WheelObjects[i]:SetPos( self.WheelObjects[i-1]:LocalToWorld( v.Pos ) )
				
			end
			
			
		else
		
			self.WheelObjects[i]:SetPos( self:LocalToWorld( v.Pos ) )
		
		end
		
		self.WheelObjects[i]:Spawn()
		self.WheelObjects[i]:GetPhysicsObject():SetMass( v.Mass )
		
	end
	
	self.WheelWelds = {}
	
	local numobj = #self.WheelObjects
	for i=1,numobj do
		
		self.WheelWelds[i] = constraint.Weld( self.WheelObjects[i], self, 0, 0, -1, true )
	
	end

	self.WheelWelds[numobj+1] = constraint.Weld( self.WheelObjects[1],self.WheelObjects[2] , 0, 0, -1, true )
	self.WheelWelds[numobj+2] = constraint.Weld( self.WheelObjects[3],self.WheelObjects[4] , 0, 0, -1, true )
	self.WheelWelds[numobj+3] = constraint.Weld( self.WheelObjects[5],self.WheelObjects[6] , 0, 0, -1, true )

	constraint.NoCollide( self, self.BottomPropeller, 0, 0 )	
	constraint.NoCollide( self, self.TopPropeller, 0, 0 )	
	constraint.NoCollide( self.BottomPropeller, self.TopPropeller, 0, 0 )
	
	self.bottomrotoraxis = constraint.Axis( self.BottomPropeller, self, 0, 0, Vector(0,0,0) , self.BottomPropellerPos, 0, 0, 1, 0, Vector(0,0,1) )
	self.rotoraxis = constraint.Axis( self.TopPropeller, self.BottomPropeller, 0, 0, Vector(0,0,0) , self.TopPropellerPos2, 0, 0, 1, 0,Vector(0,0,1) )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 290000 )
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
	
	if ( dmginfo:GetDamagePosition():Distance( self.BottomPropeller:GetPos() ) < 90 && dmginfo:GetDamage() > 500 ) then // Direct blow to the rotor
		self:Crash()
	
	elseif ( dmginfo:GetDamagePosition():Distance( self.BottomPropeller:GetPos() ) < 90 && dmginfo:GetDamage() > 500 ) then // Direct blow to the rotor
		self:Crash()
	end
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -79 + self:GetRight() * -88 + self:GetUp() * 34
		p[2] = self:GetPos() + self:GetForward() * -79 + self:GetRight() * 88 + self:GetUp() * 34
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
	
	if( self.BottomPropeller && IsValid( self.BottomPropeller ) ) then
		
		self.BottomPropeller:Remove()
		
	end
	
	if( self.TopPropeller && IsValid( self.TopPropeller ) ) then
		
		self.TopPropeller:Remove()
	
	end

	if( self.Turret && IsValid( self.Turret ) ) then
		
		self.Turret:Remove()
	
	end

	if( self.ChopperGun && IsValid( self.ChopperGun ) ) then
		
		self.ChopperGun:Remove()
	
	end
	
	if( self.Destroyed && self.Burning ) then
		
		for i = 1, 7 do
			
			local fx = EffectData()
			fx:SetOrigin( self:GetPos()+ Vector(math.random(-200,200),math.random(-200,200),math.random(16,172)) )
			util.Effect("super_explosion", fx)
		
		end

	end
	
	for i = 1, #self.WheelObjects do
		
		if( IsValid( self.WheelObjects[i] ) ) then
			
			self.WheelObjects[i]:Remove()
		
		end
	
	end
	
	if( IsValid( self.Pilot ) ) then
	
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
			
				self:EmitSound("physics/metal/metal_box_break1.wav", 250, 60 )
			
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
		
		if( v && IsValid( v ) && math.random( 1, 2 ) == 1 ) then
			
			v:SetParent( NULL )
			v:SetSolid( SOLID_VPHYSICS )	
			v:Fire( "kill", "", 25 )
			
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
	
	for i=1,#self.WheelWelds do

		if( IsValid( self.WheelWelds[i] ) ) then
			
			self.WheelWelds[i]:Remove()
		
		end
	
	end
	
	if( self.bottomrotoraxis && IsValid( self.bottomrotoraxis ) ) then
		
		self.bottomrotoraxis:Remove()
		
	end
	
	if( self.rotoraxis && IsValid( self.rotoraxis ) ) then
	
		self.rotoraxis:Remove()

	end
	
	self.BottomPropeller:GetPhysicsObject():EnableGravity( true )
	self.TopPropeller:GetPhysicsObject():EnableGravity( true )
	self.BottomPropeller:SetOwner( NULL )
	self.TopPropeller:SetOwner( NULL )
	
	// bye bye
	self.BottomPhys:ApplyForceCenter( self:GetUp() * ( self.BottomVal * 100 ) + self:GetRight() * ( math.random( -1, 1 ) * ( self.BottomVal * 100 ) ) + self:GetForward() * ( math.random( -1, 1 ) * ( self.BottomVal * 100 ) )  )
	local ra = self.BottomPhys:GetAngles()
	local ta = self.TopPhys:GetAngles()
	self.BottomPhys:SetAngles( ra + Angle( math.random(-5,5),math.random(-5,5),math.random(-5,5) ) )

	self.TopPhys:ApplyForceCenter( self:GetUp() * ( self.BottomVal * 100 ) + self:GetRight() * ( math.random( -1, 1 ) * ( self.BottomVal * 100 ) ) + self:GetForward() * ( math.random( -1, 1 ) * ( self.BottomVal * 100 ) )  )
	local ra = self.TopPhys:GetAngles()
	self.TopPhys:SetAngles( ta + Angle( math.random(-5,5),math.random(-5,5),math.random(-5,5) ) )
	
	self.BottomPropeller:Fire( "kill", "", 25 )
	self.TopPropeller:Fire( "kill", "", 25 )
	
	if( self.HealthVal < self.InitialHealth * 0.5 ) then
			
		self:Ignite( 25, 25 )
		
	end
	
	self.LoopSound:Stop()
	
	if( self.BottomVal > 200 ) then
		
		self:EmitSound("npc/combine_gunship/gunship_explode2.wav",511,130)
	
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
	self:SetNetworkedBool("ChopperGunner",false)
	self.Pilot:SetNetworkedBool( "isGunner", false )
	self.GotChopperGunner = false
	self.Pilot:SetNetworkedEntity("ChopperGunnerEnt", NULL )
	
	self.Pilot:SetPos( self:LocalToWorld( Vector( 205, 175, -80 ) ) )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	-- self.Pilot:SetScriptedVehicle( NULL )
	
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


function ENT:FuselageAttack()

	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.ChopperGunProp:GetPos() + self.ChopperGunProp:GetForward() * 200
 	bullet.Dir 		= self.ChopperGun:GetAngles():Forward()						// Dir of bullet 
 	bullet.Spread 	= Vector( .022, .022, .052 )								// Aim Cone 
 	bullet.Tracer	= 1															// Show a tracer on every x bullets  
 	bullet.Force	= 100					 									// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 45, 65 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer"
	bullet.Attacker = self.Pilot
 	bullet.Callback    = function ( a, b, c )
								
							self:ChopperGunCallback( a, b, c )
							
						end 
 	local e = EffectData()
	e:SetStart( self.ChopperGunProp:GetPos()+self.ChopperGunProp:GetForward() * 82 )
	e:SetOrigin( self.ChopperGunProp:GetPos()+self.ChopperGunProp:GetForward() * 82 )
	e:SetEntity( self.ChopperGunProp )
	e:SetAttachment( 1 )
	util.Effect( "StriderMuzzleFlash", e )
	
	e = EffectData()
	e:SetStart( self.ChopperGunProp:GetPos()+self.ChopperGunProp:GetForward() * 72 )
	e:SetOrigin( self.ChopperGunProp:GetPos()+self.ChopperGunProp:GetForward() * 72 )
	util.Effect( "a10_muzzlesmoke", e )
	self.ChopperGun:FireBullets( bullet )
	
	self.ChopperGun:EmitSound( "ah64fire.wav", 510, math.random( 89, 111) )

	self.ChopperGunAttack = CurTime()
	
end

function ENT:ChopperGunCallback( a, b, c )

	if ( IsValid( self.Pilot ) ) then
	
		local e = EffectData()
		e:SetOrigin(b.HitPos)
		e:SetNormal(b.HitNormal)
		e:SetScale( 4.5 )
		util.Effect("HelicopterMegaBomb", e)
		e = EffectData()
		e:SetOrigin(b.HitPos)
		e:SetNormal(b.HitNormal)
		e:SetScale( 9.5 )
		util.Effect("ManhackSparks", e)
		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 100, math.random(15,69) )
		
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
	local topval = ( self.Pilot != NULL && ( self.MaxBottomVal / 2 ) ) or 0 // Should not be > 500
	
	self.BottomVal = math.Approach( self.BottomVal, topval, 1 )	
	self.Started = ( self.BottomVal >= 350 ) // Loving the hard coded values <^.^> 
	self.Starting = ( self.BottomVal > 1 && self.BottomVal < 350 && IsValid( self.Pilot ) )
	
	self.BottomPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0,  -self.BottomVal * 2 ) )
	self.TopPropeller:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0,  self.BottomVal * 2 ) )
	
	if ( self.IsFlying && !stallAng && self.Started && !self.Destroyed ) then
		
		phys:Wake()
		self:CreateRotorwash()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
		local maxang = 43

		local vel = self:GetVelocity():Length()
		if ( vel > -600 && vel < 600 ) then
			
			self.isHovering = true
			self.BankingFactor = 15
		
		else
		
			self.isHovering = false
			self.BankingFactor = 5
			
		end
	
		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 3.45
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 2.15
		
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -550, 610 )

		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0

		else

			r = ( self.offs / self.BankingFactor ) * -1

		end

		if ( self:GetVelocity():Length() < 1000 ) then 
		
			if ( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
				
				self.MoveRight = self.MoveRight - 7.5
				r  = -11
				
			elseif (  self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
				
				self.MoveRight = self.MoveRight + 7.5
				r = 11
				
			else
				
				self.MoveRight = math.Approach( self.MoveRight, 0, 0.995 )
			
			end

			self.MoveRight = math.Clamp( self.MoveRight, -596, 596 )
		
		else
		
			self.MoveRight = math.Approach( self.MoveRight, -r * 20, 1.355 )
		
		end
		
		
		if ( self.GotChopperGunner ) then
			
			if ( pilotAng.p < 5 || pilotAng.p > 300 ) then pilotAng.p = 5 end
			

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
		--local wind = Vector( math.sin( CurTime() - ( self:EntIndex() * 2 ) ) * 6, math.cos( CurTime() - ( self:EntIndex() * 2 ) ) * 5.8, math.sin( CurTime() - ( self:EntIndex() * 3 ) ) * 7 )
		
		if( self.HealthVal < 400 ) then
		
			local t = t or 0.15
			t = math.Approach( t, 4.5, 0.15 )
			
			--wind = Vector( math.sin(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64),math.cos(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64), -0.01 ) 
			pilotAng.y = pilotAng.y + t
			self.HoverVal = self.HoverVal / 2 - 5
			
		end

		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight-- + wind
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
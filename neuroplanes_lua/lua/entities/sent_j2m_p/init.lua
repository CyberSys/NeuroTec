AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName = "Mitsubishi J2M Raiden"
ENT.Model = "models/fsx/warbirds/mitsubishi j2m raiden.mdl"
//Speed Limits
ENT.MaxVelocity = 1.8 * 750
ENT.MinVelocity = 0

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 2.3

ENT.InitialHealth = 1750
ENT.HealthVal = nil
ENT.MuzzleOffset = 50
ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.Landing = 100
ENT.LandDelay = nil
ENT.ToggleGear = true

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 20, 60, 45 )
ENT.CrosshairOffset = 45

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.075

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_j2m_p" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
		
		ent:AddAdminEquipment()
		
	end
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	
	self:SetNetworkedInt( "health",self.HealthVal)
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)

	self.LastPrimaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.LastLaserUpdate = CurTime()
	self.LandDelay = CurTime()

	self.LastLandToggle = CurTime()
	self.LandingToggle = true
	self.LandDelay = CurTime()

	self.MaxPropellerVal = 1600
	self.PropellerMult = self.MaxPropellerVal / 2000
	
	self.Armament = {

					{ 
						PrintName = "Cannons",
						Mdl = "models/items/AR2_grenade.mdl" ,
						Col = Color( 0, 0, 0, 0 ), 							
						Pos = Vector( 91, 75, -15.5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.05, 										// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mgun_bullet"
					}; 	
					{ 
						PrintName = "Cannons",
						Mdl = "models/items/AR2_grenade.mdl" ,
						Col = Color( 0, 0, 0, 0 ), 							
						Pos = Vector( 89, -76.5, -14.5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.05, 										// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mgun_bullet"
					}; 	

					{ 
						PrintName = "60kg Bomb",
						Mdl = "models/props_phx/ww2bomb.mdl" ,
						Col = Color( 255, 255, 255, 255 ), 							
						Pos = Vector( 20, 0, -45), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Bomb", 										// Type, used when creating the object
						Cooldown = 10, 										// Cooldown between weapons
						isFirst	= nil,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_ww1bomb"
					}; 
		
				}
	
	self.AdminArmament = {
	
						{ // test
						PrintName = "Admin Equipment Slot", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( 0, 0, 0 ), 
						Ang = Angle( 0, 0, 0 ), 
						Type = "effect",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_a2a_rocket"
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
		self.RocketVisuals[i]:SetPos( self:LocalToWorld( v.Pos ) )
		self.RocketVisuals[i]:SetAngles( self:GetAngles() + v.Ang )
		self.RocketVisuals[i]:SetParent( self )
		self.RocketVisuals[i]:SetSolid( SOLID_NONE )
		self.RocketVisuals[i]:SetColor( v.Col )
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
		
			if ( v.Type != "Effect" ) then
				
				c = c + 1
				self.EquipmentNames[c] = {}
				self.EquipmentNames[c].Identity = i
				self.EquipmentNames[c].Name = v.PrintName
				
			end
			
		end
		
	end
	
	self.NumRockets = #self.EquipmentNames
	
	self.Trails = {}
	self.TrailPos = {}
	self.TrailPos[1] = Vector( 47.5, 212, -8.8 )
	self.TrailPos[2] = Vector( 47.5, -212, -8.9 )
	
	
	// Sound
	local esound = {}
	esound[1] = "vehicles/airboat/fan_blade_Fullthrottle_loop1.wav"
	esound[2] = "vehicles/fast_windloop1.wav"
	esound[3] = "vehicles/airboat/fan_motor_Fullthrottle_loop1.wav"
	self.EngineMux = {}
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	// Sonic Boom variables
	local fxsound = { "ambient/levels/canals/dam_water_loop2.wav", "lockon/sonicboom.mp3", "lockon/supersonic.wav" }
	self.PCfx = 0
	self.FXMux = {}
	
	for i=1, #fxsound do
	
		self.FXMux[i] = CreateSound( self, fxsound[i] )
		
	end
	
	self.Pitch = 80
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )
	self.EngineMux[3]:PlayEx( 500 , self.Pitch )
	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = NULL
	
	local minipos = { Vector( 36, 87, -14), Vector( 33, -88, -14) }
	self.Miniguns = {}
	
	for i=1,#minipos do
		
		self.Miniguns[i] = ents.Create("prop_physics_override")
		self.Miniguns[i]:SetPos( self:LocalToWorld( minipos[i] ) )
		self.Miniguns[i]:SetModel( self.MachineGunModel )
		self.Miniguns[i]:SetAngles( self:GetAngles() )
		self.Miniguns[i]:SetNoDraw( true )
		self.Miniguns[i]:SetParent( self )
		self.Miniguns[i]:SetSolid( SOLID_NONE )
		self.Miniguns[i]:Spawn()
		self.Miniguns[i].LastAttack = CurTime()
		
	end
	self.MinigunIndex = 1
	self.MinigunMaxIndex = #self.Miniguns
	
	local PropellerPos = Vector( 132, -1, 2)
	self.Propeller = ents.Create("prop_physics")
	self.Propeller:SetPos( self:LocalToWorld( PropellerPos ) )
	self.Propeller:SetModel( "models/fsx/warbirds/mitsubishi j2m raiden_propeller.mdl" )
	self.Propeller:SetSkin( self:GetSkin() )
	self.Propeller:SetAngles( self:GetAngles() )
	self.Propeller:SetCollisionGroup( COLLISION_GROUP_NONE )
	self.Propeller:Spawn()

	local wheelpos = {}
--	wheelpos[1] = Vector( 45, -63, -23 ) //Pos in the wings
--	wheelpos[2] = Vector( 45, 63, -23 ) 
//	wheelpos[1] = Vector( -11, -37, 0 ) //Pos relative to the gear
//	wheelpos[2] = Vector( 0, 0, 0 )
	wheelpos[1] = Vector( 49, 46, -51 )
	wheelpos[2] = Vector( 48, -48, -51 )
	wheelpos[3] = Vector( 49, 46, -51 )
	wheelpos[4] = Vector( 48, -48, -51 )
	local gearpos = {}
	gearpos[1] = Vector( 60, 49, -14 )
	gearpos[2] = Vector( 59, -50, -14 )
	
	self.Wheels = {}
	self.WheelWelds = {}
	self.Gear = {}
	self.GearWelds = {}
	
		self.Gear[1] = ents.Create("prop_physics")
		self.Gear[1]:SetPos( self:LocalToWorld( gearpos[1] ) )
		self.Gear[1]:SetModel( "models/fsx/warbirds/spitfire_gearr.mdl" )
		self.Gear[1]:SetAngles( self:GetAngles() + Angle(0, 0, 90 ))
		self.Gear[1]:Spawn()
		self.Gear[1]:SetParent( self )

		self.Gear[2] = ents.Create("prop_physics")
		self.Gear[2]:SetPos( self:LocalToWorld( gearpos[2] ) )
		self.Gear[2]:SetModel( "models/fsx/warbirds/spitfire_gearl.mdl" )
		self.Gear[2]:SetAngles( self:GetAngles() + Angle(0, 0, -90 ))
		self.Gear[2]:Spawn()
		self.Gear[2]:SetParent( self )

	for i = 1, 2 do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( wheelpos[i] ) )
		self.Wheels[i]:SetModel( "models/fsx/warbirds/spitfire_wheel.mdl" )
		self.Wheels[i]:SetAngles( self:GetAngles() )//+ Angle(90,0,0) )
		self.Wheels[i]:Spawn()
		self.Wheels[i]:SetParent( self.Gear[i] )

	end

	for i = 3, 4 do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( wheelpos[i] ) )
		self.Wheels[i]:SetModel( "models/fsx/warbirds/spitfire_wheel.mdl" )
		self.Wheels[i]:SetAngles( self:GetAngles() )
		self.Wheels[i]:SetNoDraw( true )
		self.Wheels[i]:Spawn()

	end

	// Misc
	self:SetModel( self.Model )	
	self:SetSkin( math.random( 0, 1 ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	if !IsValid(self.SeatPos) then
		self.SeatPos = self:GetPos()+self:GetUp()*100
	end
	self.PilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PilotSeat:SetPos( self:LocalToWorld( self.SeatPos ) )
	self.PilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PilotSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) end
	self.PilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
	self.PilotSeat:SetParent( self )
	self.PilotSeat:SetKeyValue( "LimitView", "0" )
	-- self.PilotSeat:SetColor( Color( 0,0,0,0 ) )
	self.PilotSeat:Spawn()

	self.ThirdCam = ents.Create("prop_physics")	 
	self.ThirdCam:SetModel("models/dav0r/camera.mdl")
	self.ThirdCam:SetColor( Color ( 255,255,255,0 ) )
	self.ThirdCam:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.ThirdCam:SetPos( self:GetPos() + self:GetForward() * -self.CamDist + self:GetUp() * self.CamUp )
	self.ThirdCam:SetAngles( self:GetAngles() )
	self.ThirdCam:SetParent( self )
	self.ThirdCam:Spawn()
	self.ThirdCam:SetSolid(SOLID_NONE)

	constraint.NoCollide( self, self.Propeller, 0, 0 )	
	self.PropellerAxis = constraint.Axis( self.Propeller, self, 0, 0, Vector(1,0,0) , PropellerPos, 0, 0, 1, 0 )
	for i= 1, 2 do
	constraint.NoCollide( self, self.Wheels[i], 0, 0 )	
	constraint.NoCollide( self, self.Gear[i], 0, 0 )	
		for k= 1, 2 do
		constraint.NoCollide( self.Gear[k], self.Wheels[k], 0, 0 )	
		end
	self.WheelWelds[i] = constraint.Axis( self.Wheels[i], self.Gear[i], 0, 0, Vector(0,1,0) , wheelpos[i], 0, 0, 1, 0 )
	self.GearWelds[i] = constraint.Axis( self.Gear[i], self, 0, 0, Vector(1,0,0) , gearpos[i], 0, 0, 1, 0 )

	end
	for i= 3, 4 do
	constraint.NoCollide( self, self.Wheels[i], 0, 0 )	
	constraint.NoCollide( self.Wheels[1], self.Wheels[i], 0, 0 )	
	constraint.NoCollide( self.Wheels[2], self.Wheels[i], 0, 0 )	
		constraint.NoCollide( self.Gear[1], self.Wheels[i], 0, 0 )	
		constraint.NoCollide( self.Gear[2], self.Wheels[i], 0, 0 )	
		for k= 1,2 do
		constraint.NoCollide( self.Gear[k], self.Wheels[i], 0, 0 )	
		
		end
	self.WheelWelds[i] = constraint.Weld( self.Wheels[i], self, 0,0,0,true)
	end
	constraint.Weld( self.Wheels[3], self.Wheels[4], 0,0,0,true)
	constraint.NoCollide( self.Wheels[1], self.Wheels[2], 0, 0 )	

	self.WheelPhys = {}
	self.GearPhys = {}


	self.PropellerPhys = self.Propeller:GetPhysicsObject()	
	if ( self.PropellerPhys:IsValid() ) then
	
		self.PropellerPhys:Wake()
		self.PropellerPhys:SetMass( 5000 )
		self.PropellerPhys:EnableGravity( false )
		self.PropellerPhys:EnableCollisions( true )
		
	end

	for i = 1, 2 do
	
		self.WheelPhys[i] = self.Wheels[i]:GetPhysicsObject()
		self.WheelPhys[i]:Wake()
		self.WheelPhys[i]:SetMass( 100 )
		self.WheelPhys[i]:EnableGravity( false )
		self.WheelPhys[i]:EnableCollisions( true )
--/*
		self.GearPhys[i] = self.Gear[i]:GetPhysicsObject()
		self.GearPhys[i]:Wake()
		self.GearPhys[i]:SetMass( 2000 )
		self.GearPhys[i]:EnableGravity( false )
		self.GearPhys[i]:EnableCollisions( true )
--*/
	end

	for i = 3, 4 do
	
		self.WheelPhys[i] = self.Wheels[i]:GetPhysicsObject()
		self.WheelPhys[i]:Wake()
		self.WheelPhys[i]:SetMass( 10000 )
		self.WheelPhys[i]:EnableGravity( false )
		self.WheelPhys[i]:EnableCollisions( true )
	end
	
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
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt( "health", self.HealthVal )
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then

		self.Burning = true
		
		
		local pos = { Vector( 70, 27, 1 ), Vector( 70, -27, 1 ) }
			
		for i=1,#pos do
			
			for j=1,2 do

				local f = ents.Create("env_Fire_trail")
				f:SetPos( self:LocalToWorld( pos[i] ) + Vector( math.random(-16,16), math.random(-16,16), 0 ) )
				f:SetParent( self )
				f:Spawn()
				
			end
			
		end
		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass( 2000 )
		self:Ignite( 60,100 )
		
	end
	
end

function ENT:OnRemove()

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if( self.Propeller && IsValid( self.Propeller ) ) then
		
		self.Propeller:Remove()
		
	end

	for i = 1, #self.Gear do
		
		if ( IsValid( self.Gear[i] ) ) then
			
			self.Gear[i]:Remove()
		
		end
		
	end

	for i = 1, #self.Wheels do
		
		if ( IsValid( self.Wheels[i] ) ) then
			
			self.Wheels[i]:Remove()
		
		end
		
	end

	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	
end

function ENT:PhysicsCollide( data, physobj )

//"Collision Sound" if the spitfire collide with something and crash if it fly over 70% of the maximum speed
	if ( self.Speed > self.MaxVelocity * 0.25 && data.DeltaTime > 0.2 ) then  
		self:EmitSound( "lockon/PlaneHit.mp3", 510, math.random( 100, 130 ) )
			if ( self:GetVelocity():Length() > self.MaxVelocity * 0.80 ) then
			self:DeathFX()
			end
	end
	
end

function ENT:Use(ply,caller)

	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
		
		self:Jet_DefaultUseStuff( ply, caller )
//Display player Model?
/*		self.pilotmodel = ents.Create("prop_dynamic")
		self.pilotmodel:SetModel( self.Pilot:GetModel() )
		self.pilotmodel:SetPos( self:GetPos() + self:GetForward() * -3 + self:GetUp() * -8 )
		self.pilotmodel:SetAngles( self:GetAngles() )
		self.pilotmodel:SetSolid( SOLID_NONE )
		self.pilotmodel:SetParent( self )
		self.pilotmodel:SetKeyValue( "DefaultAnim", "ACT_DRIVE_AIRBOAT" )
		self.pilotmodel:SetKeyValue( "disableshadows", 1 )
		self.pilotmodel:Spawn()
		self.pilotmodel:SetColor( Color( 255,255,255,255 ) )
		//self:UpdatePilotModel()
*/	
	end
	
end

function ENT:Think()
	
	self.Propeller:SetSkin( self:GetSkin() )

	self:NextThink( CurTime() )
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ), 0, 200 )
	
	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	

	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + Vector( math.random(-50,50), math.random(-50,50), 0 ) )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if ( self.DeathTimer > 150 ) then
		
			self:EjectPilot()
			self:DeathFX()
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		self:UpdateRadar()
		self:SonicBoomTicker()
		self:Jet_LockOnMethod()
		self:NeuroPlanes_CycleThroughJetKeyBinds()
		
// Landing animation script
		if ( self.Pilot:KeyDown( IN_DUCK ) and self.LastLandToggle + 0.25 <= CurTime() ) then		
			self:EmitSound("lockon/TurretRotation.mp3",511,100)
				
		//Toggle system :D
			if !self.LandingToggle && ( self:GetVelocity():Length() < self.MaxVelocity * 0.60 ) then
			self.LandingToggle = true 	
			else
				if self.LandingToggle && ( self:GetVelocity():Length() > self.MaxVelocity * 0.50 ) then
				self.LandingToggle = false
				end
			end		
			self.LastLandToggle = CurTime()
		
		end
	

		
		if ( self.LandingToggle ) then		
			self.Landing = self.Landing + 1

			if self.Landing >= 90 then 
				self.Landing =90 
					for i= 3, 4 do			
					self.WheelPhys[i]:EnableCollisions( true )
					self.WheelPhys[i]:SetMass( 10000 )
					end
				self:StopSound( "lockon/TurretRotation.mp3" )
			end
			
		end
	
		if ( !self.LandingToggle ) then	
			self.Landing = self.Landing - 1

			if ( self.Landing < 0 ) then 
				self.Landing = 0
					for i= 3, 4 do			
					self.WheelPhys[i]:EnableCollisions( false )
					self.WheelPhys[i]:SetMass( 100 )
					end
				self:StopSound( "lockon/TurretRotation.mp3" )
			end

		end
					
		self.Gear[1]:SetLocalAngles( Angle(0, 0, 0.9 * self.Landing ) )
		self.Gear[2]:SetLocalAngles( Angle(0, 0, 0.9 * -self.Landing ) ) 

//end of landing script
	
	end

	if( self:WaterLevel() > 0 ) then
		
	self.WheelPhys[3]:SetMass( 10 )
	self.WheelPhys[4]:SetMass( 10 )
	else
	self.WheelPhys[3]:SetMass( 10000 )
	self.WheelPhys[4]:SetMass( 10000 )

	end

	return true
	
end

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	self:Jet_FireMultiBarrel()
	self:EmitSound( "IL-2/gun_17_22.mp3", 510, math.random( 100, 130 ) )
	
	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )

	local a = self:GetAngles()
	local stallang = ( ( a.p < -24 || a.r > 24 || a.r < -24 ) && self:GetVelocity():Length() < 500 )

	
	if ( self.IsFlying && !stallang ) then
	
		phys:Wake()
		
		local p = { { Key = IN_FORWARD, Speed = 2.5 };
					{ Key = IN_BACK, Speed = -3 }; }
					
		for k,v in ipairs( p ) do
			
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
			
			end
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * -self.CrosshairOffset // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local r,pitch,vel
		self.offs = self:VecAngD( ma.y, ta.y )		

		if( self.offs < -160 || self.offs > 160 ) then r = 0 else r = ( self.offs / self.BankingFactor ) * -1 end
		

		pitch = pilotAng.p
		vel =  math.Clamp( self:GetVelocity():Length() / 13.5, 10, 120 )
		
		if( self:GetVelocity():Length() < 200 ) then	
			
			pilotAng.y = ma.y
		
		end
		
		// Increase speed going down, decrease it going up
		if( ma.p < -25 || ma.p > 23 && !self.AfterBurner ) then self.Speed = self.Speed + ma.p/8.55 end
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + Vector( 0,0, -200 + ( self:GetVelocity():Length() / 6 ) )
		pr.maxangular		= 158 - vel
		pr.maxangulardamp	= 258 - vel
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.95
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( pitch, pilotAng.y, pilotAng.r ) + Angle( 0, 0, r )
		
		phys:ComputeShadowControl( pr )
			
		self:WingTrails( ma.r, 20 )
	end
//Propeller Script
	if( IsValid( self.Propeller ) ) then
		
		local spinval = self.Speed
		if( self.Speed == 0 ) then
			
			spinval = 100
		
		end
		
		self.Propeller:GetPhysicsObject():AddAngleVelocity( Vector( spinval/50, 0, 0 ) )
	end
	
end

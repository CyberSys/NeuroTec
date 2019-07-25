AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName = "Boeing B-17 Flying Fortress"
ENT.Model = "models/fsx/warbirds/b-17 flying fortress.mdl"
--Speed Limits
ENT.MaxVelocity = 1.8 * 810
ENT.MinVelocity = 0

-- How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 4.5

ENT.InitialHealth = 10000
ENT.MuzzleOffset = 50
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.Landing = 100
ENT.LandDelay = nil
ENT.ToggleGear = true

-- Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8

-- Equipment
ENT.MachineGunModel = "models/fsx/warbirds/b-17 flying fortress_mgun.mdl"
ENT.MachineGunOffset = Vector( 20, 60, 45 )
ENT.CrosshairOffset = 45

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.08

-- Co-pilot variables
ENT.SpawnPassengerSeat = true


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_B-17_p" )
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
	self.TurretSwitch = false
	self.LastTowerAttack = CurTime()
	
	self.LastLandToggle = CurTime()
	self.LandingToggle = true
	self.LandDelay = CurTime()

	self.MaxPropellerVal = 1600
	self.PropellerMult = self.MaxPropellerVal / 2000
	
	self.Armament = {
 
						{ 
							PrintName = "GBU-10",
							Mdl = "models/military2/bomb/bomb_gbu10.mdl" ,
							Pos = Vector( 21, 0, -35), 							-- Pos, Hard point location on the plane fuselage.
							Ang = Angle( 0, 0, 0), 								-- Ang, object angle
							Type = "Bomb", 										-- Type, used when creating the object
							Cooldown = 1, 										-- Cooldown between weapons
							isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							Class = "sent_jdam_medium"
						}; 				
						{ 
							PrintName = "Napalm",
							Mdl = "models/props_c17/oildrum001_explosive.mdl" ,
							Pos = Vector( 5, 25, -35), 							-- Pos, Hard point location on the plane fuselage.
							Ang = Angle( 90, 0, 0), 								-- Ang, object angle
							Type = "Bomb", 										-- Type, used when creating the object
							Cooldown = 2, 										-- Cooldown between weapons
							isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							Class = "sent_napalm_bomb"
						}; 
			
					}

	-- Armamanet
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
		
		if ( v.isFirst == true || v.isFirst == nil ) then
		
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
	self.TrailPos = {Vector( 26, 610, 47 ),Vector( 26, -610, 47 ) }
	self.EngineRunning = false
	
	
	-- Sound
	local esound = {}
	esound[1] = "npc/manhack/mh_engine_loop1.wav"
	esound[2] = "npc/manhack/mh_engine_loop1.wav"
	esound[3] = "npc/manhack/mh_engine_loop2.wav"
	self.EngineMux = {}
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	-- Sonic Boom variables
	local fxsound = { "ambient/levels/canals/dam_water_loop2.wav", "lockon/sonicboom.mp3", "lockon/supersonic.wav" }
	self.PCfx = 100
	self.FXMux = {}
	
	for i=1, #fxsound do
	
		self.FXMux[i] = CreateSound( self, fxsound[i] )
		
	end
	

	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = NULL
	
	local minipos = { Vector( 285, 30, 25), Vector( 255, -38, 25) }
	self.Miniguns = {}
	
	for i=1,#minipos do
		
		self.Miniguns[i] = ents.Create("prop_physics_override")
		self.Miniguns[i]:SetPos( self:LocalToWorld( minipos[i] ) )
		self.Miniguns[i]:SetModel( self.MachineGunModel )
		self.Miniguns[i]:SetAngles( self:GetAngles() )
		self.Miniguns[i]:SetParent( self )
		self.Miniguns[i]:SetSolid( SOLID_NONE )
		self.Miniguns[i]:Spawn()
		self.Miniguns[i].LastAttack = CurTime()
		
	end
	self.MinigunIndex = 1
	self.MinigunMaxIndex = #self.Miniguns
	
	local PropellerPos = { Vector( 209, 120, 2), Vector( 209, -120, 2), Vector( 185, 254, 18), Vector( 185, -254, 18) }
	self.Propeller = {}
	for i = 1, 4 do		
		self.Propeller[i] = ents.Create("prop_physics")
		self.Propeller[i]:SetPos( self:LocalToWorld( PropellerPos[i] ) )
		self.Propeller[i]:SetModel( "models/fsx/warbirds/b-17 flying fortress_propeller.mdl" )
		self.Propeller[i]:SetAngles( self:GetAngles() )
		self.Propeller[i]:Spawn()
	end

	local wheelpos = {}
	wheelpos[1] = Vector( 85, 126, -74 )
	wheelpos[2] = Vector( 85, -126, -74 )
	wheelpos[3] = Vector( 85, 126, -74 )
	wheelpos[4] = Vector( 85, -126, -74 )
--	wheelpos[5] = Vector( -345, 0, 2 )
	wheelpos[5] = Vector( -338, 0, -34 )
	wheelpos[6] = Vector( -338, 0, -34 )
	local gearpos = {}
	gearpos[1] = Vector( 86, 109, -21 )
	gearpos[2] = Vector( 86, -109, -21 )
	gearpos[3] = Vector( -310, 0, -10 )
	
	self.Wheels = {}
	self.WheelWelds = {}
	self.Gear = {}
	self.GearWelds = {}
	
		self.Gear[1] = ents.Create("prop_physics")
		self.Gear[1]:SetPos( self:LocalToWorld( gearpos[1] ) )
		self.Gear[1]:SetModel( "models/fsx/warbirds/b-17 flying fortress_gearl.mdl" )
		self.Gear[1]:SetAngles( self:GetAngles() + Angle(90, 0, 0 ))
		self.Gear[1]:Spawn()
		self.Gear[1]:SetParent( self )

		self.Gear[2] = ents.Create("prop_physics")
		self.Gear[2]:SetPos( self:LocalToWorld( gearpos[2] ) )
		self.Gear[2]:SetModel( "models/fsx/warbirds/b-17 flying fortress_gearr.mdl" )
		self.Gear[2]:SetAngles( self:GetAngles() + Angle(90, 0, 0 ))
		self.Gear[2]:Spawn()
		self.Gear[2]:SetParent( self )

		self.Gear[3] = ents.Create("prop_physics")
		self.Gear[3]:SetPos( self:LocalToWorld( gearpos[3] ) )
		self.Gear[3]:SetModel( "models/fsx/warbirds/b-17 flying fortress_gearB.mdl" )
		self.Gear[3]:SetAngles( self:GetAngles() + Angle( -60, 0, 0 ))
		self.Gear[3]:Spawn()
		self.Gear[3]:SetParent( self )

	for i = 1, 2 do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( wheelpos[i] ) )
		self.Wheels[i]:SetModel( "models/fsx/warbirds/b-17 flying fortress_wheel.mdl" )
		self.Wheels[i]:SetAngles( self:GetAngles() )
		self.Wheels[i]:Spawn()
		self.Wheels[i]:SetParent( self.Gear[i] )

	end

	for i = 3, 4 do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( wheelpos[i] ) )
		self.Wheels[i]:SetModel( "models/fsx/warbirds/b-17 flying fortress_wheel.mdl" )
		self.Wheels[i]:SetAngles( self:GetAngles() )
		self.Wheels[i]:SetNoDraw( true )
		self.Wheels[i]:Spawn()

	end
		self.Wheels[5] = ents.Create("prop_physics")
		self.Wheels[5]:SetPos( self:LocalToWorld( wheelpos[5] ) )
		self.Wheels[5]:SetModel( "models/fsx/warbirds/b-17 flying fortress_tailwheel.mdl" )
		self.Wheels[5]:SetAngles( self:GetAngles() )
		self.Wheels[5]:Spawn()
		self.Wheels[5]:SetParent( self.Gear[3] )

		self.Wheels[6] = ents.Create("prop_physics")
		self.Wheels[6]:SetPos( self:LocalToWorld( wheelpos[6] ) )
		self.Wheels[6]:SetModel( "models/fsx/warbirds/b-17 flying fortress_tailwheel.mdl" )
		self.Wheels[6]:SetAngles( self:GetAngles() )
		self.Wheels[6]:SetNoDraw( true )
		self.Wheels[6]:Spawn()
	
	-- for i=1,#self.Wheels do
		
		-- self.Wheels[i]:GetPhysicsObject():SetMass( 1500 )
	
	-- end
	
	if( self.SpawnPassengerSeat ) then
	
		self.CoPilotSeatVector = Vector( 122, 0, 48 )
		
		self.CoSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		self.CoSeat:SetPos( self:LocalToWorld( self.CoPilotSeatVector ) )
		self.CoSeat:SetModel( "models/nova/jeep_seat.mdl" )
		self.CoSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.CoSeat:SetKeyValue( "limitview", "0" )
		self.CoSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.CoSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		self.CoSeat:SetParent( self )
		self.CoSeat:SetNoDraw( true )
		self.CoSeat:Spawn()
		self.CoSeat.IsB17Seat = true
		
	end

	self.RoofTurretGlass = ents.Create("prop_physics_override")
	self.RoofTurretGlass:SetPos( self:LocalToWorld( Vector( 122,0, 77 ) ) )
	self.RoofTurretGlass:SetModel( "models/fsx/warbirds/b-17 flying fortress_turret_top.mdl" )
	self.RoofTurretGlass:SetAngles( self:GetAngles() )
	self.RoofTurretGlass:SetParent( self )
	self.RoofTurretGlass:Spawn()
/*	
	self.RoofTurret= ents.Create("prop_physics_override")
	self.RoofTurret:SetPos( self.RoofTurretGlass:GetPos() )
	self.RoofTurret:SetModel( "models/fsx/warbirds/b-17 flying fortress_turret_top_gun.mdl" )
	self.RoofTurret:SetAngles( self:GetAngles() + Angle( -25, 0, 0 ) )
	self.RoofTurret:SetParent( self.RoofTurretGlass )
	self.RoofTurret:Spawn()
*//*	
	self.BellyTurretGlass = ents.Create("prop_physics_override")
	self.BellyTurretGlass:SetPos( self:LocalToWorld( Vector( -108, 0, -39 ) ) )
	self.BellyTurretGlass:SetModel( "models/fsx/warbirds/b-17 flying fortress_turret_bottom.mdl" )
	self.BellyTurretGlass:SetAngles( self:GetAngles() ) 
	self.BellyTurretGlass:SetParent( self )
	self.BellyTurretGlass:Spawn()
*/	
	self.BackTurretGlass = ents.Create("prop_physics_override")
	self.BackTurretGlass:SetPos( self:LocalToWorld( Vector( -514, 0, 20 ) ) )
	self.BackTurretGlass:SetModel( "models/fsx/warbirds/b-17 flying fortress_turret_back.mdl" )
	self.BackTurretGlass:SetAngles( self:GetAngles() + Angle( -180, 0, -180 ) )  
	self.BackTurretGlass:SetParent( self )
	self.BackTurretGlass:Spawn()
/*	
	self.BackTurret= ents.Create("prop_physics_override")
	self.BackTurret:SetPos( self.BackTurretGlass:GetPos() + self.BackTurretGlass:GetRight()*-0.5 )
	self.BackTurret:SetModel( "models/fsx/warbirds/b-17 flying fortress_turret_back_gun.mdl" )
	self.BackTurret:SetAngles( self:GetAngles() + Angle( -180, 0, 0 ) )
	self.BackTurret:SetParent( self.BackTurretGlass )
	self.BackTurret:Spawn()
*/		
	local cname = {}
	cname[1] 	= "Roof Turret"
	cname[2] 	= "Belly Turret"
	cname[3] 	= "Rear Turret"
	cname[4] 	= "Right Turret"
	cname[5] 	= "Left Turret"

	local cpos  = {}
	cpos[1] = Vector( 123, 0, 82 )
	cpos[2] = Vector( -108, 0, -39 )
	cpos[3] = Vector( -514, 0, 20 )
	cpos[4] = Vector( -218, 30, 20 )
	cpos[5] = Vector( -157, -33, 20 )

	-- Weapon Angle
	local cang  = {}
	cang[1] 	= Angle(-25,0,0)
	cang[2] 	= Angle(0,0,0)
	cang[3] 	= Angle(180,0,-180)
	cang[4] 	= Angle(0,90,0)
	cang[5] 	= Angle(0,-90,0)

	-- Weapon minimum Angle
	local cminang  = {}
	cminang[1] 	= 0
	cminang[2] 	= -89
	cminang[3] 	= -25
	cminang[4] 	= -35
	cminang[5] 	= -35

	-- Weapon maximum Angle
	local cmaxang  = {}
	cmaxang[1] 	= 40
	cmaxang[2] 	= 0
	cmaxang[3] 	= 20
	cmaxang[4] 	= 45
	cmaxang[5] 	= 45

	-- Cooldown in seconds
	local cd  	= {}
	cd[1] 		= 0.075
	cd[2] 		= 0.125
	cd[3] 		= 0.1
	cd[4] 		= 0.07
	cd[5] 		= 0.07
		
	local cmdl = {}
	cmdl[1] = "models/fsx/warbirds/b-17 flying fortress_turret_top_gun.mdl"
	cmdl[2] = "models/fsx/warbirds/b-17 flying fortress_turret_bottom.mdl"
	cmdl[3] = "models/fsx/warbirds/b-17 flying fortress_turret_back_gun.mdl"
	cmdl[4] = "models/fsx/warbirds/b-17 flying fortress_mgun.mdl"
	cmdl[5] = "models/fsx/warbirds/b-17 flying fortress_mgun.mdl"
	
	self.Cannons = {}
	
	for i=1, #cname do
		
		self.Cannons[i] = ents.Create( "prop_physics_override" )
		self.Cannons[i]:SetPos( self:GetPos() + cpos[ i ] )
		self.Cannons[i]:SetAngles( self:GetAngles() + cang[ i ] )
		self.Cannons[i]:SetSolid( SOLID_NONE )
		self.Cannons[i]:SetModel( cmdl[i] )
		self.Cannons[i]:Spawn()
		self.Cannons[i]:SetParent( self )
		self.Cannons[i]:SetOwner( self )
		self.Cannons[i]:SetPhysicsAttacker( self )
		self.Cannons[i].Cooldown = cd[ i ]
		self.Cannons[i].PrintName = cname[ i ]
		self.Cannons[i].LastAttack = CurTime()
		self.Cannons[i].MinPitch = cminang[i]
		self.Cannons[i].MaxPitch = cmaxang[i]
		--self.Cannons[i].CallBack = function() end
		--self.Cannons[i]:GetPhysicsObject():SetMass( 5 )
		
	end

	local gunnerseats = {}
	local gunnerangles = {}

	gunnerseats[1] = Vector( 122,-1, 22 )
	gunnerseats[2] = Vector( -108, 0, -98 )
	gunnerseats[3] = Vector( -500, 0, -18 )
	gunnerseats[4] = Vector( -218, 5, -30 )
	gunnerseats[5] = Vector( -157, -5, -30 )

	gunnerangles[1] = Angle( 0, 0, 0 )
	gunnerangles[2] = Angle( 0, 0, 0 )
	gunnerangles[3] = Angle( 180, 0, 180 )
	gunnerangles[4] = Angle( 0, 90, 0 )
	gunnerangles[5] = Angle( 0, -90, 0 )
	
	local vFov = {}
	vFov[1] = 70
	vFov[2] = 60
	vFov[3] = 80
	vFov[4] = 65
	vFov[5] = 65
	
	self.GunnerSeats = {}
	
	for i=1,#gunnerseats do
		
		self.GunnerSeats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.GunnerSeats[i]:SetPos( self:LocalToWorld( gunnerseats[i] ) )
		self.GunnerSeats[i]:SetModel( "models/vehicles/prisoner_pod_inner.mdl" )
		self.GunnerSeats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.GunnerSeats[i]:SetAngles( self:GetAngles() + gunnerangles[i] )
		self.GunnerSeats[i].MountedWeapon = self.Cannons[i]
		self.GunnerSeats[i]:SetParent( self )
		self.GunnerSeats[i]:Spawn() 
		self.GunnerSeats[i]:SetNoDraw( true )
		self.GunnerSeats[i].FOV = vFov[i]
		if (i == 3) or (i == 4) or (i == 5) then 
		self.GunnerSeats[i]:SetKeyValue( "LimitView", "15" )
		else
		self.GunnerSeats[i]:SetKeyValue( "LimitView", "0" )
		end
		
	end

	-- Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PropellerAxis = {}
	self.PropellerPhys = {}
	for i= 1, 4 do
	constraint.NoCollide( self, self.Propeller[i], 0, 0 )	
	self.PropellerAxis[i] = constraint.Axis( self.Propeller[i], self, 0, 0, Vector(1,0,0) , PropellerPos[i], 0, 0, 1, 0 )
	self.PropellerPhys[i] = self.Propeller[i]:GetPhysicsObject()	
		if ( self.PropellerPhys[i]:IsValid() ) then
		
			self.PropellerPhys[i]:Wake()
			self.PropellerPhys[i]:SetMass( 2000 )
			self.PropellerPhys[i]:EnableGravity( false )
			self.PropellerPhys[i]:EnableCollisions( true )
			
		end		
	end
	
	for i= 1, 2 do
	constraint.NoCollide( self, self.Wheels[i], 0, 0 )	
	constraint.NoCollide( self, self.Gear[i], 0, 0 )	
	constraint.NoCollide( self.Propeller[i], self.Propeller[i+2], 0, 0 )	
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

	for i = 5, 6 do 
	constraint.NoCollide( self, self.Wheels[i], 0, 0 )	
	constraint.NoCollide( self.Gear[3], self.Wheels[i], 0, 0 )	
	end
	constraint.NoCollide( self.Wheels[5], self.Wheels[6], 0, 0 )	
	constraint.Weld( self.Wheels[5], self, 0,0,0,true)

	self.WheelPhys = {}
	self.GearPhys = {}



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
		self.WheelPhys[6] = self.Wheels[6]:GetPhysicsObject()
		self.WheelPhys[6]:Wake()
		self.WheelPhys[6]:SetMass( 10000 )
		self.WheelPhys[6]:EnableGravity( false )
		self.WheelPhys[6]:EnableCollisions( true )
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(10000)
		
	end
	
	self.Pitch = 110
	self.LastUse = 0
	
	self:StartMotionController()
	
end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	for i=1,#self.GunnerSeats do
		
		local s = self.GunnerSeats[i]:GetDriver()
		
		if ( IsValid( s ) ) then
			
			s:SetHealth( self.HealthVal )
			
		end
		
	end

	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt( "health", self.HealthVal )
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then

		self.Burning = true
		
		
		local pos = { Vector( 200, 120, 2 ), Vector( 123, -120, 2 ), Vector( 176, 254, 18 ), Vector( 176, -254, 18 ) }
			
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
	
	for i = 1, 4 do
		if( self.Propeller[i] && IsValid( self.Propeller[i] ) ) then
			
			self.Propeller[i]:Remove()
			
		end
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

	for i=1,#self.GunnerSeats do
		
		local s = self.GunnerSeats[i]:GetDriver()
		
		if ( s && IsValid( s ) ) then
			
			s:ExitVehicle()

		end
		
	end

end

function ENT:PhysicsCollide( data, physobj )

--"Collision Sound" if the B-17 Flying Fortress collide with something and crash if it fly over 70% of the maximum speed
	if ( self.Speed > self.MaxVelocity * 0.25 && data.DeltaTime > 0.2 ) then  
		self:EmitSound( "lockon/PlaneHit.mp3", 510, math.random( 100, 130 ) )
			if ( self:GetVelocity():Length() > self.MaxVelocity * 0.70 ) then
			self:DeathFX()
			end
	end
	
end

function ENT:Use(ply,caller)
	
	if( !self.LastUse ) then self.LastUse = CurTime() end
	if( self.LastUse + 1.0 >= CurTime() ) then return end
	
	self.LastUse = CurTime()
	
	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
		
		self:Jet_DefaultUseStuff( ply, caller )
		
		for i= 1, 4 do
	
			if( IsValid( self.Propeller[i] ) ) then
				

				self.Propeller[i]:EmitSound( "vehicles/airboat/fan_motor_start1.wav", 350, 100 )
				timer.Simple( 0.9, function() if( IsValid( self.Propeller[i] ) ) then self.Propeller[i]:StopSound( "vehicles/airboat/fan_motor_start1.wav" ) end end )
		
			end
			
		end	
	
		timer.Simple( 1, function() if( IsValid( self ) ) then 
				
				self.Pitch = 100
				self.EngineMux[1]:PlayEx( 511 , self.Pitch )
				self.EngineMux[2]:PlayEx( 511 , self.Pitch )
				self.EngineMux[3]:PlayEx( 511 , self.Pitch )
			
			end 
			
		end )
		
	else
/*		
		if( !self.SpawnPassengerSeat ) then return end
		if( IsValid( self.CoPilot ) ) then return end

		ply:EnterVehicle( self.CoSeat )
		self.CoPilot = ply
		ply:SetNetworkedEntity( "Neuroplanes_B17_roofturret", self.RoofTurret )
		//self.CoPilot:SetNetworkedBool("NeuroPlanes_DrawB17Crosshair", true )
		self.CoPilot:SetNoDraw( true )
*/	
		if !(ply == self.Pilot) then
		
			for i=1,#self.GunnerSeats do
				
				local s = self.GunnerSeats[i]:GetDriver()
				
				if ( !IsValid( s ) ) then
					
					if( IsValid( self.Pilot ) ) then
						
						self.Pilot:PrintMessage( HUD_PRINTCENTER, ply:Name().." joined the party!" )
						
					end
					
					ply:EnterVehicle( self.GunnerSeats[i] )
					ply.OriginalFOV = ply:GetFOV()
					-- ply:SetFOV( self.GunnerSeats[i].FOV, 0.15 )
					ply:SetNetworkedEntity( "NeuroPlanesMountedGun", self.GunnerSeats[i].MountedWeapon )
					ply:SetNetworkedEntity( "NeuroPlanesAC130", self )
					ply:DrawWorldModel( false )
					ply:SetNoDraw( true )
					ply:PrintMessage( HUD_PRINTCENTER, self.Cannons[i].PrintName )
					ply.LastSwap = CurTime()
					-- ply:SetHealth( self.HealthVal )
					
					break
					
				end
			
			end
		
		end
		
	end
	
end

function ENT:Think()
	
	self:NextThink( CurTime() )
	if( self.LastUse + 2.0 >= CurTime() ) then return end
	
	self.Pitch = Lerp( 0.1, self.Pitch, math.Clamp( math.floor( self:GetVelocity():Length() ), 80, 135 ) )
	
	for i = 1,3 do
		
		
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	

	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + Vector( math.random(-50,50), math.random(-50,50), 0 ) )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if ( self.DeathTimer > 150 ) then
			
			for i=1,3 do
			
				self:NeuroTec_Explosion( self:GetPos() + self:GetForward() * math.random( -300,300 ), 256, 1500, 2500, "ap_impact_wall" )
			
			end
			
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
		
		if( !IsValid( self.Pilot ) ) then return end
		
--// Landing animation script
		if ( self.Pilot:KeyDown( IN_DUCK ) and self.LastLandToggle + 0.25 <= CurTime() ) then		
		
			self:EmitSound("lockon/TurretRotation.mp3",511,100)
				
			//Toggle system :D
			if !self.LandingToggle && ( self:GetVelocity():Length() < self.MaxVelocity * 0.50 ) then
				
				self.LandingToggle = true 	
			
			else if self.LandingToggle && ( self:GetVelocity():Length() > self.MaxVelocity * 0.50 ) then
				
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
				
				self.WheelPhys[6]:SetMass( 10000 )
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
				
				self.WheelPhys[6]:SetMass( 100 )
				self:StopSound( "lockon/TurretRotation.mp3" )
				
			end

		end
					
		self.Gear[1]:SetLocalAngles( Angle( self.Landing, 0, 0 ) )
		self.Gear[2]:SetLocalAngles( Angle( self.Landing, 0, 0 ) ) 
		self.Gear[3]:SetLocalAngles( Angle( -self.Landing * 60/90, 0, 0 ) ) 

----end of landing script


	end
	
	if( IsValid( self.CoPilot ) ) then
		
		local a = self.CoPilot:GetPos() + self.CoPilot:GetAimVector() * 3000
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.Co_offs = self:VecAngD( ma.y, ta.y )	
		self.poffs = self:VecAngD( ma.p, ta.p )
		local angg = self:GetAngles()
		local _t = self.RoofTurretGlass:GetAngles()
		
		angg:RotateAroundAxis( self:GetUp(), -self.Co_offs + 180 )
	
		self.RoofTurretGlass:SetAngles( LerpAngle( 0.5, _t, angg ) )
		
		_t = self.RoofTurretGlass:GetAngles() // Update the variable post-change
		
		self.RoofTurret:SetAngles( Angle( math.Clamp( _t.p + self.poffs/2 -10, _t.p -45, _t.p ), _t.y, _t.r ) )
		
		if( ( self.CoPilot:KeyDown( IN_ATTACK ) || self.CoPilot:KeyDown( IN_ATTACK ) ) && self.LastTowerAttack + 0.15 <= CurTime() ) then
			
				
			--self.CoPilot:SetEyeAngles( self.CoPilot:EyeAngles() + Angle( math.Rand( -.1,.1 ), math.Rand( -.1,.1 ), 0 ) )
		
			self.LastTowerAttack = CurTime()
			self.TurretSwitch = !self.TurretSwitch
			
			self:TurretAttack()
		
		end
		
		
	end
	
	-- Gunners
	for i=1,#self.GunnerSeats do
	
		if ( !IsValid( self.Cannons[i] ) ) then print( "invalid entity: Cannon#"..i ) return end
		
		local g = self.GunnerSeats[i]:GetDriver()
		
		if ( IsValid( g ) ) then
			
				local cAng = self.Cannons[i]:GetAngles()
				local gAng = g:EyeAngles()
				local eAng = self:GetAngles()

				self.g_offs = self:VecAngD( eAng.y, gAng.y )	
				local _rt = self.RoofTurretGlass:GetAngles()	
				local _bt = self.BackTurretGlass:GetAngles()	
				eAng:RotateAroundAxis( self:GetUp(), -self.g_offs )	
		
				if i == 1 then	self.RoofTurretGlass:SetAngles( LerpAngle( 0.5, _rt, eAng ) )	end
				if i == 3 then	self.BackTurretGlass:SetAngles( LerpAngle( 0.5, _bt, eAng ) )	end
								
//				local a = self.Cannons[i]:GetAngles()
//				local ga = g:EyeAngles()
				self.g_poffs = self:VecAngD( eAng.p, gAng.p )
				local ga = self.g_poffs
				ga = math.Clamp( ga, self.Cannons[i].MinPitch, self.Cannons[i].MaxPitch )
				
//				self.Cannons[i]:SetAngles( Angle( ga.p, ga.y, a.r ) )
					
				self.Cannons[i]:SetAngles( LerpAngle( 0.1, cAng, Angle(eAng.p-ga,eAng.y,eAng.r) ) )
			
			
			
			--print( self.Cannons[i].LastAttack, self.Cannons[i].Cooldown )
			
			if ( ( g:KeyDown( IN_ATTACK ) ||  g:KeyDown( IN_ATTACK2 ) ) && self.Cannons[i].LastAttack + self.Cannons[i].Cooldown <= CurTime() ) then
				
				self.Cannons[i].LastAttack = CurTime()
				self.TurretSwitch = !self.TurretSwitch
				self:TurretAttack(i)
				
			end
			
	
			if( g:KeyDown( IN_RELOAD ) && g.LastSwap + 1.0 <= CurTime() ) then
			-- if( g:KeyDown( IN_RELOAD ) ) then
				
				local a = self.GunnerSeats[i+1]
				if( !IsValid( a ) ) then
				
					a = self.GunnerSeats[1]
					-- print( "i+1 not valid")
				else
				a = self.GunnerSeats[i+1]					
				end
				
				if( !IsValid( a:GetDriver() ) ) then
					-- print("no driver found")
					
					g.LastSwap = CurTime()
					
					local p = g
					
					g:ExitVehicle()
					
					p:EnterVehicle( a )
					
					p.OriginalFOV = p:GetFOV()
					p:SetFOV( a.FOV, 0.15 )
					p:SetNetworkedEntity( "NeuroPlanesMountedGun", a.MountedWeapon )
					p:SetNetworkedEntity( "NeuroPlanesAC130", self )
					p:DrawWorldModel( false )
					p:SetNoDraw( true )
					p:PrintMessage( HUD_PRINTCENTER, a.MountedWeapon.PrintName )
					
				end
				
			end
		
		end

	end

	if( self:WaterLevel() > 0 ) then
		
		self.WheelPhys[3]:SetMass( 10 )
		self.WheelPhys[4]:SetMass( 10 )
		self.WheelPhys[6]:SetMass( 10 )
		
	else
	
		self.WheelPhys[3]:SetMass( 10000 )
		self.WheelPhys[4]:SetMass( 10000 )
		self.WheelPhys[6]:SetMass( 10000 )

	end

	return true
	
end

local TurretMuzzlePos = { Vector( 45, 15, 0 ), Vector( 50, 15, 0 ), Vector( 35, 5, 0 ), Vector( 55, 0, 0 ), Vector( 55, 0, 0 ) }
local TurretProjectiles = { "sent_aa_flak", "sent_mgun_bullet", "sent_mgun_bullet", "sent_mgun_bullet", "sent_mgun_bullet"   }

function ENT:TurretAttack( n )
	
	local pos = self.Cannons[n]:LocalToWorld( TurretMuzzlePos[n] )
	
	if ( self.TurretSwitch ) then	
		
		local a = TurretMuzzlePos[n]
		pos = self.Cannons[n]:LocalToWorld( Vector( a.x, -a.y, a.z ) )
		
	end
	
	local shell = ents.Create(TurretProjectiles[n] )
	shell:SetPos( pos )
	shell:SetOwner( self )
	shell.Owner = self
	shell:SetAngles( self.Cannons[n]:GetAngles() + Angle( math.Rand( -1.5,1.5 ),math.Rand( -1.5,1.5 ),math.Rand( -1.5,1.5 ) ) )
	shell:Spawn()
	shell:GetPhysicsObject():SetVelocity( shell:GetForward() * 10000 )
	shell:SetNoDraw( true )
	
	local sm = EffectData()
	sm:SetStart( pos )
	sm:SetOrigin( pos )
	sm:SetScale( 10.5 )
	util.Effect( "a10_muzzlesmoke", sm )
	ParticleEffect( "AA_muzzleflash", pos,  self.Cannons[n]:GetAngles(), self.Cannons[n] )
	-- local e = EffectData()
	-- e:SetStart( pos + self.Cannons[n]:GetForward() * 64 )
	-- e:SetOrigin( pos + self.Cannons[n]:GetForward() * 64 )
	-- e:SetEntity( self.Cannons[n] )
	-- e:SetAttachment( 1 )
	-- util.Effect( "ChopperMuzzleFlash", e )
		
	if n== 1 then self.Cannons[n]:EmitSound( "50cal.wav", 511, 100 + ( math.sin( CurTime() ) * 10 ) + math.random( -5,5 ) ) end
	if n== 2 then self.Cannons[n]:EmitSound( "IL-2/gun_17_22.mp3", 511, 100 + ( math.sin( CurTime() ) * 10 ) + math.random( -5,5 ) ) end
 	if n== 3 then self.Cannons[n]:EmitSound( "IL-2/gun_17_22.mp3", 511, 100 + ( math.sin( CurTime() ) * 10 ) + math.random( -5,5 ) ) end
	if n> 3 then self.Cannons[n]:EmitSound( "ac-130/ac-130_25mm_Fire.wav", 511, 100 + ( math.sin( CurTime() ) * 10 ) + math.random( -5,5 ) ) end

end

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	self:Jet_FireMultiBarrel()
	self:EmitSound( "npc/turret_floor/shoot"..math.random(2,3)..".wav", 510, math.random( 40, 70 ) )
	
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
		
		local p = { { Key = IN_FORWARD, Speed = 1 };
					{ Key = IN_BACK, Speed = -1 }; }
					
		for k,v in ipairs( p ) do
			
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
			
			end
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * -self.CrosshairOffset -- This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local r,pitch,vel
		self.offs = self:VecAngD( ma.y, ta.y )		

		if( self.offs < -160 || self.offs > 160 ) then r = 0 else r = ( self.offs / self.BankingFactor ) * -1 end
		

		pitch = pilotAng.p
		vel =  math.Clamp( self:GetVelocity():Length() / 13.5, 10, 118 )
		
		if( self:GetVelocity():Length() < 200 ) then	
			
			pilotAng.y = ma.y
		
		end
		
		-- Increase speed going down, decrease it going up
		if( ma.p < -25 || ma.p > 23 && !self.AfterBurner ) then self.Speed = self.Speed + ma.p/8.55 end
		
		if( self:GetVelocity():Length() < 700 ) then r = 0 vel = 100 end 
		local downvector = Vector( 0,0, -200 + ( self:GetVelocity():Length() / 5.5 ) )
		
		-- print( self:GetVelocity():Length() )
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + downvector
		pr.maxangular		= 140 - vel
		pr.maxangulardamp	= 240 - vel
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.95
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( pitch, pilotAng.y, pilotAng.r ) + Angle( 0, 0, r )
		
		phys:ComputeShadowControl( pr )
			
		self:WingTrails( ma.r, 20 )
	end		

--Propeller Script
	if( self.IsFlying ) then
	
		for i= 1, 4 do
		
			if( IsValid( self.Propeller[i] ) ) then
			
				self.Propeller[i]:GetPhysicsObject():AddAngleVelocity( Vector( 5+self.Speed/5, 0, 0 ) )
			
			end
			
		end	
		
	end
	

end

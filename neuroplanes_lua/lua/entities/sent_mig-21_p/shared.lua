ENT.Type 			= "vehicle"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Mig-21 Fishbed"
ENT.Author			= "Hoffa/StarChick"
ENT.Category 		= "NeuroTec Admin";
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.VehicleType 	= VEHICLE_PLANE
ENT.HasAfterburner	= true
--Server Side

-- Characteristics	
ENT.Model 			= "models/hawx/planes/mig-21 fishbed.mdl" -- Model of choice
ENT.NbSkins			= 1 									-- Number of model skins
ENT.MaxVelocity 	= 1.8 * 2125							-- use 1.8 * topspeed
ENT.MinVelocity 	= 0										
ENT.InitialHealth 	= 7000									
ENT.HealthVal 		= nil

--Performance
ENT.Manoeuvrability = 5
ENT.BankingFactor = 1.97

--Sounds
ENT.esound = {}
ENT.esound[1] = "military/bf2_f15_throttle_loop.wav"		--Engine sound
ENT.esound[2] = "military/bf2_f15_throttle_stop.wav"		--Engine sound ending
ENT.esound[3] = "military/bf2_f15_afterburner_loop.wav"		--Afterburner sound
ENT.esound[4] = "military/bf2_f15_afterburner_stop.wav"		--Afterburner sound ending

-- Equipment
ENT.SeatPos = Vector( -31, 0, 63 )						-- Cockpit seat position local to the plane.
ENT.SeatAngle = Vector( 5, 0, 0 )
ENT.MachineGunModel = "models/airboatgun.mdl"				-- Minigun model to use. Use models/airboatgun.mdl if you want muzzle flash.
ENT.MachineGunOffset = Vector( -38, -5, 40 )					-- Machinegun position local to the plane.
ENT.CrosshairOffset = 67									-- Height Adjustment for crosshair. This value should be the same as the Z coordinate in ENT.MachineGunOffset.

ENT.MachineGunMuzzle = "a10_muzzlesmoke"					-- Muzzle sprite or fx to use
ENT.MachineGunTracer = "AirboatGunHeavyTracer"				-- Tracer to use
ENT.MachineGunImpactFX = "HelicopterMegaBomb"

ENT.FlareCooldown = 15										-- Counter-measure cooldown in seconds when the magazine is empty
ENT.FlareCount = 20											-- Current flare loadout
ENT.MaxFlares = 20											-- Max capacity in each magazine

ENT.Destroyed = false										-- Determines if we're still in business.
ENT.DeathTimer = 0											-- Upon destruction this variable will increase each frame. Once the maximum value is reached the plane will be removed.
ENT.Burning = false											-- Emit smoke puffs?
ENT.Speed = 0												
ENT.Pitch = 0
ENT.Yaw = 0
ENT.Roll = 0

ENT.maxG = 0
ENT.Drift = 1

ENT.LastUseKeyDown = nil

		
		
-- Effects
ENT.HasPostCombustion = true
ENT.ReactorPos = { Vector( -345, -0, 58 ) }
ENT.FlamePos = Vector( -345, 0, 58 )
ENT.WingTrailPos = Vector( -259, 138, 57 ) --,Vector( -265, 317, 110 ) }
ENT.TrailPos = { Vector( -76, -335, 104 ), Vector( -265, 138, 57 ) }

--Lights
ENT.NavLightsToggle = true
ENT.NavLightsLast = CurTime()
ENT.NavLights = {}
ENT.NavLights.Lamps = {}
ENT.NavLights.Pos = { Vector( -259, -138, 57 ), Vector( 259.5, 138, 57 ) }
ENT.NavLights.TPos = { Vector( -155, 63, 62.3 ), Vector( -259, -63, 62.3 ) }

ENT.NavLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.NavLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.NavLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.NavLightProjectionTexture = ""

-- Armament
ENT.GunPos = Vector( -38, -5, 40 )	
ENT.MuzzleOffset = 260
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1
ENT.Armament = {

					{ 
						PrintName = "Aim-9 Sidewinder [1]"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -206, -85, 46), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 								// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 

					{ 
						PrintName = "Aim-9 Sidewinder [2]", 						// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -206, 85, 46), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,										// Secondary rocket. 
						Class = "sent_a2a_rocket"
					}; 

					{ 
						PrintName = "LAU-131A Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( -176, -69, 40 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Pod",
						Cooldown = 0.5,
						--isFirst	= true,
						Class = "sent_a2s_dumb",
						BurstSize = 2
					}; 

					{ 
						PrintName = "LAU-131A Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( -176, 69, 40 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Pod",
						Cooldown = 8,
						isFirst	= false,
						Class = "sent_a2s_dumb",
						BurstSize = 2
					}; 					

					{ 
						PrintName = "MK-82", 
						Mdl = "models/hawx/weapons/mk-82.mdl",	 
						Pos = Vector( -162, 0, 24 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 0,
						isFirst	= false,
						Class = "sent_mk82"
					}; 	
				}


	--Client side
ENT.CamDist = 620
ENT.CamUp = 160

-- Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil

ENT.Type 			= "vehicle"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Sukhoi Su-47 Berkut"
ENT.Author			= "StarChick"
ENT.Category 		= "NeuroTec Aviation v2";
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.VehicleType 	= VEHICLE_PLANE

--Server Side

-- Characteristics	
ENT.Model 			= "models/hawx/planes/su-47 berkut.mdl" -- Model of choice
ENT.NbSkins			= 7 									-- Number of model skins
ENT.MaxVelocity 	= 1.8 * 2710							-- use 1.8 * topspeed
ENT.MinVelocity 	= 0										
ENT.InitialHealth 	= 2500									-- Hit Points
ENT.HealthVal 		= nil

ENT.Manoeuvrability = 10									-- Self explanatory
ENT.BankingFactor = 1.97									

--Sounds
ENT.esound = {}
ENT.esound[1] = "military/bf2_f15_throttle_loop.wav"		--Engine sound
ENT.esound[2] = "military/bf2_f15_throttle_stop.wav"		--Engine sound ending
ENT.esound[3] = "military/bf2_f15_afterburner_loop.wav"		--Afterburner sound
ENT.esound[4] = "military/bf2_f15_afterburner_stop.wav"		--Afterburner sound ending

-- Equipment
ENT.SeatPos = Vector( 212, 0, 144-40 )						-- Cockpit seat position local to the plane.
ENT.MachineGunModel = "models/h500_gatling.mdl"				-- Minigun model to use. Use models/airboatgun.mdl if you want muzzle flash.
ENT.MachineGunOffset = Vector( 293, -13, 126 )				-- Machinegun position local to the plane.
ENT.CrosshairOffset = 126									-- Height Adjustment for crosshair. This value should be the same as the Z coordinate in ENT.MachineGunOffset.

ENT.MachineGunMuzzle = "a10_muzzlesmoke"					-- Muzzle sprite or fx to use
ENT.MachineGunTracer = "AirboatGunHeavyTracer"				-- Tracer to use
ENT.MachineGunImpactFX = "HelicopterMegaBomb"

ENT.FlareCooldown = 15										-- Counter-measure cooldown in seconds
ENT.FlareCount = 10											-- Current flare loadout
ENT.MaxFlares = 10											-- Max capacity in each magazine

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
ENT.ReactorPos = { Vector( -383, -30, 99 ), Vector( -383, 30, 99  )}
ENT.FlamePos = Vector( -409, 0, 74 )
ENT.WingTrailPos = Vector( -68, 317, 110 ) --,Vector( -68, 317, 110 ) }
ENT.TrailPos = { Vector( -68, -317, 110 ), Vector( -68, 317, 110 ) }


-- Armament
ENT.GunPos = Vector( 140, 44, 90 )
ENT.MuzzleOffset = 260
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1
ENT.Armament = {
					{ 
						PrintName = "Python-5"		,		 					-- print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  				-- model, used when creating the object
						Pos = Vector( -113, -8, 60), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									-- Ang, object angle
						Type = "Homing", 										-- Type, used when creating the object
						Cooldown = 1.5, 										-- Cooldown between Shots
						--isFirst	= true,											-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket",								-- Entity Class
					}; 

					{ 
						PrintName = "Python-5", 								-- print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  				-- model, used when creating the object
						Pos = Vector( -113, 8, 60), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									-- Ang, object angle
						Type = "Homing", 										-- Type, used when creating the object
						Cooldown = 1.5, 										-- Cooldown between weapons
						isFirst	= false,
						Class = "sent_a2a_rocket",
					};					
					
					{ 
						PrintName = "AGM-84", 									-- print name, used by the interface
						Mdl = "models/military2/missile/missile_harpoon.mdl",  	-- model, used when creating the object
						Pos = Vector( -60, 8, 73), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									-- Ang, object angle
						Col = Color( 0, 0, 0, 0), 									// Color
						Type = "Singlelock", 										// Type, used when creating the object
						Cooldown = 3, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_hellfire_missile",								// the object that will be created.
						Radius = 1024,
						Damage = 2500
					};
				}


	--Client side
ENT.CamDist = 900
ENT.CamUp = 250

-- Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil

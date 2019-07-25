ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "A-6 Intruder"
ENT.Author	= "StarChick"
ENT.Category 		= "NeuroTec Aviation v2";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

		//Server Side

-- Caracteristics	
ENT.Model = "models/hawx/planes/a-6 intruder.mdl"
ENT.NbSkins = 1
ENT.MaxVelocity = 3900
ENT.MinVelocity = 0
ENT.InitialHealth = 2500
ENT.HealthVal = nil
ENT.CopilotSeatPos = Vector( 85, 15, 80 )

ENT.Manoeuvrability = 8.8
ENT.BankingFactor = 1.97

--Sounds
ENT.esound = {}
ENT.esound[1] = "military/bf2_f15_throttle_loop.wav"	//Engine sound
ENT.esound[2] = "military/bf2_f15_throttle_stop.wav"	//Engine sound ending
ENT.esound[3] = "military/bf2_f15_afterburner_loop.wav"	//afterburner sound
ENT.esound[4] = "military/bf2_f15_afterburner_stop.wav"	//afterburner sound ending

-- Equipment
ENT.SeatPos = Vector( 85, -15, 80 )
ENT.MachineGunModel = "models/h500_gatling.mdl"
ENT.MachineGunOffset = Vector( 2, 35, 26 )
ENT.MachineGunMuzzle = "a10_muzzlesmoke"					-- Muzzle sprite or fx to use
ENT.MachineGunTracer = "AirboatGunHeavyTracer"				-- Tracer to use
ENT.MachineGunImpactFX = "HelicopterMegaBomb"
ENT.CrosshairOffset = 26

ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

ENT.Destroyed = false
ENT.DeathTimer = 0
ENT.Burning = false
ENT.Speed = 0
ENT.Pitch = 0
ENT.Yaw = 0
ENT.Roll = 0

ENT.maxG = 0
ENT.Drift = 1

ENT.LastUseKeyDown = nil

-- Effects
ENT.HasPostCombustion = true
ENT.ReactorPos = { Vector( -246, -24, 75 ), Vector( -246, 24, 75  )}
ENT.FlamePos = Vector( -409, 0, 74 )
ENT.WingTrailPos = Vector( -358, 161, 65 )
ENT.TrailPos = { Vector( -91, -256, 79 ), Vector( -91, 256, 79 ) }


-- Armament
ENT.GunPos = Vector( 140, 44, 90 )
ENT.MuzzleOffset = 220
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1
ENT.Armament = {

					{ 
						PrintName = "Aim-9 Sidewinder"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -55, -136, 68), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 8, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 

					{ 
						PrintName = "MK-82", 
						Mdl = "models/hawx/weapons/mk-82.mdl",	 
						Pos = Vector( -46, -91, 58 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 5,
						isFirst	= nil,
						Class = "sent_mk82"
					}; 
				}
				
ENT.CoArmament = {

{ 
						PrintName = "Aim-9 Sidewinder", 						// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -55, 136, 68), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 8, 											// Cooldown between weapons
						isFirst	= nil,										// Secondary rocket. 
						Class = "sent_a2a_rocket"
					}; 
					
						{ 
						PrintName = "MK-82", 
						Mdl = "models/hawx/weapons/mk-82.mdl",	 
						Pos = Vector( -46, 91, 58 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 5,
						isFirst	= nil,
						Class = "sent_mk82"
					}; 	
				}


		//client side
	ENT.CamDist = 900
	ENT.CamUp = 250

-- Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil

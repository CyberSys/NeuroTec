ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "AH-6 Little Bird \"Killer Egg\""
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.Model = "models/flyboi/LittleBird/littlebirda_Fb.mdl"
//Speed Limits
ENT.MaxVelocity = 850
ENT.MinVelocity = -800

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 3.8

ENT.InitialHealth = 2000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.Velpitch = 0

// Timers
ENT.RotorTimer = 500
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8
ENT.CrosshairOffset = -53
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.GotChopperGunner = false
-- // VTOL specific variable.
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true

ENT.HelicopterPilotSeatPos = Vector( 22, 18, 45 )
ENT.HelicopterPassengerSeatPos = Vector( 22, -18, 45 )

ENT.RotorPropellerPos = Vector(-10,0,100)
ENT.TailPropellerPos =  Vector(-217,9,73)
-- Side mounted, static miniguns
ENT.MinigunPos = { Vector( 10, 39, 30 ), Vector( 10, -39, 30 ) }

ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
ENT.RotorModel = "models/flyboi/LittleBird/littlebirdrotorm_Fb.mdl"
ENT.RotorModelTail = "models/fsx/helicopters/uh-1 iroquois_tailrotor.mdl"

ENT.CamDist = 370
ENT.CamUp = 130

ENT.CockpitCameraPos =  Vector( 33, 17, 78 ) 
ENT.GunCamPos = Vector( 165, 0, -59 )

ENT.ExhaustPosition = Vector( -89, 0, 51 )

ENT.MinZoom = 10
ENT.MaxZoom = 55

	
ENT.Armament = {
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 15, 53, 17), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 6, 											// Cooldown between weapons
					--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 6
				}; 
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 15, -53, 17), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 6, 											// Cooldown between weapons
					-- isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 6
				};					
				{ 
					PrintName = "FIM-92 Stinger"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/predator/predator_rocket.mdl",  		// model, used when creating the object
					Pos = Vector( -4, 55, 37), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 45), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 									// Color
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 8, 											// Cooldown between weapons
					-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				{ 
					PrintName = "AGM-144 Hellfire"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  		// model, used when creating the object
					Pos = Vector( -4, -58, 37), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 									// Color
					Type = "Singlelock", 										// Type, used when creating the object
					Cooldown = 8, 											// Cooldown between weapons
					-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_hellfire_missile",								// the object that will be created.
					Radius = 1024,
					Damage = 2500
				};
				

			}
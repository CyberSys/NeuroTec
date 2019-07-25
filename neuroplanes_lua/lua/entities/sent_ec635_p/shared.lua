ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Eurocopter EC635"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.Model = "models/ec635.mdl"
//Speed Limits
ENT.MaxVelocity = 990
ENT.MinVelocity = -800

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.0

ENT.InitialHealth = 4000
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
ENT.FlareCooldown = 30
ENT.FlareCount = 15
ENT.MaxFlares = 15
ENT.CrosshairOffset = -0
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.GotChopperGunner = false
-- // VTOL specific variable.
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true

ENT.HelicopterPilotSeatPos = Vector( 163, 18, -35 )
ENT.HelicopterPassengerSeatPos = Vector( 163, -18, -39 )
ENT.TopRotorVal = 1000
ENT.Mass = 99999999

ENT.RotorPropellerPos = Vector( 75, 0, 69 )
ENT.TailPropellerPos =  Vector( -195, -0, 11 )
-- Side mounted, static miniguns
ENT.MinigunPos = { Vector( 90, 77, -40 ), Vector( 90, -77, -40 ) }
ENT.ShowMiniguns = true

ENT.ExitPos = Vector( 167, 150, -60 )

ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
ENT.RotorModel = "models/ec635rotorm.mdl"
ENT.RotorModelTail = "models/ec635rotorb.mdl"

ENT.CamDist = 450
ENT.CamUp = 120

ENT.CockpitCameraPos =  Vector( 175, 15, 7 ) 
ENT.GunCamPos = Vector( 165, 0, -59 )
ENT.ExhaustPosition = Vector( 5, 27, 22 )

ENT.HideExtraSeats = true

ENT.ExtraSeats = {	
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,0,0 ),
						Pos =  Vector( 75, 67, -52 ),
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,180,0 ),
						Pos =  Vector( 75, -67, -52 ),
					};
	}

ENT.MinZoom = 10
ENT.MaxZoom = 55

	
ENT.Armament = {
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 77,70, -61), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 0.51, 											// Cooldown between weapons
					isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 1
				}; 
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 77, -70, -61), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 0.5, 											// Cooldown between weapons
					isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 1
				};					
				{ 
					PrintName = "FIM-92 Stinger"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/predator/predator_rocket.mdl",  		// model, used when creating the object
					Pos = Vector( 80, 74, -46 ), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 45), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 									// Color
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 8, 											// Cooldown between weapons
					-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				{ 
					PrintName = "FIM-92 Stinger"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/predator/predator_rocket.mdl",  		// model, used when creating the object
					Pos = Vector( 80, -74, -46 ), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 45), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 									// Color
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 8, 											// Cooldown between weapons
					-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				-- { 
					-- PrintName = "static"		,		 			// print name, used by the interface
					-- Mdl = "models/fsx/helicopters/uh-1 iroquois_extras.mdl",  		// model, used when creating the object
					-- Pos = Vector( 0,0,0 ), 							// Pos, Hard point location on the plane fuselage.
					-- Ang = Angle( 0, 0, 0), 									// Ang, object angle
					-- Col = Color( 255, 255, 255, 255), 									// Color
					-- Type = "Effect", 										// Type, used when creating the object

				-- };
				

			}
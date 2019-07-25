ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "CAIC WZ-10 aka AW129"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= false
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.Model = "models/bf2/helicopters/wz-10/wz-10.mdl"
//Speed Limits
ENT.MaxVelocity = 990
ENT.MinVelocity = -800

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.5

ENT.InitialHealth = 3000
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
ENT.GotChopperGunner = true
-- // VTOL specific variable.
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true

ENT.HelicopterPilotSeatPos = Vector( 57, 0, -20 )
ENT.HelicopterPassengerSeatPos = Vector( 163, 0, -39 )
ENT.TopRotorVal = 1000
ENT.Mass = 99999999

ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
ENT.RotorModel = "models/bf2/helicopters/wz-10/wz-10_rotor.mdl"
ENT.RotorPropellerPos = Vector( -7, 0, 88 )
ENT.RotorModelTail = "models/bf2/helicopters/wz-10/wz-10_tail.mdl"
ENT.TailPropellerPos =  Vector( -413, -24, 70 )
ENT.WingModel = "bf2/helicopters/wz-10/wz-10_wings.mdl"
ENT.WingPos = Vector(357,0,-19)

ENT.WheelPos = { Vector(51,-61,-61), Vector(51,61,-61 ) }
ENT.WheelModel = "models/bf2/helicopters/wz-10/wz-10_wheel.mdl"
ENT.OtherWheelPos = {Vector( -356, 0, -68 )}
ENT.OtherWheelModel = "models/bf2/helicopters/wz-10/wz-10_tailwheel.mdl"

-- Side mounted, static miniguns
-- ENT.MinigunPos = { Vector( 90, 77, -40 ), Vector( 90, -77, -40 ) }
ENT.MGunHasTurret = true
ENT.ShowMiniguns = false
ENT.MachineGunModel = "models/bf2/helicopters/wz-10/wz-10_cannon.mdl"
ENT.MachineGunOffset = Vector(223,0,-37)
ENT.ChopperTurretModel = "models/bf2/helicopters/wz-10/wz-10_turret.mdl"
ENT.ChopperTurretPos = Vector(223,0,-13)
ENT.ChopperTurretAng = Angle(0,180,0)
ENT.LinearMachineGun = false

ENT.ExitPos = Vector( 120, 100, -50 )

ENT.CamDist = 620
ENT.CamUp = 150

ENT.CockpitCameraPos =  Vector( 60, 0, 55 ) 
ENT.GunCamPos = Vector( 165, 0, -59 )
ENT.ExhaustPosition = Vector( 5, 27, 22 )

ENT.HideExtraSeats = true

ENT.ExtraSeats = {	
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,0,0 ),
						Pos =  Vector( 75, 0, -52 ),
					};
	}

ENT.MinZoom = 10
ENT.MaxZoom = 55

	
ENT.CannonPositions = {Vector(223,0,-37)}
ENT.CannonModels = {"models/bf2/helicopters/wz-10/wz-10_cannon.mdl"}
ENT.CannonAngles = {Angle( 0,0,0 )}
ENT.CannonAmmo = "sent_tank_shell"
ENT.CannonDelay = 1.0
ENT.CannonEnt = "sent_ratte_turret"

ENT.Armament = {
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector(19,56,-11), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 7, 											// Cooldown between weapons
					isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 5
				}; 
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector(19,-56,-11), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 7, 											// Cooldown between weapons
					isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 5
				};					
				{ 
					PrintName = "FIM-92 Stinger"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/predator/predator_rocket.mdl",  		// model, used when creating the object
					Pos = Vector( 47, 80, -21 ), 							// Pos, Hard point location on the plane fuselage.
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
					Pos = Vector( 47, -80, -21 ), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 45), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 									// Color
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 8, 											// Cooldown between weapons
					-- isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				{
					PrintName = "AGM-114 Hellfire"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  		// model, used when creating the object
					Pos = Vector( 20, 95, -8), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 								// Ang, object angle
					Type = "Singlelock", 										// Type, used when creating the object
					Cooldown = 5, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_hellfire_missile",
					Damage = 900,
					Radius = 1200
				}; 
				{
					PrintName = "AGM-114 Hellfire"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  		// model, used when creating the object
					Pos = Vector( 20, -95, -8), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 								// Ang, object angle
					Type = "Singlelock", 										// Type, used when creating the object
					Cooldown = 5, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_hellfire_missile",
					Damage = 900,
					Radius = 1200
				}; 
				{ 
					PrintName = "AGM-114 Cluster Hellfire"		,		 		// print name, used by the interface
					Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  				// model, used when creating the object
					Pos = Vector( 20, 95, -21), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 								// Ang, object angle
					Type = "Singlelock", 										// Type, used when creating the object
					Cooldown = 20, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					SubType = "Cluster",
					Class = "sent_hellfire_missile"								// the object that will be created.
				}; 
				{ 
					PrintName = "AGM-114 Cluster Hellfire"		,		 		// print name, used by the interface
					Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  				// model, used when creating the object
					Pos = Vector( 20, -95, -21), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 								// Ang, object angle
					Type = "Singlelock", 										// Type, used when creating the object
					Cooldown = 20, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					SubType = "Cluster",
					Class = "sent_hellfire_missile"								// the object that will be created.
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
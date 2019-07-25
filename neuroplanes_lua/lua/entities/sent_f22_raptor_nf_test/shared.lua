ENT.Type 						= "vehicle"
ENT.EntityType 					= "sent_f22_Raptor_NF_test"
ENT.Base 						= "base_anim"
ENT.PrintName					= "F-22 Raptor DEMO"
ENT.Author						= "Hoffa"
ENT.Category 					= "NeuroTec Aviation v3";
ENT.Spawnable					= true
ENT.AdminSpawnable 				= false
ENT.VehicleType 				= VEHICLE_PLANE

-- physics
ENT.RotationalDamping 	= 0.152-- 0.000000015--0.001
ENT.LinearDamping		= 0.1--0.000000015-- 0.001
ENT.NA_Yaw 				= 880
ENT.NA_PitchDown 		= 700
ENT.NA_PitchUp 			= 700 
ENT.NA_Roll 			= 7000
ENT.NA_YawRollMultiplierStraight = 5
ENT.NA_YawRollMultiplierFast = 3
ENT.NA_mass = 1000


ENT.NA_LerpYaw = 0.5 -- 0.0 to 1.0
ENT.NA_LerpRoll = 0.198 -- 0.0 to 1.0
ENT.NA_LerpPitch = 0.352 -- 0.0 to 1.0

ENT.NA_GForceCeiling = 100
ENT.NA_maxGForce = 15
ENT.NA_minGForce = -50

ENT.NA_PhysicsUpperSpeedLimit = 3000

ENT.NA_SteerabilityMultiplier = 1.0

ENT.Manoeuvrability = 10
ENT.BankingFactor = 1.97

ENT.Pitch = 0
ENT.Yaw = 0
ENT.Roll = 0

ENT.maxG = 0
ENT.Drift = 1

-- Special features
ENT.HasAirbrakes = true
ENT.HasTVC = true //= Thrust Vectoring Control

-- Effects
ENT.HasPostCombustion = true
ENT.ReactorPos = { Vector( -205, 56, 121 ), Vector( -205, -56, 121 ) }
ENT.FlamePos = Vector( -205, 56, 121 )

ENT.WingTrailPos =  Vector( -205, 56, 121 )

--Speed Limits
ENT.MaxVelocity = 16500
ENT.MinVelocity = 0

ENT.InitialHealth = 1500
ENT.HealthVal = 0

ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

-- Equipment
ENT.Model = "models/hawx/planes/fa-22 raptor.mdl"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 270, -32, 80 )
ENT.PilotSeatPos = Vector( 230,0,75.5 )

-- Minigun Cooldown
ENT.PrimaryCooldown = 0.35
ENT.PrimaryGunBarrelLength = 60

-- This defines the wing tips are breaking the air creating condensation trails.
ENT.TrailPos = { Vector( -150, 268, 69 ), Vector( -150, -268, 69 ) }

-- ENgine Exhaust pos
ENT.NA_ExhaustPorts = { Vector( -244, 25, 78 ), Vector( -244, -25, 78 ) }
ENT.NA_ExhaustNormals = { Vector( -150, 25, 78 ), Vector( -150,-25,78 ) }

ENT.NA_StartupSound = ""
ENT.NA_StartupDelay = 0//3.0

-- Give CoPilot advanced Heads-Up Display. Disable this for civilian planes.
ENT.NA_Copilot_HUD = true
-- Use 3d model for cockpit.
ENT.Cockpit3DModel = "models/hawx/planes/cockpits/fa-22 raptor_cockpit.mdl"
-- camera stuff
ENT.CamPosFirst = Vector( 260,0,122 )
ENT.CamPos3rd = Vector( 700, 0, 200 )


-- Primary Weapon Stuff
ENT.NA_TracerName = "AirboatGunTracer" 
ENT.NA_PrimaryAttackSound = "50cal.mp3"
ENT.NA_PrimaryAttackEffect = "MG_muzzleflash"
ENT.NA_DefaultMaingunImpactFX = "MG_muzzleflash"


ENT.NA_FXSound = { 
	"ambient/levels/canals/dam_water_loop2.wav", 
	"lockon/sonicboom.mp3", 
	"lockon/supersonic.wav" 
	}
ENT.NA_engineSounds = {	
	"physics/metal/canister_scrape_smooth_loop1.wav",
	"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav",
	"ambient/levels/canals/dam_water_loop2.wav"
}
	
ENT.Armament = {

					{ 
						PrintName = "Fuel Air Bomb", 
						Mdl = "models/military2/bomb/bomb_gbu10.mdl",
						Pos = Vector( 0, 0, 60 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						Class = "sent_FAB",
						Hardpoint = 4,
					};
					{ 
						PrintName = "AIM-9 Sidewinder"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( 0, -49, 60 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 3, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket",								// the object that will be created.
						Damage = 400,
						Radius = 800,
						Hardpoint = 1,
					}; 
					{ 
						PrintName = "AIM-9 Sidewinder"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( 0, 49, 60 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 3, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket",								// the object that will be created.
						Hardpoint = 1,
					}; 

					{ 
						PrintName = "GBU-12 Paveway II", 
						Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
						Pos = Vector( 0, -26, 54 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_jdam_medium",
						Hardpoint = 2,
					}; 
					{ 
						PrintName = "GBU-12 Paveway II", 
						Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
						Pos = Vector( 0, 26, 54 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_jdam_medium",
						Hardpoint = 2,
					}; 

					{ 
						PrintName = "JDAM Bomb", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( 0, -10, 50 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						--isFirst	= true,
						Class = "sent_jdam_medium",
						Hardpoint = 3,
					}; 
					{ 
						PrintName = "JDAM Bomb", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( 0, 10, 50 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						isFirst	= false,
						Class = "sent_jdam_medium",
						Hardpoint = 3,
					}; 
				}
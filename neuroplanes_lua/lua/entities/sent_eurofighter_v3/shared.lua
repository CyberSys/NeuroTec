ENT.Type 						= "vehicle"
ENT.EntityType 					= "sent_eurofighter_v3"
ENT.Base 						= "base_anim"
ENT.PrintName					= "Eurofighter Typhoon"
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

ENT.NA_LerpYaw = 0.45 -- 0.0 to 1.0
ENT.NA_LerpRoll = 0.0875 -- 0.0 to 1.0
ENT.NA_LerpPitch = 0.45 -- 0.0 to 1.0

ENT.NA_GForceCeiling = 100
ENT.NA_maxGForce = 15
ENT.NA_minGForce = -50

ENT.NA_PhysicsUpperSpeedLimit = 3000

ENT.NA_SteerabilityMultiplier = 1.0

ENT.Manoeuvrability = 1
ENT.BankingFactor = 1.97

ENT.Pitch = 0
ENT.Yaw = 0
ENT.Roll = 0

ENT.maxG = 0
ENT.Drift = 1

-- Effects
ENT.HasPostCombustion = true
ENT.ReactorPos = { Vector( -205, 56, 121 ), Vector( -205, -56, 121 ) }
ENT.FlamePos = Vector( -205, 56, 121 )

ENT.WingTrailPos = Vector( -104, 212, 66 )

--Speed Limits
ENT.MaxVelocity = 20500
ENT.MinVelocity = 0

ENT.InitialHealth = 2000
ENT.HealthVal = 0

ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

-- Equipment
ENT.Model = "models/hawx/planes/eurofighter 2000 typhoon.mdl"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 330, 0, 78 )
ENT.PilotSeatPos = Vector( 205, 0, 115-40 )

-- Minigun Cooldown
ENT.PrimaryCooldown = 0.1
ENT.PrimaryGunBarrelLength = 98

-- This defines the wing tips are breaking the air creating condensation trails.
ENT.TrailPos = { Vector( -104, -212, 66 ), Vector( -104, 212, 66 ) }

-- ENgine Exhaust pos
ENT.NA_ExhaustPorts = { Vector( -246, -24, 75 ), Vector( -246, 24, 75  )}
ENT.NA_ExhaustNormals = { Vector( -245, -24, 75 ), Vector( -245, 24, 75  )}

ENT.NA_StartupSound = ""
ENT.NA_StartupDelay = 0.5

-- Give CoPilot advanced Heads-Up Display. Disable this for civilian planes.
ENT.NA_Copilot_HUD = true
-- Use 3d model for cockpit.
ENT.Cockpit3DModel = "models/hawx/planes/cockpits/a-10 thunderbolt ii_cockpit.mdl"
-- camera stuff
ENT.CamPosFirst = Vector( 155,0,138 )
ENT.CamPos3rd = Vector( 700, 0, 100 )


-- Primary Weapon Stuff
ENT.NA_TracerName = "AirboatGunTracer" 
ENT.NA_PrimaryAttackSound = "a10fart_2.mp3"
ENT.NA_PrimaryAttackEffect = "AA_muzzleflash"
ENT.NA_DefaultMaingunImpactFX = "30cal_impact"


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
						PrintName = "AIM-132 ASRAAM"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-132 asraam.mdl",  		// model, used when creating the object
						Pos = Vector( -77, -174, 45 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket",
						Hardpoint = 1

					}; 
					{ 
						PrintName = "AIM-132 ASRAAM"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-132 asraam.mdl",  		// model, used when creating the object
						Pos = Vector( -77, 174, 45 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket",
						Hardpoint = 1

					}; 
					
					{ 
						PrintName = "AGM-84 Harpoon", 
						Mdl = "models/hawx/weapons/agm-84 harpoon.mdl",	 
						Pos = Vector( -19, -106, 45 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 10,
						isFirst	= nil,
						Class = "sent_a2a_rocket",
						Hardpoint = 1
					}; 					
					{ 
						PrintName = "AGM-84 Harpoon", 
						Mdl = "models/hawx/weapons/agm-84 harpoon.mdl",	 
						Pos = Vector( -19, 106, 45 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 10,
						isFirst	= nil,
						Class = "sent_a2a_rocket",
						Hardpoint = 1
					}; 
					
					
					{ 
						PrintName = "AIM-07 Sparrow", 
						Mdl = "models/hawx/weapons/aim-07 sparrow.mdl",	 
						Pos = Vector( 21, -68, 45 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 10,
						isFirst	= nil,
						Class = "sent_a2a_rocket",
						Hardpoint = 1
					};				
					
					{ 
						PrintName = "AIM-07 Sparrow", 
						Mdl = "models/hawx/weapons/aim-07 sparrow.mdl",	 
						Pos = Vector( 21, 68, 45 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 10,
						isFirst	= nil,
						Class = "sent_a2a_rocket",
						Hardpoint = 1
					}; 
					
					
					/* JDAM - Left Wing */
					{ 
						PrintName = "Fuel Air Bomb", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( -50, -140, 45 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						isFirst	= nil,
						Class = "sent_FAB",
						Hardpoint = 1
					}; 					
					{ 
						PrintName = "Fuel Air Bomb", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( -50, 140, 45 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						isFirst	= nil,
						Class = "sent_FAB",
						Hardpoint = 1
					}; 
					{
						PrintName = "ALQ-184 ECM",
						Mdl = "models/hawx/weapons/an alq 184.mdl",
						Pos = Vector( -185, 0, 95 ),
						Ang = Angle( 0, 0, 0 ),
						Type = "Flarepod",
						Cooldown = 0,
						isFirst = false,
						Class = "",
						Hardpoint = 0
					};
				}
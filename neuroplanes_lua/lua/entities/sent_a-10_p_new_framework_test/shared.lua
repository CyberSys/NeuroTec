ENT.Type 						= "vehicle"
ENT.EntityType 					= "sent_a-10_p_new_framework_test"
ENT.Base 						= "base_anim"
ENT.PrintName					= "A-10 Thunderbolt DEMO"
ENT.Author						= "Hoffa"
ENT.Category 					= "NeuroTec Aviation v3";
ENT.Spawnable					= true
ENT.AdminSpawnable 				= false
ENT.VehicleType 				= VEHICLE_PLANE

-- physics
ENT.RotationalDamping 	= 0.152-- 0.000000015--0.001
ENT.LinearDamping		= 0.1--0.000000015-- 0.001
ENT.NA_Yaw 				= 800
ENT.NA_PitchDown 		= 650
ENT.NA_PitchUp 			= 600 
ENT.NA_Roll 			= 8000
ENT.NA_YawRollMultiplierStraight = 5
ENT.NA_YawRollMultiplierFast = 3
ENT.NA_mass = 1000

ENT.NA_LerpYaw = 0.45 -- 0.0 to 1.0
ENT.NA_LerpRoll = 0.0875 -- 0.0 to 1.0
ENT.NA_LerpPitch = 0.45 -- 0.0 to 1.0

ENT.NA_GForceCeiling = 100
ENT.NA_maxGForce = 15
ENT.NA_minGForce = -50

ENT.NA_PhysicsUpperSpeedLimit = 2200

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

ENT.WingTrailPos =  Vector( -205, 56, 121 )

--Speed Limits
ENT.MaxVelocity = 16500
ENT.MinVelocity = 0

ENT.InitialHealth = 2000
ENT.HealthVal = 0

ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

-- Equipment
ENT.Model = "models/hawx/air/a-10 thunderbolt ii.mdl"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 260, 0, 67 )
ENT.PilotSeatPos = Vector( 157,0,95.5 )

-- Minigun Cooldown
ENT.PrimaryCooldown = 0.1
ENT.PrimaryGunBarrelLength = 98

-- This defines the wing tips are breaking the air creating condensation trails.
ENT.TrailPos = { Vector( -76, -335, 104 ), Vector( -75, 335, 104 ) }

-- ENgine Exhaust pos
ENT.NA_ExhaustPorts = { Vector( -205, 56, 123 ), Vector( -205,-56,123 ) }
ENT.NA_ExhaustNormals = { Vector( -150, 56, 123 ), Vector( -150,-56,123 ) }

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
					PrintName = "Aim-9 Sidewinder [R]"		,		 			-- print name, used by the interface
					Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		-- model, used when creating the object
					Pos = Vector( -13, -229, 77), 							-- Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 45), 									-- Ang, object angle
					Type = "Homing", 										-- Type, used when creating the object
					Cooldown = 15, 											-- Cooldown between weapons
					-- --isFirst	= true,											-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket",								-- the object that will be created.
					Hardpoint = 1
				}; 

				{ 
					PrintName = "Aim-9 Sidewinder [L]", 						-- print name, used by the interface
					Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		-- model, used when creating the object
					Pos = Vector( -13, 229, 77), 							-- Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 45), 									-- Ang, object angle
					Type = "Homing", 										-- Type, used when creating the object
					Cooldown = 15, 											-- Cooldown between weapons
					-- isFirst	= false,										-- Secondary rocket. 
					Class = "sent_a2a_rocket",
					Hardpoint = 12
				}; 

				{ 
					PrintName = "Fuel Air Bomb", 
					Mdl = "models/military2/bomb/bomb_gbu10.mdl",
					Pos = Vector( -14, -187, 67 ), 
					Ang = Angle( 0, 0, 45), 
					Type = "Bomb",
					Cooldown = 15,
					Class = "sent_FAB",
					Hardpoint = 2
				};
				
				{ 
					PrintName = "GBU-10", 
					Mdl = "models/military2/bomb/bomb_gbu10.mdl",
					Pos = Vector( -14, 187, 67 ), 
					Ang = Angle( 0, 0, 45), 
					Type = "Bomb",
					Cooldown = 15,
					-- --isFirst	= true,
					Class = "sent_jdam_medium",
					Damage = 2250, -- Impact damage, Optional for Laser Guided
					Radius = 1024, -- Blast Radius
					Hardpoint = 12-1
				}; 

				{ 
					PrintName = "LAU-131A Pod [R]", 
					Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
					Pos = Vector( -13, -139, 62 ), 
					Ang = Angle( 0, 0, 0), 
					Type = "Pod",
					Cooldown = 10,
					-- --isFirst	= true,
					Class = "sent_a2s_dumb",
					Hardpoint = 3
				}; 

				{ 
					PrintName = "LAU-131A Pod [L]", 
					Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
					Pos = Vector( -13, 139, 62 ), 
					Ang = Angle( 0, 0, 0), 
					Type = "Pod",
					Cooldown = 10,
					-- isFirst	= false,
					Class = "sent_a2s_dumb",
					Hardpoint = 12-3
				}; 					

				{ 
					PrintName = "CBU-100 Clusterbomb [L]", 
					Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
					Pos = Vector( -10, -63, 57 ), 
					Ang = Angle( 0, 0, 45), 
					Type = "Bomb",
					Cooldown = 10,
					-- --isFirst	= true,
					Class = "sent_mk82",
					Hardpoint = 4
				}; 
				
				{ 
					PrintName = "CBU-100 Clusterbomb [R]", 
					Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
					Pos = Vector( -10, 63, 57 ), 
					Ang = Angle( 0, 0, 45), 
					Type = "Bomb",
					Cooldown = 10,
					-- isFirst	= false,
					Class = "sent_mk82",
					Hardpoint = 12-4
				}; 		

				{ 
					PrintName = "GBU-12 Paveway II", 
					Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
					Pos = Vector( 0, -17, 57 ), 
					Ang = Angle( 0, 0, 0), 
					Type = "Bomb",
					Cooldown = 10,
					-- --isFirst	= true,
					Class = "sent_mk82",
					Hardpoint = 5
				}; 
				
				{ 
					PrintName = "GBU-12 Paveway II", 
					Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
					Pos = Vector( 0, 17, 57 ), 
					Ang = Angle( 0, 0, 0), 
					Type = "Bomb",
					Cooldown = 10,
					-- isFirst	= false,
					Class = "sent_mk82",
					Hardpoint = 12-5
				}; 	

				{ 
					PrintName = "Sniper XR-ATP", 
					Mdl = "models/hawx/weapons/sniper xr-atp.mdl",	 
					Pos = Vector( -18, 0, 57 ), 
					Ang = Angle( 0, 0, 0), 
					Type = "Effect",
					Cooldown = 0,
					-- isFirst	= nil,
					Class = "",
					Hardpoint = 0
				}; 
				{
					PrintName = "ALQ-131 ECM",
					Mdl = "models/hawx/weapons/alq 131 ecm.mdl",
					Pos = Vector( -145, 0, 129 ),
					Ang = Angle( 0, 0, 0 ),
					Type = "Flarepod",
					Cooldown = 0,
					-- isFirst = false,
					Class = "",
					Hardpoint = 0
				};
			}
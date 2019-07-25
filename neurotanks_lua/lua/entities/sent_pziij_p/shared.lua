ENT.FolderName = "sent_pziij_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "PzKpfw II Ausf J"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: prof.heavy"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier III";
ENT.Description = " WW2 Premium Light Tank LEVEL 3"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
-- ENT.DebugWheels = true
ENT.CrewPositions = { Vector( 30, 15, 52 ),Vector( -19, -7, 54 )}
ENT.TankTrackZ = 11
ENT.TankTrackY = -55
ENT.TankTrackX = -25
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 700
ENT.TankWheelForceValREV = 700


					ENT.TrackPositions = {Vector( 3,3,4 ),Vector( 3,3,4 )}
ENT.TrackModels = { 
						"models/wot/germany/pziij/pziijtracks_l.mdl",
						"models/wot/germany/pziij/pziijtracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/german/tracks/hummel_track", 
							"models/wot/german/tracks/hummel_track_forward", 
							"models/wot/german/tracks/hummel_track_reverse"	}

							-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -10, -9, 0 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"


ENT.SkinCount = 1

ENT.BurstFire = true
ENT.BurstSize = 5

ENT.CamDist = 250
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 20, 10, 15 )
ENT.SeatPos = Vector( 0, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.305
ENT.PrimaryEffect = "ChopperMuzzleFlash"
	
ENT.ExhaustPosition = Vector( -86, 27, 48 )
ENT.BarrelMuzzleReferencePos = Vector( 55, 0, 6.6 )

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 59, 35, 53.5 ), Vector( 59, -35, 53.5 ) }
ENT.HeadLights.TPos = { Vector( -74, 33, 41 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

-- ENT.EngineSounds = { "vehicles/crane/crane_idle_loop3.wav", "vehicles/crane/crane_idle_loop3.wav" }
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.Model = "models/wot/germany/pziij/pziijbody.mdl"
ENT.TowerModel = "models/wot/germany/pziij/pziijturret.mdl"
ENT.TowerPos  = Vector( -2, 0, 58.300 )
ENT.BarrelModel = "models/wot/germany/pziij/pziijgun.mdl"
ENT.BarrelPos = Vector( 25.500, 0.500, 66.500 )
ENT.BarrelLength = 120

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, 0, 59 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

// Speed Limits
ENT.MaxVelocity = 30
ENT.MinVelocity = -15
ENT.Acceleration = 32

ENT.InitialHealth = 2700
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 250
ENT.MinDamage = 120
ENT.BlastRadius = 128

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


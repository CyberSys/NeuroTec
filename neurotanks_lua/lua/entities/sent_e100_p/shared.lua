ENT.FolderName = "sent_e100_p"
 
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Panzerkampfwagen E-100"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: beat the zombie\nModel Adaption: Jake"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier X";
ENT.Description = "WW2 Super Heavy Tank LEVEL 4"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.TrackPos = -48.5
ENT.SkinCount = 1

ENT.CrewPositions = {
					Vector( 12, -12, 34 ),
					Vector( 122, -29, 27 ),
					Vector( 123, 24, 28 ),
					Vector( -40, -9, 26 )
					}


					
ENT.TrackPositions = {Vector( -23,-17,5 ),Vector( -23,97,5 )}
ENT.TrackModels = { 
						"models/beat the zombie/wot/e-100/e100tracks_l.mdl",
						"models/beat the zombie/wot/e-100/e100tracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/german/tracks/maus_track", 
							"models/beat the zombie/wot/german/tracks/maus_track_forward", 
							"models/beat the zombie/wot/german/tracks/maus_track_reverse"	}
					
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( 15+30, -14.3, -4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"

ENT.StartAngleVelocity = 5.5
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce =  15
-- Slow beast.
ENT.MouseScale3rdPerson = 0.035
ENT.MouseScale1stPerson = 0.035
ENT.TurnMultiplier = 0.95
ENT.TurnMultiplierMoving = 2.95

-- This tank is VERY armored.
ENT.ArmorThicknessFront = 0.55
ENT.ArmorThicknessSide = 0.37
ENT.ArmorThicknessRear = 0.65


-- ENT.DebugWheels = true

ENT.TankTrackZ = -18
-- ENT.TankTrackY = 70
ENT.TankNumWheels = 16

ENT.TankWheelTurnMultiplier = 0.01
ENT.TankWheelForceValFWD = 550
ENT.TankWheelForceValREV = 450


ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 8, -9, 22 )
ENT.SeatPos = Vector( 15+92, 20, -10 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.HasCVol = true
ENT.CVol = 1.0
ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.ShootSound = Sound("bf2/tanks/d30_artillery_fire.mp3")
ENT.ReloadSound = Sound("vehicles/tank_readyfire1.wav")
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 4.45
ENT.PrimaryEffect = "ChopperMuzzleFlash"
ENT.StaticGunCooldown = 0
// Weapons
ENT.MaxDamage = 1900
ENT.MinDamage = 1100
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 9, 0, 59 ), Vector( 52, -31, 45 ), Vector( 52, 31, 45 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/beat the zombie/wot/e-100/e-100_body.mdl"
ENT.TowerModel = "models/beat the zombie/wot/e-100/e-100_tower.mdl"
ENT.TowerPos  = Vector( 15+10, 0, 65 )
ENT.BarrelModel = "models/beat the zombie/wot/e-100/e-100_gun.mdl"
ENT.BarrelPos = Vector( 15+63, 0, 65 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, 0, 59 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

// Speed Limits
ENT.MaxVelocity = 30
ENT.MinVelocity = -10
ENT.Acceleration = 0

ENT.InitialHealth = 8000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0


// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


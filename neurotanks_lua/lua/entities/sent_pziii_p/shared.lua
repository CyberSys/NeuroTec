ENT.FolderName = "sent_pziii_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "PzKpfw III"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier IV"
ENT.Description = "WW2 Medium Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
-- ENT.DebugWheels = true

ENT.CrewPositions = {
Vector( 57, -10, 35 ),
Vector( 53, 20, 35 ),
Vector( -10, 1, 53 ),
Vector( -4, 21, 44 )
}

ENT.TankTrackZ = 15
ENT.TankTrackY = 30
ENT.TankTrackX = -45
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0
ENT.RecoilForce = 9999999/2
ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 4,-4,4.500 ),Vector( 4,-4,4.500 )}
ENT.TrackModels = { 
						"models/wot/germany/pziii/pziiitracks_l.mdl",
						"models/wot/germany/pziii/pziiitracks_r.mdl"  
						}

						
						ENT.TrackAnimationOrder = { "models/wot/german/tracks/stug_iii_track", 
							"models/wot/german/tracks/stug_iii_track_forward", 
							"models/wot/german/tracks/stug_iii_track_reverse"	}
ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 10, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 4
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2000
ENT.MinDamage = 1500
ENT.BlastRadius = 612


ENT.Model = "models/wot/germany/pziii/pziiibody.mdl"
ENT.TowerModel = "models/wot/germany/pziii/pziiiturret.mdl"
ENT.TowerPos  = Vector( 5, -5, 58.900 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/wot/germany/pziii/pziiigun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 33.500, -5, 71.40)
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -15
ENT.Acceleration = 5

ENT.InitialHealth = 3500
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


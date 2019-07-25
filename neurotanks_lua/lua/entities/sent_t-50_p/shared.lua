ENT.FolderName = "sent_t-50_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "T-50"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Prof.heavy"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier IV";
ENT.Description = "WW2 Light Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -4.95
ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 52, -14, 35 ),
Vector( 30, 20, 36 ),
Vector( -16, -2, 39 ),
Vector( -60, 2, 33 )
}
ENT.TankTrackZ = 21
ENT.TankTrackY = 30
ENT.TankTrackX = -33
ENT.TankNumWheels = 10
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 15,10,5.100 ),Vector( 15,10,5.100 )}
ENT.TrackModels = { 
						"models/wot/russia/t50/t50tracks_l.mdl",
						"models/wot/russia/t50/t50tracks_r.mdl"  
						}
						

ENT.TrackAnimationOrder = { "models/wot/russians/t-50/t-50_track", 
							"models/wot/russians/t-50/t-50_track_forward", 
							"models/wot/russians/t-50/t-50_track_reverse"	}

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 5, 7 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 20 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 21, 18, 6 )

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
ENT.MaxDamage = 1600
ENT.MinDamage = 1050
ENT.BlastRadius = 612


ENT.Model = "models/wot/russia/t50/t50body.mdl"
ENT.TowerModel = "models/wot/russia/t50/t50turret.mdl"
ENT.TowerPos  = Vector( 23, 5, 55.100 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/wot/russia/t50/t50gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 47.500, 1.300, 61 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 52
ENT.MinVelocity = -20
ENT.Acceleration = 44

ENT.InitialHealth = 2000
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


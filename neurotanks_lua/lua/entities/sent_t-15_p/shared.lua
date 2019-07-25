ENT.FolderName = "sent_t-15_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "Pz.Kpfw. T 15"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier III";
ENT.Description = "WW2 Premium Light Tank LEVEL 5"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -7.95
-- ENT.DebugWheels = true

ENT.TankTrackZ = -20
ENT.TankTrackY = 33
ENT.TankTrackX = -50
ENT.TankNumWheels = 10
ENT.TurnMultiplier = 2.0
ENT.CrewPositions = {
Vector( 23, -12, 6 ),
Vector( 25, 13, 6 ),
Vector( 2, 10, 16 )
}
ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340


-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -10, -12, 1 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"


ENT.TrackPositions = {Vector( -14.900,0.600,4.100 ),Vector( -14.900,-0.900,4.100 )}
ENT.TrackModels = { 
						"models/professorheavy/t-15/t15tracks_l.mdl",
						"models/professorheavy/t-15/t15tracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/germany/sdkfz140/pz38_tracks", 
							"models/wot/germany/sdkfz140/pz38_tracks_forward", 
							"models/wot/germany/sdkfz140/pz38_tracks_reverse" }
ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, -5, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, -8 )
ENT.SeatAngle = Vector( -18, 0, 0 )
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
ENT.MaxDamage = 1600
ENT.MinDamage = 1050
ENT.BlastRadius = 612


ENT.Model = "models/professorheavy/t-15/t15body.mdl"
ENT.TowerModel = "models/professorheavy/t-15/t15turret.mdl"
ENT.TowerPos  = Vector( 4, 2, 15 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/t-15/t15gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 19, 2, 24)
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, -1.25, 25 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -15
ENT.Acceleration = 5

ENT.InitialHealth = 4000
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


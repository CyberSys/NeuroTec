ENT.FolderName = "sent_t-25_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Pz.Kpfw. T 25"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier V";
ENT.Description = "WW2 Premium Medium Tank"
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
ENT.TrackPos = -6.95
-- ENT.DebugWheels = true

ENT.TankTrackZ = -18
ENT.TankTrackY = 40
ENT.TankTrackX = -35
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0
ENT.CrewPositions = {
Vector( 61, 16, 18 ),
Vector( 68, -20, 16 ),
Vector( -22, -28, 21 ),
Vector( -10, 32, 21 )
}
ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340


-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -10, -22, 1 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"


ENT.TrackPositions = {Vector( 11,0.600,3.900 ),Vector( 11,-0.900,3.900 )}
ENT.TrackModels = { 
						"models/professorheavy/t-25/t25tracks_l.mdl",
						"models/professorheavy/t-25/t25tracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/germany/sdkfz140/pz38_tracks", 
							"models/wot/germany/sdkfz140/pz38_tracks_forward", 
							"models/wot/germany/sdkfz140/pz38_tracks_reverse" }
ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, -5, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 5, 0, 12 )
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
ENT.MaxDamage = 1600
ENT.MinDamage = 1050
ENT.BlastRadius = 612


ENT.Model = "models/professorheavy/t-25/t25body.mdl"
ENT.TowerModel = "models/professorheavy/t-25/t25turret.mdl"
ENT.TowerPos  = Vector( 32, 0, 27 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/t-25/t25gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 58, 0, 38)
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( 0, -20, 26 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 60
ENT.MinVelocity = -15 //not specified in WoT wiki
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


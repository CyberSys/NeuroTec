ENT.FolderName = "sent_panther_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Pz.Kpfw.V Panther"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Beat the zombie"
ENT.Category 		= "NeuroTec Tanks - Tier VII";
ENT.Description = "Medium Tank"
ENT.Spawnable	= false
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
ENT.TankTrackZ = 14
ENT.TankTrackY = 50
ENT.TankTrackX = -25
ENT.TankNumWheels = 14
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 9,0,5 ),Vector( 9,-100,5 )}
ENT.TrackModels = { 
						"models/professorheavy/panther/pzvtracks_l.mdl",
						"models/professorheavy/panther/pzvtracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/german/tracks/panther_track", 
							"models/wot/german/tracks/panther_track_forward", 
							"models/wot/german/tracks/panther_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -10, -17, 0 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
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


ENT.Model = "models/professorheavy/panther/pzvbody.mdl"
ENT.TowerModel = "models/professorheavy/panther/pzvturret.mdl"
ENT.TowerPos  = Vector( -20, 0, 71.800 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/panther/pzvgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 10, -1, 83.600 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 18
ENT.MinVelocity = -15
ENT.Acceleration = 5

ENT.RecoilForce = 999999/2

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


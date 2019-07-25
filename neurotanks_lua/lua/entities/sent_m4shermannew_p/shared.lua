ENT.FolderName = "sent_m4shermannew_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "M4 Sherman"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier V";
ENT.Description = "WW2 Medium Tank LEVEL 2"
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
ENT.TrackPos = -6.95
-- ENT.DebugWheels = true

ENT.TankTrackZ = 16
ENT.TankTrackY = 40
ENT.TankTrackX = -40
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 12,-1,4 ),Vector( 12,1,4 )}
ENT.TrackModels = { 
						"models/professorheavy/m4 sherman/m4tracks_l.mdl",
						"models/professorheavy/m4 sherman/m4tracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/american/tracks/m2_med_track", 
							"models/wot/american/tracks/m2_med_track_forward", 
							"models/wot/american/tracks/m2_med_track_reverse"	}

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 10, 20 )
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


ENT.Model = "models/professorheavy/m4 sherman/m4body.mdl"
ENT.TowerModel = "models/professorheavy/m4 sherman/m4turret.mdl"
ENT.TowerPos  = Vector(5, 0, 68 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/m4 sherman/m4gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 29, 1, 76 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 48
ENT.MinVelocity = -18
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

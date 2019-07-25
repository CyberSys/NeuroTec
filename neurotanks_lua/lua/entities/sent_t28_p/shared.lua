ENT.FolderName = "sent_t28_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "T-28"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier IV";
ENT.Description = "WW2 Medium Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasBarrelMGun = true
-- ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
-- ENT.HasCMGun = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95

ENT.CrewPositions = {
Vector( 80, 1, 64 ),
Vector( 106, 24, 45 ),
Vector( 103, -24, 46 ),
Vector( -0, -3, 61 )
}
-- ENT.DebugWheels = true

ENT.TankTrackZ = 14
ENT.TankTrackY = 44
ENT.TankTrackX = -25
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 1
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340
-- ENT.BarrelMGunPos = Vector( -0, -17, 79 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")
-- ENT.HasStaticSecondaryGuns = true
-- ENT.StaticGunPositions = { Vector( -39, -43.5, 20.4 )}
-- ENT.StaticGunAngles = { Angle( 0, 180, 0 ) }
-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
-- ENT.StaticGunCooldown = 0.115

ENT.MicroTurretPositions = {Vector( 71, -27, 52 ), Vector( 71, 27, 52 ) }
ENT.MicroTurretModels = { "models/aftokinito/wot/russian/t28_turret_s.mdl", "models/aftokinito/wot/russian/t28_turret_s.mdl"}
ENT.MicroTurretAngles = { Angle( 0,-45,0 ), Angle( 0,45,0 ) }
ENT.MicroTurretAmmo = "sent_autocannon_shell"
ENT.MicroTurretDelay = 0.35
ENT.MicroTurretEnt = "sent_t28_miniturret_p"

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/russian/t28_tracks_l.mdl","models/aftokinito/wot/russian/t28_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/russian/t28/t-28_track", 
							"models/aftokinito/wot/russian/t28/t-28_track_forward", 
							"models/aftokinito/wot/russian/t28/t-28_track_reverse"	}
-- ENT.VehicleCrosshairType = 3

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 5, 17, 10 )

ENT.SeatPos = Vector( 0, 0, 39 )
ENT.SeatAngle = Vector( 90, 0, 0 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1500
ENT.MinDamage = 1300
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 100, -35, 57 ),Vector( 100, 35, 57 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/russian/t28_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/russian/t28_turret.mdl"
ENT.TowerPos  = Vector( 27, -3.5, 70.5 )
ENT.BarrelModel = "models/aftokinito/wot/russian/t28_gun.mdl"
ENT.BarrelPos = Vector( 56, 0.5, 85.5 )
ENT.BarrelLength = 100

// Speed Limits
ENT.MaxVelocity = 45
ENT.MinVelocity = -20

ENT.InitialHealth = 4500
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


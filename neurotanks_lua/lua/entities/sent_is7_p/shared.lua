ENT.FolderName = "sent_is7_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Iosif Stalin 7"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier X";
ENT.Description = "WW2 Heavy Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasBarrelMGun = false
ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
ENT.HasCMGun = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95

-- ENT.DebugWheels = true

ENT.TankTrackZ = 10
ENT.TankTrackY = 60
ENT.TankTrackX = -50
ENT.TankNumWheels = 16

ENT.TankWheelTurnMultiplier = 200
ENT.TankWheelForceValFWD = 335
ENT.TankWheelForceValREV = 335

ENT.HasStaticSecondaryGuns = true
ENT.StaticGunPositions = { Vector( -39, -43.5, 20.4 ),Vector( -39, 43.5, 20.4 ) }
ENT.StaticGunAngles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
ENT.StaticGunCooldown = 0.115


ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/russian/is7_tracks_l.mdl","models/aftokinito/wot/russian/is7_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/russian/is7/kv_track", 
							"models/aftokinito/wot/russian/is7/kv_track_foward", 
							"models/aftokinito/wot/russian/is7/kv_track_reverse"	}
ENT.VehicleCrosshairType = 3
-- Smaller cannon 
--ENT.BarrelMGunPos = Vector( -14, -14.3, -4 )
--ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 5, 17, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 43 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 21, 18, 60 )

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
ENT.MaxDamage = 1300
ENT.MinDamage = 1700
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 100, -35, 57 ),Vector( 100, 35, 57 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/russian/is7_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/russian/is7_turret.mdl"
ENT.TowerPos  = Vector( 7, -1.25, 62 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/russian/is7_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 71, -1.25, 72 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel =  "models/airboatgun.mdl" --"models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( -30, -1.25, 115 )
ENT.MGunOffset = 15
ENT.CMGunPos = Vector(0,0,100)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 39.6
ENT.MinVelocity = -15
ENT.Acceleration = -8

ENT.InitialHealth = 6000
ENT.HealthVal = nil
ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0
ENT.CrewPositions = {
Vector( 96, -1, 46 ),
Vector( 31, -42, 57 ),
Vector( 58, 36, 54 ),
Vector( -35, 2, 47 )
}

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


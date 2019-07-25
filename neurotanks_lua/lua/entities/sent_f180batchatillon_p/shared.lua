ENT.FolderName = "sent_f180batchatillon_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "F18 Batchatillon 25t"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: aftokinito\n"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier IX";
ENT.Description = "WW2 Medium Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = true
ENT.HasCVol = true
ENT.MGunDebug = true
ENT.TrackPos = -10.5

-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 44, 27, 45 ),
Vector( 43, -23, 41 ),
Vector( -10, 7, 48 )
}
ENT.TankTrackZ = 14
ENT.TankTrackY = 50
ENT.TankTrackX = -40
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 250
ENT.TankWheelForceValFWD = 233
ENT.TankWheelForceValREV = 232

-- The amount the tank will tilt when it hits the throttle
ENT.StartAngleVelocity = 1.5

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/french/f18batchatillon_tracks_l.mdl","models/aftokinito/wot/french/f18batchatillon_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/french/f18_bat_catillon/bat_chatillon25t_track", 
							"models/aftokinito/wot/french/f18_bat_catillon/bat_chatillon25t_track_reverse", 
							"models/aftokinito/wot/french/f18_bat_catillon/bat_chatillon25t_track_forward"	}
ENT.SkinCount = 5
-- Smaller cannon 
--ENT.BarrelMGunPos = Vector( -17, 10, 50 )
--ENT.BarrelMGunModel = "models/weapons/minigun_test.mdl"

ENT.CamDist = 300
ENT.CamUp = 70
ENT.CockpitPosition = Vector( -18, 0, 51 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/chatillon/fire.wav")
ENT.ReloadSound1 = Sound("wot/chatillon/reload.wav")
ENT.ReloadSound2 = Sound("wot/chatillon/reload2.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 2.2
ENT.APDelay = ENT.PrimaryDelay
ENT.PrimaryEffect = "ChopperMuzzleFlash"
-- ENT.BarrelMGuns = { }
ENT.IsAutoLoader = true
ENT.MagazineSize = 6
ENT.RoundsPerSecond = 0.5


// Weapons
ENT.MaxDamage = 750
ENT.MinDamage = 500
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 98.5, -29.5, 39 ),Vector( 98.5, 29.5, 39 ) }
ENT.HeadLights.TPos = { Vector( -90, 21, 35 ),Vector( -90, 28, 35 ), Vector( -90, -28, 35 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/french/f18batchatillon_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/french/f18batchatillon_turret.mdl"
ENT.TowerPos  = Vector( -20, 0, 51 )
ENT.TowerPart = 0
ENT.BarrelModel = "models/aftokinito/wot/french/f18batchatillon_gun.mdl"
ENT.BarrelPart = 3
ENT.BarrelPos = Vector( -20, 0, 51 )
-- ENT.BarrelPos1 = Vector( 90, 1, 80 )
-- ENT.BarrelPos2 = Vector( -90, 1, 80 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
ENT.MGunPos = Vector( -44, 0, 129 ) 
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 65
ENT.MinVelocity = -20 //not specified in WoT wiki
ENT.Acceleration = 1

ENT.InitialHealth = 2600
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


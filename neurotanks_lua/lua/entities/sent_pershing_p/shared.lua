ENT.FolderName = "sent_pershing_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "M26 Pershing"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: beat the zombie\nModel Adaption: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier VII";
ENT.Description = "WW2 Medium Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.HasParts = true
ENT.HasCVol = true
ENT.TrackPos = -6.5
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 69, -28, 47 ),
Vector( 73, 25, 47 ),
Vector( 21, -12, 58 ),
Vector( 12, 19, 58 )
}
ENT.TankTrackZ = 14
ENT.TankTrackY = 55
ENT.TankTrackX = -25
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 222
ENT.TankWheelForceValFWD = 255
ENT.TankWheelForceValREV = 222

ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	50

ENT.TrackPositions = {Vector( 0,0,-1 ),Vector( 0,0,-1 )}
ENT.TrackModels = { "models/beat the zombie/wot/american/pershing_tracks_l.mdl","models/beat the zombie/wot/american/pershing_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/american/tracks/t23_track", 
							"models/beat the zombie/wot/american/tracks/t23_track_forward", 
							"models/beat the zombie/wot/american/tracks/t23_track_reverse"	}

ENT.SkinCount = 1
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -8, -18, 6 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 8, -11, 18 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.TrackSound = "wot/pershing/threads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1900
ENT.MinDamage = 1250
ENT.BlastRadius = 512


ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 105, -36.5, 57 ),Vector( 105, 37.5, 57 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/beat the zombie/wot/american/pershing_body.mdl"
ENT.TowerModel = "models/beat the zombie/wot/american/pershing_turret.mdl"
ENT.TowerPos  = Vector( 27, 1, 64 )
ENT.TowerPart = 1
ENT.BarrelModel = "models/beat the zombie/wot/american/pershing_gun.mdl"
ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 60, 0, 81.75 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, 0, 69 ) 
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 48
ENT.MinVelocity = -20
ENT.Acceleration = 1

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


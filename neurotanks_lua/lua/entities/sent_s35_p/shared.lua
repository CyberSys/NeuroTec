ENT.FolderName = "sent_s35_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Pz.Kpfw. S35 739 (f)"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier III";
ENT.Description = "WW2 Premium Medium Tank LEVEL 1"
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

ENT.CrewPositions = {
Vector( 48, 16, 54 ),
Vector( 41, -16, 55 ),
Vector( -7, 23, 53 ),
Vector( -3, -17, 51 )
}
-- ENT.DebugWheels = true

ENT.TankTrackZ = 14
ENT.TankTrackY = 35
ENT.TankTrackX = -30
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 390

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/french/s35_tracks_l.mdl","models/aftokinito/wot/french/s35_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/french/s35/s35_captured_track", 
							"models/aftokinito/wot/french/s35/s35_captured_track_forward", 
							"models/aftokinito/wot/french/s35/s35_captured_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -28.1, 7.3, -1.7 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 0, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 21, 0, 35 )
ENT.SeatAngle = Vector( 90, 0, 0 )
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
ENT.MaxDamage = 750
ENT.MinDamage = 500
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 81, -22, 35 ), Vector( 81, 22, 35 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/french/s35_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/french/s35_turret.mdl"
ENT.TowerPos  = Vector( 21, 0, 65 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/french/s35_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 52, -2, 77 )
ENT.BarrelLength = 150
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( 10, -1.25, 65 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 25
ENT.MinVelocity = -16
ENT.Acceleration = 1

ENT.InitialHealth = 3000
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


ENT.FolderName = "sent_su18_p"

ENT.Type = "vehicle"
-- ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "SU-8"
ENT.Author	= "NeuroTec\nLua: Aftokinito and Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Artillery"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.TankType = TANK_TYPE_HEAVY

ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 0.01
ENT.MaxBarrelPitch = 75
ENT.MaxRange =  TANK_RANGE_aRTILLERY_SHELL

ENT.ArtyView = true

ENT.CrewPositions = {
Vector( 51, 18, 63 ),
Vector( 54, -22, 64 ),
Vector( 2, -8, 70 )
}


ENT.ChillSeatPositions = { Vector( -90, 40, 60 ),Vector( -64, 40, 60 ) }
ENT.ChillSeatAngles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }

ENT.RecoilForce = 9999999
ENT.DebugWheels = true

ENT.TankTrackZ =  15
ENT.TankTrackY = 45
ENT.TankTrackX = -35
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444

ENT.ComplexTracks = true
ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/russian/su-08_tracks_l.mdl",
						"models/aftokinito/wot/russian/su-08_tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/aftokinito/wot/russian/su-08_wheels_l.mdl", "models/aftokinito/wot/russian/su-08_wheels_r.mdl" }
ENT.TrackOffset = Vector( 0,0,0 )

ENT.TrackAnimationOrder = { "models/aftokinito/wot/russian/su-08/su-14_track", 
							"models/aftokinito/wot/russian/su-08/su-14_track_forward", 
							"models/aftokinito/wot/russian/su-08/su-14_track_reverse" }


ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 65, 20, 38 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( -106, -16, 44 )


ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 10
ENT.APDelay = 12
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 4500
ENT.MinDamage = 3500
ENT.BlastRadius = 1000

-- Slow beast.
ENT.TurnMultiplier = 1.35
ENT.TurnMultiplierMoving = 0.45

ENT.Model = "models/aftokinito/wot/russian/su-08_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/russian/su-08_turret.mdl"
ENT.TowerPos  = Vector( -31, 0, 65 )
ENT.BarrelModel = "models/aftokinito/wot/russian/su-08_gun.mdl"
ENT.BarrelPos = Vector( -41, 0, 87  )
ENT.BarrelLength = 80
ENT.MaxBarrelYaw = 12
-- Limit eye angles
ENT.LimitView = 60

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 48
ENT.MinVelocity = -12
ENT.Acceleration = 2

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
ENT.PrimaryCooldown = 500
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


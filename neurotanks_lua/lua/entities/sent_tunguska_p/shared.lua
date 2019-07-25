ENT.FolderName = "sent_tunguska_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_AA
ENT.Base = "base_anim"
ENT.PrintName	= "9K22 Tunguska"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec - Anti-Air Vehicles";
ENT.Description = "Mobile AA"
ENT.Spawnable	= true
ENT.AdminSpawnable = false
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
ENT.NoRecoil = true
ENT.VehicleCrosshairType = 2

ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 52, -14, 35 ),
Vector( 30, 20, 36 ),
Vector( -16, -2, 39 ),
Vector( -60, 2, 33 )
}
ENT.TankTrackZ = 10
ENT.TankTrackY = 50
ENT.TankTrackX = -40
ENT.TankNumWheels = 14
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.Model = "models/aftokinito/wot/american/paladin_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/german/kugelblitz_turret.mdl"
ENT.TowerPos  = Vector( 8, 0, 64 )
ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/german/kugelblitz_gun.mdl"
ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 10, 0, 70 )

-- Overload class / size based ammo count.
ENT.ForcedMagazineCount = 2000

ENT.BarrelLength = 250
ENT.ExhaustPosition = {Vector( -99, -23, 60 ), Vector( -101, 4, 59 ) }
		
ENT.TrackPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/american/paladin_tracks_l.mdl",
						"models/aftokinito/wot/american/paladin_tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/aftokinito/wot/american/paladin_wheels_l.mdl", "models/aftokinito/wot/american/paladin_wheels_r.mdl",
					"models/aftokinito/wot/american/paladin_wheels_l.mdl", "models/aftokinito/wot/american/paladin_wheels_l.mdl"
						}
ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/paladin/m109a6_track_track", 
							"models/aftokinito/wot/american/paladin/m109a6_track_forward", 
							"models/aftokinito/wot/american/paladin/m109a6_track_reverse"	}
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -12, 1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

-- ENT.NoRecoil = true
ENT.RecoilForce = 0
ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 40, 0, 40 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf2/tanks/m6_autocannon_3p.mp3" )--"wot/t1_cun/burst.wav")
ENT.ReloadSound = Sound("bf2/tanks/m6_missile_reload.wav")
ENT.PrimaryAmmo = "sent_tank_mgbullet" 
ENT.PrimaryDelay = 0.1
-- ENT.APDelay = 0.5

ENT.OverrideImpactPointPrediction = true
ENT.BulletSpread = Angle( .005,.011,.011 )

ENT.BarrelPorts = { Vector( 125, 30, 0 ), Vector( 125, -30, 0 ) }

ENT.IsAutoLoader = true
ENT.MagazineSize = 4
ENT.RoundsPerSecond = 0.85

ENT.MaxDamage = 75
ENT.MinDamage = 35
ENT.BlastRadius = 32

-- ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = {Vector( 93, -39, 51 ), Vector( 94, 42, 51 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ),  Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.MGunSound = Sound("wot/global/mgun.wav")
ENT.CanLockOnTarget = true

// Speed Limits
ENT.MaxVelocity = 45
ENT.MinVelocity = -35
ENT.Acceleration = 5
ENT.CustomMuzzle = "tank_muzzleflash"
ENT.InitialHealth = 6000
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


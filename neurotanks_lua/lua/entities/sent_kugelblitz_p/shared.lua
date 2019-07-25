ENT.FolderName = "sent_cromwell_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Kugelblitz"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec - Anti-Air Vehicles";
ENT.Description = "WW2 AA Tank LEVEL 1"
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
ENT.TrackPos = -4.95
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 52, -14, 35 ),
Vector( 30, 20, 36 ),
Vector( -16, -2, 39 ),
Vector( -60, 2, 33 )
}
ENT.TankTrackZ = 10
ENT.TankTrackY = 50
ENT.TankTrackX = -40
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.Model = "models/aftokinito/wot/german/kugelblitz_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/german/kugelblitz_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 62 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/german/kugelblitz_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 0, 0, 62 )

ENT.BarrelPorts = { Vector( 113, -6, 12 ), Vector( 113, 6, 12 ) }

-- Overload class / size based ammo count.
ENT.ForcedMagazineCount = 600

ENT.BarrelLength = 80
ENT.ExhaustPosition = {Vector( -99, -23, 60 ), Vector( -101, 4, 59 ) }
		
ENT.TrackPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/german/kugelblitz_tracks_l.mdl",
						"models/aftokinito/wot/german/kugelblitz_tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/aftokinito/wot/german/kugelblitz_wheels_l.mdl",
					"models/aftokinito/wot/german/kugelblitz_wheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/aftokinito/wot/german/Kugelblitz/hummel_track.vmt", 
							"models/aftokinito/wot/german/Kugelblitz/hummel_track_forward.vmt", 
							"models/aftokinito/wot/german/Kugelblitz/hummel_track_reverse.vmt"	}
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -12, 1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

-- ENT.NoRecoil = true
ENT.RecoilForce = 999999
ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 40, 0, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf2/tanks/m6_autocannon_1p.mp3" )--"wot/t1_cun/burst.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_mgbullet" 
ENT.PrimaryDelay = 0.40
ENT.APDelay = 0.40

ENT.MaxDamage = 75
ENT.MinDamage = 35
ENT.BlastRadius = 0

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = {Vector( 93, -39, 51 ), Vector( 94, 42, 51 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ),  Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 25
ENT.MinVelocity = -25
ENT.Acceleration = 10
ENT.CustomMuzzle = "AA_muzzleflash"
ENT.InitialHealth = 2000
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


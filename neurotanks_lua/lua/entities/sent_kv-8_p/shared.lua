ENT.FolderName = "sent_kv-8_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "KV-8 (Flame Thrower)"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier V"
ENT.Description = "WW2 Heavy Tank LEVEL 2"
ENT.Spawnable	= true
ENT.AdminSpawnable = false
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
-- ENT.DebugWheels = true

ENT.FlamethrowerPos = Vector( 91, -22, 60 )
ENT.FlamethrowerAng = Angle( -8, 180, 0 )
ENT.FlamethrowerMdl = "models/weapons/w_smg1.mdl"
ENT.FlamethrowerParticle = "flamethrower_initial"


ENT.CrewPositions = {
Vector( 57, -10, 35 ),
Vector( 53, 20, 35 ),
Vector( -10, 1, 53 ),
Vector( -4, 21, 44 )
}

ENT.TankTrackZ = 1
ENT.TankTrackY = 50
ENT.TankTrackX = -67
ENT.TankNumWheels = 14
ENT.TurnMultiplier = 2.0
ENT.RecoilForce = 9999999/2
ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( -2,-1,4 ),Vector( -2,1,4 )}
ENT.TrackModels = { 
						"models/professorheavy/kv-1/kv1tracks_l.mdl",
						"models/professorheavy/kv-1/kv1tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/professorheavy/kv-1/kv1wheels_l.mdl",
					"models/professorheavy/kv-1/kv1wheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/wot/russians/kv-2/kv_track", 
							"models/wot/russians/kv-2/kv_track_forward", 
							"models/wot/russians/kv-2/kv_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -12, -6, -4 )
ENT.BarrelMGunModel = "models/bfp4f/ground/t-90/t-90_gun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 10, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

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
ENT.MaxDamage = 2000
ENT.MinDamage = 1500
ENT.BlastRadius = 612


ENT.Model = "models/professorheavy/kv-1/kv1body.mdl"
ENT.TowerModel = "models/professorheavy/kv-1/kv1turret.mdl"
ENT.TowerPos  = Vector( -9, 1, 53.500 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/kv-1/kv1gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 26, 0, 67 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( -20, 0, 0 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

// Speed Limits
ENT.MaxVelocity = 34
ENT.MinVelocity = -10
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


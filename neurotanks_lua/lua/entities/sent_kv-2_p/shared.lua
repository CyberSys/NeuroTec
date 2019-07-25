ENT.FolderName = "sent_kv-2_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "KV-2"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier VI"
ENT.Description = "WW2 Heavy Tank LEVEL 2"
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
ENT.TrackPos = -6.95
-- ENT.DebugWheels = true

ENT.MaxRange = TANK_RANGE_aRTILLERY_SHELL

ENT.CrewPositions = {
Vector( 81, -19, 37 ),
Vector( 78, 21, 37 ),
Vector( 25, 1, 43 ),
Vector( 2, 7, 43 )
}

ENT.TankTrackZ = -2
ENT.TankTrackY = 47
ENT.TankTrackX = -20
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 35,0.500,-2 ),Vector( 35,-0.500,-2 )}
ENT.TrackModels = { 
						"models/professorheavy/kv-1/kv1tracks_l.mdl",
						"models/professorheavy/kv-1/kv1tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/professorheavy/kv-1/kv1wheels_l.mdl",
					"models/professorheavy/kv-1/kv1wheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/wot/russians/kv-2/kv_track", 
							"models/wot/russians/kv-2/kv_track_forward", 
							"models/wot/russians/kv-2/kv_track_reverse"	}

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 20, 10, 20 )
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
ENT.PrimaryDelay = 8
ENT.APDelay = 8
ENT.PrimaryEffect = "ChopperMuzzleFlash"
ENT.RecoilForce = 9999999*1.5	
// Weapons
ENT.MaxDamage = 3300
ENT.MinDamage = 2100
ENT.BlastRadius = 612


ENT.Model = "models/professorheavy/kv-2/kv2body.mdl"
ENT.TowerModel = "models/professorheavy/kv-2/kv2turret.mdl"
ENT.TowerPos  = Vector( 25, 1, 47.500 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/kv-2/kv2gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 65, 0, 70 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -11
ENT.Acceleration = 5

ENT.InitialHealth = 3200
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


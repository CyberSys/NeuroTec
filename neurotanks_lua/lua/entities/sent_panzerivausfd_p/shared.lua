ENT.FolderName = "sent_panzerivausfd_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "PzKpfw IV Ausf. D"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier IV"
ENT.Description = "WW2 Medium Tank LEVEL 2"
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

ENT.CrewPositions = {
Vector( 57, -10, 35 ),
Vector( 53, 20, 35 ),
Vector( -10, 1, 53 ),
Vector( -4, 21, 44 )
}

ENT.TankTrackZ = 20
ENT.TankTrackY = 55
ENT.TankTrackX = -70
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0
ENT.RecoilForce = 9999999/2
ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 0,-1,4 ),Vector( 0,1,4 )}
ENT.TrackModels = { 
						"models/wot/germany/panzer iv ausf d/pzivdtracks_l.mdl",
						"models/wot/germany/panzer iv ausf d/pzivdtracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/germany/panzeriv d/pz_iv_ausfd_track", 
							"models/wot/germany/panzeriv d/pz_iv_ausfd_track_forward", 
							"models/wot/germany/panzeriv d/pz_iv_ausfd_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( 5, -13, -0)
ENT.BarrelMGunModel = "models/airboatgun.mdl"

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
ENT.ShootSound = Sound("wt/cannons/kwk40_shot_01.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 4
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2000
ENT.MinDamage = 1500
ENT.BlastRadius = 612


ENT.Model = "models/wot/germany/panzer iv ausf d/pzivdbody.mdl"
ENT.TowerModel = "models/wot/germany/panzer iv ausf d/pzivdturret.mdl"
ENT.TowerPos  = Vector( -3, 0, 66.100 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/wot/germany/panzer iv ausf d/pzivdgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 26.500, 0, 76.500 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector(-0, -1.25, 65)
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -15
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


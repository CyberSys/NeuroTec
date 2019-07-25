ENT.FolderName = "sent_b1_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "B1"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Prof.Heavy\nmodel WoT"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier IV";
ENT.Description = "WW2 Heavy Tank LEVEL 1"
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
ENT.TrackPos = -4.95
ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 44, 3, 54 ),
Vector( 7, 22, 57 ),
Vector( 4, -30, 57 ) 
}
ENT.TankTrackZ = 18
ENT.TankTrackY = 45
ENT.TankTrackX = -30
ENT.TankNumWheels = 14
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -15, -4, 1 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"



ENT.TrackPositions = {Vector( -0.500,1,3.500 ),Vector( -0.500,-1,3.500 )}
ENT.TrackModels = { 
						"models/wot/france/b1/b1tracks_l.mdl",
						"models/wot/france/b1/b1tracks_r.mdl"  
						}
						
						
ENT.TrackAnimationOrder = { "models/wot/french/b1/b1_track", 
							"models/wot/french/b1/b1_track_forward", 
							"models/wot/french/b1/b1_track_reverse"	}

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 50, 0, 35 )
ENT.SeatAngle = Vector( 50, 0, 0 )
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
ENT.MaxDamage = 1600
ENT.MinDamage = 1050
ENT.BlastRadius = 612


ENT.Model = "models/wot/france/b1/b1 body.mdl"
ENT.TowerModel = "models/wot/france/b1/b1 turret.mdl"
ENT.TowerPos  = Vector( 50, 10, 65 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/wot/france/b1/b1 gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 80, 8,75 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( 40, -0, 80 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 18
ENT.MinVelocity = -8
ENT.Acceleration = 28

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


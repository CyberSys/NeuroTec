ENT.FolderName = "sent_ltp_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "LTP"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Prof.Heavy\nmodel WoT"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier III";
ENT.Description = "WW2 Light Tank LEVEL 1"
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
ENT.TankTrackZ = 25
ENT.TankTrackY = 40
ENT.TankTrackX = -50
ENT.TankNumWheels = 10
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -15, -6, 0 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"



ENT.TrackPositions = {Vector( -0.500,1,3.500 ),Vector( -0.500,-1,3.500 )}
ENT.TrackModels = { 
						"models/professorheavy/ltp/ltptracks_l.mdl",
						"models/professorheavy/ltp/ltptracks_r.mdl"  
						}
						
						
ENT.TrackAnimationOrder = { "models/wot/russians/ltp/T-60_track", 
							"models/wot/russians/ltp/T-60_track_forward", 
							"models/wot/russians/ltp/T-60_track_reverse"	}

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
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


ENT.Model = "models/professorheavy/ltp/ltpbody.mdl"
ENT.TowerModel = "models/professorheavy/ltp/ltpturret.mdl"
ENT.TowerPos  = Vector( 10, -2, 62 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/ltp/ltpgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 34, -2, 68 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( 10, -1, 65 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 45.1
ENT.MinVelocity = -18
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


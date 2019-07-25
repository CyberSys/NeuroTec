ENT.FolderName = "sent_leopard1_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Leopard 1"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Prof.heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier X";
ENT.Description = "WW2 Fast Medium Tank LEVEL 1"
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
ENT.MaxBarrelPitch = 20
ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 136, 35, 58 ),
Vector( 131, -18, 62 ),
Vector( 72, -25, 74 ),
Vector( 36, 65, 69 )
}

-- local zpos = 152
-- local xpos = 55
-- ENT.TubePos = { 
-- Vector( xpos, 35, zpos ), 
-- Vector( xpos, 31, zpos ), 
-- Vector( xpos, 31, zpos ), 
-- Vector( xpos-5, -22, zpos ), 
-- Vector( xpos-5, -22, zpos ), 
-- Vector( xpos-5, -22, zpos )
-- }
-- ENT.TubeAng = { 
-- Angle( -25, 5, 0 ), 
-- Angle( -25, 15, 0 ), 
-- Angle( -25, 20, 0 ), 
-- Angle( -21, -5, 0 ), 
-- Angle( -21, -15, 0 ), 
-- Angle( -21, -20, 0 ) 
-- }
ENT.TankTrackZ = 13
ENT.TankTrackY = 60
ENT.TankTrackX = -25
ENT.TankNumWheels = 18
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 450
ENT.TankWheelForceValREV = 340




ENT.HasMGun = true
-- Gunner pos
ENT.CopilotPos = Vector( 80, -20, 83 )
ENT.MGunModel = "models/weapons/hueym60/m60.mdl"
ENT.MGunPos = Vector( 15, -25, 124 ) 
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")


ENT.TrackPositions = {Vector( 0,-0.600,3.500 ),Vector( 0,1,3.500 )}
ENT.TrackModels = { 
						"models/professorheavy/leopard1/leopard1tracks_l.mdl",
						"models/professorheavy/leopard1/leopard1tracks_r.mdl"  
						}
						

ENT.TrackAnimationOrder = { "models/wot/germany/leopard 1/leopard1_track", 
							"models/wot/germany/leopard 1/leopard1_track_forward", 
							"models/wot/germany/leopard 1/leopard1_track_reverse"	}

ENT.CamDist = 500
ENT.CamUp = 90
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
ENT.MaxDamage = 2500
ENT.MinDamage = 1900
ENT.BlastRadius = 612


ENT.Model = "models/professorheavy/leopard1/leopard1body.mdl"
ENT.TowerModel = "models/professorheavy/leopard1/leopard1turret.mdl"
ENT.TowerPos  = Vector( 30, 6, 79.500 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/leopard1/leopard1gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 72, 6, 96 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 35
ENT.MinVelocity = -25
ENT.Acceleration = 5

ENT.InitialHealth = 7000
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


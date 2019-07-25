ENT.FolderName = "sent_jagdpanzere100_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "JagdPz E-100"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof.heavy\nRipping: beat the zombie"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier X";
ENT.Description = "WW2 Super Heavy Tank Destroyer LEVEL 1"
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
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 1.7 

ENT.CrewPositions = {
Vector( 41, 1, 46 ),
Vector( -12, 25, 53 ),
Vector( 1, -28, 53 )
}
-- ENT.ArtyView = true

ENT.DebugWheels = true

ENT.TankTrackZ =  14
ENT.TankTrackY = 60
ENT.TankTrackX = 10
ENT.TankNumWheels = 16

ENT.TankWheelTurnMultiplier = 150
ENT.TankWheelForceValFWD = 254
ENT.TankWheelForceValREV = 254

ENT.ArmorThicknessFront = 0.75
ENT.ArmorThicknessSide = 0.37
ENT.ArmorThicknessRear = 0.55

ENT.TrackPositions = {Vector( 50,-3,3.500 ),Vector( 50,-3,1.500 )}
ENT.TrackModels = { 
						"models/professorheavy/jagdpanzere100/jagdpze100tracks_l.mdl",
						"models/professorheavy/jagdpanzere100/jagdpze100tracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/german/tracks/maus_track", 
							"models/beat the zombie/wot/german/tracks/maus_track_forward", 
							"models/beat the zombie/wot/german/tracks/maus_track_reverse"	}

ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 50 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1700
ENT.MinDamage = 400
ENT.BlastRadius = 156


ENT.Model = "models/professorheavy/jagdpanzere100/jagdpze100body.mdl"
ENT.TowerModel = "models/props_junk/garbage_coffeemug001a.mdl"
ENT.TowerPos  = Vector( 40, -3, 95 )
ENT.BarrelModel = "models/professorheavy/jagdpanzere100/jagdpze100gun.mdl"
-- ENT.BarrelModel = "models/props_junk/garbage_coffeemug001a.mdl"
ENT.BarrelPos = Vector( 40, -3, 95  )
ENT.BarrelLength = 270
ENT.MaxBarrelYaw = 15
-- Limit eye angles
ENT.LimitView = 0

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 30
ENT.MinVelocity = -10 //Not specified in WoT wiki
ENT.Acceleration = 0

ENT.InitialHealth = 9000
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


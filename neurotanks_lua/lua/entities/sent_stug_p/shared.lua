ENT.FolderName = "sent_stug_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "StuG III Ausf. G"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof.heavy\nRipping: beat the zombie"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier V";
ENT.Description = "WW2 Tank Destroyer LEVEL 1"
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
ENT.TurnMultiplier = 0.8 

ENT.CrewPositions = {
Vector( 41, 1, 46 ),
Vector( -12, 25, 53 ),
Vector( 1, -28, 53 )
}


-- ENT.DebugWheels = true

ENT.TankTrackZ =  14
ENT.TankTrackY = 50
ENT.TankTrackX = -20
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444


ENT.TrackPositions = {Vector( 60,-63,4 ),Vector( -33.500,30,4 )}
ENT.TrackModels = { 
						"models/professorheavy/stug/stugtracks_l.mdl",
						"models/professorheavy/stug/stugtracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/german/tracks/stug_iii_track", 
							"models/wot/german/tracks/stug_iii_track_forward", 
							"models/wot/german/tracks/stug_iii_track_reverse"	}

ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 30 )
ENT.SeatAngle = Vector( -15, 0, 0 )
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



ENT.Model = "models/professorheavy/stug/stugbody.mdl"
ENT.TowerModel = "models/props_junk/garbage_coffeemug001a.mdl"
ENT.TowerPos  = Vector( 25, -8, 60 )
ENT.BarrelModel = "models/professorheavy/stug/stuggun.mdl"
ENT.BarrelPos = Vector( 20, -8, 60  )
ENT.BarrelLength = 65
ENT.MaxBarrelYaw = 13
-- Limit eye angles
ENT.LimitView = 60

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 40
ENT.MinVelocity = -15 //not specified in WoT wiki
ENT.Acceleration = 0

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


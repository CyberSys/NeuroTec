ENT.FolderName = "sent_e75_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "E-75"
ENT.Author	= "NeuroTec\nLua: Hoffa\nModel Adaption: Beat the Zombie / Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier IX";
ENT.Description = "WW2 Heavy Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.HasCVol = true

-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 75, -30, 59 ),
Vector( 68, 16, 57 ),
Vector( -21, -3, 61 ),
Vector( -22, 6, 62 )
}
ENT.TankTrackZ = 14
ENT.TankTrackY = 55
ENT.TankTrackX = -25
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 390

ENT.ArmorThicknessFront = 0.2
ENT.ArmorThicknessRear = 0.25
ENT.ArmorThicknessSide = 0.18
		
ENT.WoTStyleAiming = true
ENT.MinRange = 0
ENT.MaxRange = 200000
-- ENT.LaunchVelocity =  4000 + ( 75500 * ENT.TankType ) / 14

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.EngineVolume = 1.0
ENT.EngineSounds = {"ambient/machines/diesel_engine_idle1.wav"}
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.ShutDownSound = "ambient/machines/spindown.wav"

-- Used for HUD and damage controls
ENT.VehicleType = VEHICLE_TANK
-- Is artillery unit?
ENT.IsArtillery = false
-- Has OldStyle binoculars.
ENT.HasBinoculars = true
-- Has movable tower
ENT.HasTower = true
-- Can cockpitview
ENT.HasCockpit = true
-- Has MGun?
ENT.HasMGun = false
-- Z pos of track entities
ENT.TrackPos = -25.5
-- Amount of skins available on the model. 
ENT.SkinCount = 1
-- The amount the tank will tilt when it hits the throttle
ENT.StartAngleVelocity = 100
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = -38
-- Tower turn sound
ENT.SoundTower = "wot/tigeri/turret.wav"
-- Sound to make when the tower stops turning
ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
-- Camera Distance
ENT.CamDist = 280
-- Camera height
ENT.CamUp = 75
-- Cockpitview Vector
ENT.CockpitPosition = Vector(  15, 20, 8 )
-- Pilot seat position
ENT.SeatPos = Vector( -23, 0, 50 )
-- Seat angle
ENT.SeatAngle = Vector( 0, 0, 0 )
-- Thread sounds?
ENT.HasCVol = true
-- Ranges from 0.0 to 1.0
ENT.CVol = 1.0
-- Sound tracks emit when moving
ENT.TrackSound = "wot/is7/treads.wav"
-- Startup sound
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- Startup sound length
ENT.StartupDelay = 1.0 -- Seconds
-- Shoot sound
ENT.ShootSound = Sound("bf2/tanks/d30_artillery_fire.mp3")
-- Reloadsound
ENT.ReloadSound = Sound("vehicles/tank_readyfire1.wav")
-- Entity class of ammo
ENT.PrimaryAmmo = "sent_tank_shell" 
-- Delay between shots
ENT.PrimaryDelay = 4.45
-- Muzzle effect to call when firing.
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- // Weapons -- Unused atm, see damagetables 
ENT.MaxDamage = 1900
ENT.MinDamage = 1100
ENT.BlastRadius = 512
-- Headlight variables. Projected texture + sprite variables.
ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 103, 0, 72 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

-- Tank Body Model
ENT.Model = "models/wot/german/e-75_body.mdl"
-- Tank Tower Model
ENT.TowerModel = "models/wot/german/e-75_turret.mdl"
-- Tower pos 
ENT.TowerPos  = Vector( -15, 0, 69.5 )
-- Barrel model
ENT.BarrelModel = "models/wot/german/e-75_gun.mdl"
-- Position relative to tower
ENT.BarrelPos = Vector( 40, 0, 85 )
-- Aproximate barrel length. Used for placing muzzle effect + projectile.
ENT.BarrelLength = 220

-- If the tracks are a separate model we need these variables.
ENT.TrackPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { "models/wot/german/e-75_track_left.mdl", "models/wot/german/e-75_track_right.mdl" }
ENT.TrackWheels = { "models/wot/german/e-75_wheel_left.mdl", "models/wot/german/e-75_wheel_right.mdl" }
-- Table structure for animated thread textures.
-- [1] Idle
-- [2] Forward
-- [3] Reverse
ENT.TrackAnimationOrder = { "models/wot/german/e-75/tiger_ii_track", 
							"models/wot/german/e-75/tiger_ii_track_foward", 
							"models/wot/german/e-75/tiger_ii_track_reverse"	}

-- Secondary Weapon
ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Position relative to tower
ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shoot sound
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

--// Speed Limits
ENT.MaxVelocity = 40
ENT.MinVelocity = -15 //not specified in WoT wiki
ENT.Acceleration = 2

ENT.InitialHealth = 8000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0


--// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


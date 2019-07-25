ENT.FolderName = "sent_t71_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "T71"
ENT.Author	= "NeuroTec\nLua: Hoffa\nModel Adaption: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier VII";
ENT.Description = "WW2 Light Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true

-- Follow tower instead of body in 3rd person view.
ENT.CameraChaseTower = true

--Test, additional seats on the outside so you can carry bro's around.
ENT.ChillSeatPositions = { Vector( -75, -40, 50 ), Vector( 14, -40, 50 ), Vector( -75, 40, 55 ), Vector( 14, 40, 50 ) }
ENT.ChillSeatAngles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 0, 0 ), Angle( 0, 0, 0 ) }
-- ENT.DebugWheels = true

-- ENT.TankWheelNum = 8
ENT.TankTrackZ = 15
ENT.TankTrackY = 44
ENT.TankTrackX = -20
ENT.TankNumWheels = 8

--// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -15
ENT.Acceleration = 5


ENT.TankWheelTurnMultiplier = 2
ENT.TankWheelForceValFWD = 550
ENT.TankWheelForceValREV = 350

-- Slow beast.
ENT.MouseScale3rdPerson = 0.10
ENT.MouseScale1stPerson = 0.10
ENT.TurnMultiplier = 3.1
ENT.TurnMultiplierMoving = 2.55

-- This tank is VERY armored.
ENT.ArmorThicknessFront = 0.25
ENT.ArmorThicknessSide = 0.15
ENT.ArmorThicknessRear = 0.55

--Autoloader
ENT.IsAutoLoader = true
ENT.MagazineSize = 6
ENT.RoundsPerSecond = 0.5

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
ENT.TrackPos = 0
-- Amount of skins available on the model. 
ENT.SkinCount = 1
-- The amount the tank will tilt when it hits the throttle
ENT.StartAngleVelocity = 0
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 35
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
ENT.ShootSound = Sound("wot/chatillon/fire.wav")
ENT.ReloadSound1 = Sound("wot/chatillon/reload.wav")
ENT.ReloadSound2 = Sound("wot/chatillon/reload2.wav")
-- Reloadsound
ENT.ReloadSound = Sound("vehicles/tank_readyfire1.wav")
-- Entity class of ammo
ENT.PrimaryAmmo = "sent_tank_shell" 
-- Delay between shots
ENT.PrimaryDelay = 4.45
-- Muzzle effect to call when firing.
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- // Weapons -- Unused atm, see damagetables 
--ENT.MaxDamage = 1900
--ENT.MinDamage = 1100
ENT.BlastRadius = 512
-- Headlight variables. Projected texture + sprite variables.
-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 103, 0, 72 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

-- Tank Body Model
ENT.Model = "models/aftokinito/wot/american/t71_body.mdl"
-- Tank Tower Model
ENT.TowerModel = "models/aftokinito/wot/american/t71_turret.mdl"
ENT.TowerPart = 0
-- Tower pos 
ENT.TowerPos  = Vector( -7, 0, 55 )
-- Pilot seat position
ENT.SeatPos = Vector( 0, 0, 35 )

-- Barrel model
ENT.BarrelModel = "models/aftokinito/wot/american/t71_gun.mdl"
ENT.BarrelPart = 2
-- Position relative to tower
ENT.BarrelPos = Vector( -7, 0, 70 )
-- Aproximate barrel length. Used for placing muzzle effect + projectile.
ENT.BarrelLength = 220

-- If the tracks are a separate model we need these variables.
ENT.TrackPositions = {Vector( 0,0,5 ),Vector( 0,0,5 )}
ENT.TrackModels = { "models/aftokinito/wot/american/t71_tracks_l.mdl","models/aftokinito/wot/american/t71_tracks_r.mdl" }
ENT.TrackWheels = { "models/aftokinito/wot/american/t71_wheels_l.mdl", "models/aftokinito/wot/american/t71_wheels_r.mdl" }
-- Table structure for animated thread textures.
-- [1] Idle
-- [2] Forward
-- [3] Reverse
ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/t71/t71_track", 
							"models/aftokinito/wot/american/t71/t71_track_forward", 
							"models/aftokinito/wot/american/t71/t71_track_reverse"}

-- Secondary Weapon
--ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Position relative to tower
--ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shoot sound
--ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

ENT.InitialHealth = 2000
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


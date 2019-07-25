ENT.FolderName = "sent_wte100_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Waffentrager E-100"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof. heavy\nModel Adaption: Professor heavy"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier X";
ENT.Description = "Super Tank Destroyer LEVEL 2"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.HasMGun = true

ENT.CrewPositions = {
Vector( 59, -16, 46 ),
Vector( 61, 28, 46 ),
Vector( -0, 5, 57 )
}

ENT.RecoilForce = 9999999/1.2
-- Follow tower instead of body in 3rd person view.
ENT.CameraChaseTower = true

--Test, additional seats on the outside so you can carry bro's around.
-- ENT.DebugWheels = true

-- ENT.TankWheelNum = 8
ENT.TankTrackZ = 0
ENT.TankTrackY = 42
ENT.TankTrackX = -20
ENT.TankNumWheels = 10

--// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -15
ENT.Acceleration = 5


ENT.TankWheelTurnMultiplier = 1.25
ENT.TankWheelForceValFWD = 550
ENT.TankWheelForceValREV = 350


-- Slow beast.
ENT.MouseScale3rdPerson = 0.0910
ENT.MouseScale1stPerson = 0.0910
ENT.TurnMultiplier = 2.1
ENT.TurnMultiplierMoving = 1.55

-- This tank is VERY armored.
ENT.ArmorThicknessFront = 0.25
ENT.ArmorThicknessSide = 0.15
ENT.ArmorThicknessRear = 0.55

--Autoloader
-- ENT.IsAutoLoader = true
-- ENT.MagazineSize = 6
-- ENT.RoundsPerSecond = 0.3
ENT.IsAutoLoader = true
ENT.MagazineSize = 6
ENT.RoundsPerSecond = 0.35

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
ENT.CockpitPosition = Vector(  40, 20, 20 )

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
ENT.PrimaryDelay = 4.5
ENT.ApDelay = 4.5
-- Muzzle effect to call when firing.
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- // Weapons -- Unused atm, see damagetables 
ENT.MaxDamage = 1000
ENT.MinDamage = 900
ENT.BlastRadius = 760

-- Tank Body Model
ENT.Model = "models/wot/germany/waffentragere100/wte100body.mdl"
-- Tank Tower Model
ENT.TowerModel = "models/wot/germany/waffentragere100/wte100turret.mdl"
ENT.TowerPart = 0
-- Tower pos 
ENT.TowerPos  = Vector( -100, -3, 37 )
-- Pilot seat position
ENT.SeatPos = Vector( 0, 0, 35 )

-- Barrel model
ENT.BarrelModel = "models/wot/germany/waffentragere100/wte100gun.mdl"
ENT.BarrelPart = 2
-- Position relative to tower
ENT.BarrelPos = Vector( -120, -3, 83 )

-- Aproximate barrel length. Used for placing muzzle effect + projectile.
ENT.BarrelLength = 180

-- If the tracks are a separate model we need these variables.

ENT.TrackPositions = {Vector( 0,0,4 ),Vector( 0,0,4 )}
ENT.TrackModels = { 
						"models/wot/germany/waffentragere100/wte100tracks_l.mdl",
						"models/wot/germany/waffentragere100/wte100tracks_r.mdl"  
						}
						
ENT.TrackAnimationOrder = { "models/wot/germany/waffentragere-100/e100_track", 
							"models/wot/germany/waffentragere-100/e100_track_forward", 
							"models/wot/germany/waffentragere-100/e100_track_reverse"	}
-- Secondary Weapon
--ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Position relative to tower
--ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shoot sound
--ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")
ENT.MGunSound = Sound("wot/global/mgun.wav")
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




ENT.FolderName = "sent_m4autoloader_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "M4 Sherman Autoloader"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof. heavy\nModel Adaption: Professor heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier VI";
ENT.Description = "WW2 Premium Medium Tank LEVEL 1"
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
ENT.TankTrackZ = 15
ENT.TankTrackY = 38
ENT.TankTrackX = -20
ENT.TankNumWheels = 10

--// Speed Limits
ENT.MaxVelocity = 27
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
ENT.CockpitPosition = Vector(  20, 20, 8 )

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
ENT.PrimaryDelay = 2.45
-- Muzzle effect to call when firing.
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- // Weapons -- Unused atm, see damagetables 
--ENT.MaxDamage = 1900
--ENT.MinDamage = 1100
ENT.BlastRadius = 512

-- Tank Body Model
ENT.Model = "models/professorheavy/m4autoloader/m4autobody.mdl"
-- Tank Tower Model
ENT.TowerModel = "models/professorheavy/m4autoloader/m4autoturret.mdl"
ENT.TowerPart = 0
-- Tower pos 
ENT.TowerPos  = Vector( 12, 7, 63 )
-- Pilot seat position
ENT.SeatPos = Vector( 0, 0, 35 )

-- Barrel model
ENT.BarrelModel = "models/professorheavy/m4autoloader/m4autogun.mdl"
ENT.BarrelPart = 2
-- Position relative to tower
ENT.BarrelPos = Vector( 3, 7, 80 )
-- Aproximate barrel length. Used for placing muzzle effect + projectile.
ENT.BarrelLength = 180

-- If the tracks are a separate model we need these variables.

ENT.TrackPositions = {Vector( 0,0,4 ),Vector( 0,0,4 )}
ENT.TrackModels = { 
						"models/professorheavy/m4autoloader/m4e8tracks_l.mdl",
						"models/professorheavy/m4autoloader/m4e8tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/professorheavy/m4autoloader/m4e8wheels_l.mdl",
					"models/professorheavy/m4autoloader/m4e8wheels_r.mdl" }
						
ENT.TrackAnimationOrder = { "models/wot/american/m5a1/m2_med_track", 
							"models/wot/american/m5a1/m2_med_track_forward", 
							"models/wot/american/m5a1/m2_med_track_reverse"	}
-- Secondary Weapon
--ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Position relative to tower
--ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shoot sound
--ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")
ENT.MGunSound = Sound("wot/global/mgun.wav")
ENT.InitialHealth = 3000
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


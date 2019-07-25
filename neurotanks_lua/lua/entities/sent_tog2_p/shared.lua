ENT.CanFloat = true
ENT.FloatRatio = 4.0

ENT.FolderName = "sent_tog2_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "TOG-II"
ENT.Author	= "NeuroTec\nLua: Hoffa\nModel Adaption: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier VI";
ENT.Description = "WW2 Premium Heavy Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
-- ENT.TrackSound = "wot/tigeri/tracks2.wav"
-- Follow tower instead of body in 3rd person view.
ENT.CameraChaseTower = true
ENT.CrewPositions = {
Vector( 120, 17, 62 ),
Vector( 104, 14, 62 ),
Vector( 29, 23, 57 ),
Vector( 110, -30, 64 )

};
--Test, additional seats on the outside so you can carry bro's around.
ENT.ChillSeatPositions = { Vector( -86, -40, 67 ), Vector( -14, -40, 67 ), Vector( -86, 40, 67 ), Vector( -14, 40, 67 ) }
ENT.ChillSeatAngles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 0, 0 ), Angle( 0, 0, 0 ) }

-- ENT.DebugWheels = true

-- Has MGun?
ENT.HasMGun = true
-- Gunner pos
ENT.CopilotPos = Vector( 80, -20, 83 )
ENT.MGunModel = "models/weapons/hueym60/m60.mdl"
ENT.MGunPos = Vector( 100, -21, 110 ) 
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")


ENT.TankTrackZ = 12
ENT.TankTrackY = 46
ENT.TankTrackX = -25
ENT.TankNumWheels = 18

ENT.TankWheelTurnMultiplier = 400
ENT.TankWheelForceValFWD = 435
ENT.TankWheelForceValREV = 435

-- Slow beast.
ENT.MouseScale3rdPerson = 0.045
ENT.MouseScale1stPerson = 0.045
ENT.TurnMultiplier = 0.45
ENT.TurnMultiplierMoving = 0.45

-- This tank is VERY armored.
ENT.ArmorThicknessFront = 0.5
ENT.ArmorThicknessSide = 0.35
ENT.ArmorThicknessRear = 0.75

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

-- Z pos of track entities
ENT.TrackPos = -25.5
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
ENT.CVol = 0.1
-- Sound tracks emit when moving
ENT.TrackSound = "wot/is7/treads.wav"
-- Startup sound
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.ShutDownSound = "plats/rackstop1.wav"
ENT.EngineSounds = { 
					"ambient/machines/diesel_engine_idle1.wav",
					"ambient/machines/diesel_engine_idle1.wav", 
					"ambient/machines/diesel_engine_idle1.wav" 
					}

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
ENT.Model = "models/aftokinito/wot/british/tog_ii_body.mdl"
-- Tank Tower Model
ENT.TowerModel = "models/aftokinito/wot/british/tog_ii_turret.mdl"
-- Tower pos 
ENT.TowerPos  = Vector( 70, 0, 75 )
-- Pilot seat position
ENT.SeatPos = Vector( 70, 0, 50 )

-- Barrel model
ENT.BarrelModel = "models/aftokinito/wot/british/tog_ii_gun.mdl"
-- Position relative to tower
ENT.BarrelPos = Vector( 111.5, 0, 93 )
-- Aproximate barrel length. Used for placing muzzle effect + projectile.
ENT.BarrelLength = 220

-- If the tracks are a separate model we need these variables.
ENT.TrackPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { "models/aftokinito/wot/british/tog_ii_tracks_l.mdl", "models/aftokinito/wot/british/tog_ii_tracks_r.mdl" }
ENT.TrackWheels = { "models/aftokinito/wot/british/tog_ii_wheels_l.mdl", "models/aftokinito/wot/british/tog_ii_wheels_r.mdl" }
-- Table structure for animated thread textures.
-- [1] Idle
-- [2] Forward
-- [3] Reverse
ENT.TrackAnimationOrder = { "models/aftokinito/wot/british/tog_ii/tog_ii_track", 
							"models/aftokinito/wot/british/tog_ii/tog_ii_track_forward", 
							"models/aftokinito/wot/british/tog_ii/tog_ii_track_reverse"	}

-- Secondary Weapon
-- ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Position relative to tower
-- ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shoot sound
-- ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

--// Speed Limits
ENT.MaxVelocity = 14
ENT.MinVelocity = -7
ENT.Acceleration = 5

ENT.InitialHealth = 10000
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


-- This should be obvious, its this folders name.
ENT.FolderName = "sent_m47e2patton_p"
-- Used by hud stuff
ENT.Type = "vehicle"
-- base entity we derive from
ENT.Base = "base_anim"
-- Used by hud, menus etc.
ENT.PrintName	= "M47E2 105MM Patton"
-- Your name goes here
ENT.Author	= "NeuroTec\nLua: hoffa and prof.heavy\nRipping: prof.heavy"
-- Tier / Category in spawn menu
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier IX";
-- Used by info popup
ENT.Description = "WW2 Medium Tank LEVEL 2"
-- duh
ENT.Spawnable	= true
ENT.AdminSpawnable = true
-- Used for collision and damage stuff
ENT.VehicleType = VEHICLE_TANK
ENT.TankType = TANK_TYPE_MEDIUM
-- Adds binocular hud, UNUSED
ENT.HasBinoculars = true
-- This will hide the Tower Model, Used for Tank destroyers and such
ENT.HasTower = true
-- Determines if we'll use the variable ENT.SeatPos (Vector) or a default vector.
ENT.HasCockpit = true
-- Enables Machinegun Logic, Requires you to specify MachineGun Variables. See IS-7 for Reference.
ENT.HasMGun = true
-- Makes use of Bodygroup ammo system
ENT.HasParts = false
-- Play a grinding track sound when we move.
ENT.HasCVol = true
-- Length of traceline from tank Z pos to ground
ENT.TrackPos = -6.5

-- Crew hit locations
ENT.CrewPositions = {
Vector( 69, -28, 47 ),
Vector( 73, 25, 47 ),
Vector( 21, -12, 58 ),
Vector( 12, 19, 58 )
}

-- This variable will make our physical wheels visible.
-- ENT.DebugWheels = true
-- Wheel Z position
ENT.TankTrackZ = 14
-- Wheel Y position
ENT.TankTrackY = 55
-- Wheel X position
ENT.TankTrackX = -25
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number.
ENT.TankNumWheels = 12
-- AngleVelocity to apply to wheels when turning
ENT.TankWheelTurnMultiplier = 222
-- AngleVelocity applied when going forward, this controls the acceleration and "horsepower"
ENT.TankWheelForceValFWD = 255
-- same as above but reverse
ENT.TankWheelForceValREV = 222
-- Adds a slight push to our tank when we start driving to simulate acceleration.
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	50
-- Where our track models will spawn relative to tank position.
ENT.TrackPositions = {Vector( 0,0,3),Vector( 0,0,3 )}
-- Models used.
ENT.TrackModels = { "models/m47 patton/m47tracks_r.mdl","models/m47 patton/m47tracks_l.mdl"  }
-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/american/tracks/t23_track", 
							"models/beat the zombie/wot/american/tracks/t23_track_forward", 
							"models/beat the zombie/wot/american/tracks/t23_track_reverse" }

-- Will randomize skin on spawn if >1
ENT.SkinCount = 1
-- Smaller cannon, barrel machinegun
ENT.BarrelMGunPos = Vector( -3, -9, 4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- Camera Distance from tank
ENT.CamDist = 280
-- Camera Z position
ENT.CamUp = 75
-- Cockpit position relative to Barrel.
ENT.CockpitPosition = Vector( 8, -11, 18 )
-- Pilot Seat position
ENT.SeatPos = Vector( 0, 0, 25 )
-- Pilto Seat Angle, change Pitch if model is outside tank.
ENT.SeatAngle = Vector( 0, 0, 0 )
-- Grinding noise if ENT.CVol is enabled.
ENT.TrackSound = "wot/pershing/threads.wav"
-- Startup Sound
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- Engine Sounds, Table, add more sounds to create a mux.
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
-- Delay before we can drive away.
ENT.StartupDelay = 1.0 -- Seconds
-- Tower Turn Stopping Sound
ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
-- Tower Moving Sound
ENT.SoundTower = "wot/tigeri/turret.wav"
-- Primary Shoot Sound
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
-- Sound to play when tank is reloading
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
-- not necessary to use.
ENT.PrimaryAmmo = "sent_tank_shell" 
-- Shoot delay
ENT.PrimaryDelay = 5
-- AP Delay
ENT.APDelay = 7
-- Muzzleflash
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- Can be used in ENT.AmmoTable
ENT.MaxDamage = 2900
ENT.MinDamage = 1950
ENT.BlastRadius = 512

-- Lamp Table
ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
-- Positions where to place headlight sprites and lamps
ENT.HeadLights.Pos = { Vector( 105, -36.5, 57 ),Vector( 105, 37.5, 57 ) }
-- Angle correction
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- Headlight Color
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- Used by env_projectedtexture to add a flickering noise
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = "" -- Custom Texture?
-- Body/Hull Model
ENT.Model = "models/m47 patton/m47 body.mdl"
-- Tower Model
ENT.TowerModel = "models/m47 patton/m47 turret.mdl"
-- Tower Pos relative to body
ENT.TowerPos  = Vector( 35, 0, 61 )
-- Barrle model
ENT.BarrelModel = "models/killstr3aks/wot/american/m103_gun.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( 76, 0, 81.75 )
-- Adjust this if the muzzleflash looks off.
ENT.BarrelLength = 220
-- Machinegun Model
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
-- Relative to body
ENT.MGunPos = Vector( -0, 0, 69 ) 
-- Shootsound
ENT.MGunSound = Sound("wot/global/mgun.wav")

-- Max velocity. 10 = slowsauce, 100 = Intergalactic travel
ENT.MaxVelocity = 48
-- Same, but reversed :P
ENT.MinVelocity = -20
-- Starting Health, Also used by the repairgun
ENT.InitialHealth = 5000

-- Ammo Table, See T-1 Cunningham for Bodygroup Ammotable reference.
ENT.AmmoTypes = { 
						
						{
							PrintName = "105 mm T15E1 HE",
							Type = "sent_tank_shell",
							Delay = ENT.PrimaryDelay,
							Sound = ENT.ShootSound,
						};
						{
							PrintName = "105 mm T15E1 AP",
							Type = "sent_tank_apshell",
							Delay = ENT.PrimaryDelay,
							Sound = ENT.ShootSound,
						};

					
		};    
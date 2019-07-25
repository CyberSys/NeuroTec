-- This should be obvious, its this folders name.
ENT.FolderName = "sent_renaultft_p"
-- Used by hud stuff
ENT.Type = "vehicle"
-- base entity we derive from
ENT.Base = "base_anim"
-- Used by hud, menus etc.
ENT.PrintName	= "French Renault FT"
-- Your name goes here
ENT.Author	= "NeuroTec\nLua: hoffa and prof.heavy\nRipping: prof.heavy"
-- Tier / Category in spawn menu
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier I";
-- Used by info popup
ENT.Description = "WW2 Light Tank LEVEL 1"
-- duh
ENT.Spawnable	= true
ENT.AdminSpawnable = true
-- Used for collision and damage stuff
ENT.VehicleType = VEHICLE_TANK
ENT.TankType = TANK_TYPE_LIGHT
-- Adds binocular hud, UNUSED
ENT.HasBinoculars = true
-- This will hide the Tower Model, Used for Tank destroyers and such
ENT.HasTower = true
-- Determines if we'll use the variable ENT.SeatPos (Vector) or a default vector.
ENT.HasCockpit = true
-- Enables Machinegun Logic, Requires you to specify MachineGun Variables. See IS-7 for Reference.
ENT.HasMGun = false
-- Makes use of Bodygroup ammo system
ENT.HasParts = false
-- Play a grinding track sound when we move.
ENT.HasCVol = true
-- Length of traceline from tank Z pos to ground
ENT.TrackPos = -6.5

-- Virtual Crew positions
ENT.CrewPositions = {
Vector( 62, 4, 31 ),
Vector( 0, 2, 44 )
-- Vector( 14, 3, 53 )
}

-- This variable will make our physical wheels visible.
---ENT.DebugWheels = true
-- Wheel Z position
ENT.TankTrackZ = 14
-- Wheel Y position
ENT.TankTrackY = 20
-- Wheel X position
ENT.TankTrackX = 3
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number. Debug this with ENT.DebugWheels = true
ENT.TankNumWheels = 8
-- AngleVelocity to apply to wheels when turning
ENT.TankWheelTurnMultiplier = 222
-- AngleVelocity applied when going forward, this controls the acceleration and "horsepower"
ENT.TankWheelForceValFWD = 255
-- same as above but reverse
ENT.TankWheelForceValREV = 222
-- Adds a slight push to our tank when we start driving to simulate acceleration.
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 50
-- Where our track models will spawn relative to tank position.
ENT.TrackPositions = {Vector( 0,0,3),Vector( 0,0,3 )}
-- Models used.
ENT.TrackModels = { "models/renault/fttracks_r.mdl","models/renault/fttracks_l.mdl" }
-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/wot/american/m47patton/renaultft_track", 
							"models/wot/france/renaultft/renaultft_track_forward", 
							"models/wot/france/renaultft/renaultft_track_reverse" }

-- Will randomize skin on spawn if >1
ENT.SkinCount = 1
-- Smaller cannon, barrel machinegun
ENT.BarrelMGunPos = Vector( -14, 1, -4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- Camera Distance from tank
ENT.CamDist = 220
-- Camera Z position
ENT.CamUp = -5
-- Cockpit position relative to Barrel.
ENT.CockpitPosition = Vector( 3, 5, 10 )
-- Pilot Seat position
ENT.SeatPos = Vector( 0, 0, 0 )
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
ENT.PrimaryDelay = 4
-- AP Delay
ENT.APDelay = 4
-- Muzzleflash
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- Can be used in ENT.AmmoTable
ENT.MaxDamage = 300
ENT.MinDamage = 250
ENT.BlastRadius = 100

-- Body/Hull Model
ENT.Model = "models/renault/ftbody.mdl"
-- Tower Model
ENT.TowerModel = "models/renault/ftturret.mdl"
-- Tower Pos relative to body
ENT.TowerPos  = Vector( 25, 3, 54 )
-- Barrle model
ENT.BarrelModel = "models/renault/ftgun.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( 40, 0, 59 )
-- Adjust this if the muzzleflash looks off.
ENT.BarrelLength = 50
-- Machinegun Model
ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Relative to body
ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shootsound
ENT.MGunSound = Sound("wot/global/mgun.wav")

-- Turn Force
ENT.TurnMultiplier = 1.7959

-- Max velocity. 10 = slowsauce, 100 = Intergalactic travel
ENT.MaxVelocity = 21
-- Same, but reversed :P
ENT.MinVelocity = -10 //not specified in WoT wiki
-- Starting Health, Also used by the repairgun
ENT.InitialHealth = 1500

-- Ammo Table, See T-1 Cunningham for Bodygroup reference.
ENT.AmmoTypes = { 
						
						{
							PrintName = "Puteaux SA 18 L/21 HE",
							Type = "sent_tank_shell",
							Delay = ENT.PrimaryDelay,
							Sound = ENT.ShootSound,
						};
						{
							PrintName = "Puteaux SA 18 L/21 AP",
							Type = "sent_tank_apshell",
							Delay = ENT.PrimaryDelay,
							Sound = ENT.ShootSound,
						};

					
		};    
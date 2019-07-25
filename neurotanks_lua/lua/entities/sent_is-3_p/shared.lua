-- This should be obvious, its this folders name.
ENT.FolderName = "sent_is-3_p"
-- Used by hud stuff
ENT.Type = "vehicle"
-- base entity we derive from
ENT.Base = "base_anim"
-- Used by hud, menus etc.
ENT.PrintName	= "IS-3"
-- Your name goes here
ENT.Author	= "NeuroTec\nLua: hoffa and prof.heavy\nRipping: Killstr3aKs"
-- Tier / Category in spawn menu
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier VIII";
-- Used by info popup
ENT.Description = "WW2 Heavy Tank LEVEL 1"
-- duh
ENT.Spawnable	= true
ENT.AdminSpawnable = true
-- Used for collision and damage stuff
ENT.VehicleType = VEHICLE_TANK
ENT.TankType = TANK_TYPE_HEAVY
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
ENT.TrackPos = -5

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
ENT.TankTrackZ = 13
-- Wheel Y position
ENT.TankTrackY = 46
-- Wheel X position
ENT.TankTrackX = -35
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number.
ENT.TankNumWheels = 14
-- AngleVelocity to apply to wheels when turning
ENT.TankWheelTurnMultiplier = 355
-- AngleVelocity applied when going forward, this controls the acceleration and "horsepower"
ENT.TankWheelForceValFWD = 355
-- same as above but reverse
ENT.TankWheelForceValREV = 222
-- Adds a slight push to our tank when we start driving to simulate acceleration.
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	-90
-- Where our track models will spawn relative to tank position.
ENT.TrackPositions = {Vector( 0, 0 ,2),Vector( 0, 0 ,2 )}
-- Models used.
ENT.TrackModels = { "models/killstr3aks/wot/russian/is-3_tracks_r.mdl","models/killstr3aks/wot/russian/is-3_tracks_l.mdl"  }
ENT.TrackWheels = { "models/killstr3aks/wot/russian/is-3_wheels_l.mdl","models/killstr3aks/wot/russian/is-3_wheels_r.mdl" }

-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/is-3/kv-1s_track", 
							"models/killstr3aks/wot/russian/is-3/kv-1s_track_forward", 
							"models/killstr3aks/wot/russian/is-3/kv-1s_track_reverse" }

-- Will randomize skin on spawn if >1
ENT.SkinCount = 1
-- Smaller cannon, barrel machinegun
ENT.BarrelMGunPos = Vector( -16, 14.3, -1 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- Camera Distance from tank
ENT.CamDist = 280
-- Camera Z position
ENT.CamUp = 75
-- Cockpit position relative to Barrel.
ENT.CockpitPosition = Vector( 8, 15, 18 )
-- Pilot Seat position
ENT.SeatPos = Vector( 0, 0, 15 )
-- Pilto Seat Angle, change Pitch if model is outside tank.
ENT.SeatAngle = Vector( 0, 0, 0 )
-- Grinding noise if ENT.CVol is enabled.
ENT.TrackSound = "wot/is7/treads.wav"
-- Startup Sound
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- Engine Sounds, Table, add more sounds to create a mux.
ENT.EngineSounds = {"wot/is7/idle.wav"}
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
ENT.APDelay = 5
-- Muzzleflash
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- Can be used in ENT.AmmoTable
ENT.MaxDamage = 1900
ENT.MinDamage = 1250
ENT.BlastRadius = 512

-- Lamp Table
ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
-- Positions where to place headlight sprites and lamps
ENT.HeadLights.Pos = {Vector( 105, 27, 55 ),Vector( 105, 27, 55 ) }
-- Angle correction
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- Headlight Color
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- Used by env_projectedtexture to add a flickering noise
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = "" -- Custom Texture?
-- Body/Hull Model
ENT.Model = "models/killstr3aks/wot/russian/is-3_body.mdl"
-- Tower Model
ENT.TowerModel = "models/killstr3aks/wot/russian/is-3_turret.mdl"
-- Tower Pos relative to body
ENT.TowerPos  = Vector( 38, 0 , 59 )
-- Barrle model
ENT.BarrelModel = "models/killstr3aks/wot/russian/is-3_gun.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( 89, 0, 73 )
-- Adjust this if the muzzleflash looks off.
ENT.BarrelLength = 220
-- Machinegun Model
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
-- Relative to body
ENT.MGunPos = Vector( -20, -8, 100 ) 
-- Shootsound
ENT.MGunSound = Sound("wot/global/mgun.wav")

-- Max velocity. 10 = slowsauce, 100 = Intergalactic travel
ENT.MaxVelocity = 38
-- Same, but reversed :P
ENT.MinVelocity = -15
-- Starting Health, Also used by the repairgun
ENT.InitialHealth = 6000

-- Ammo Table, See T-1 Cunningham for Bodygroup Ammotable reference.

-- This should be obvious, its this folders name.
ENT.FolderName = "sent_crusader_p"
-- Used by hud stuff
ENT.Type = "vehicle"
-- base entity we derive from
ENT.Base = "base_anim"
-- Used by hud, menus etc.
ENT.PrintName	= "Crusader"
-- Your name goes here
ENT.Author	= "NeuroTec\nLua: hoffa and prof.heavy\nRipping: Killstr3aKs"
-- Tier / Category in spawn menu
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier V";
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
ENT.HasMGun = true
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
ENT.TankTrackY = 40
-- Wheel X position
ENT.TankTrackX = -30
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number. Debug this with ENT.DebugWheels = true
ENT.TankNumWheels = 12
-- AngleVelocity to apply to wheels when turning
ENT.TankWheelTurnMultiplier = 500
-- AngleVelocity applied when going forward, this controls the acceleration and "horsepower"
ENT.TankWheelForceValFWD = 255
-- same as above but reverse
ENT.TankWheelForceValREV = 222
-- Adds a slight push to our tank when we start driving to simulate acceleration.
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 50
-- Where our track models will spawn relative to tank position.
ENT.TrackPositions = {Vector( 0,1,3),Vector( 0,0,3 )}
-- Models used.
ENT.TrackModels = { "models/killstr3aks/wot/british/crusader_tracks_r.mdl","models/killstr3aks/wot/british/crusader_tracks_l.mdl" }
ENT.TrackWheels = { "models/killstr3aks/wot/british/crusader_wheels_l.mdl","models/killstr3aks/wot/british/crusader_wheels_r.mdl" }
-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/british/crusader/crusader_track", 
							"models/killstr3aks/wot/british/crusader/crusader_track_forward", 
							"models/killstr3aks/wot/british/crusader/crusader_track_reverse" }

-- Will randomize skin on spawn if >1
ENT.SkinCount = 1
-- Smaller cannon, barrel machinegun
ENT.BarrelMGunPos = Vector( -15, 7.12, -3.3 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- Camera Distance from tank
ENT.CamDist = 300
-- Camera Z position
ENT.CamUp = -2
-- Cockpit position relative to Barrel.
ENT.CockpitPosition = Vector( 3, 5, 10 )
-- Pilot Seat position
ENT.SeatPos = Vector( 0, 0, 15 )
-- Pilto Seat Angle, change Pitch if model is outside tank.
ENT.SeatAngle = Vector( 0, 0, 0 )
-- Grinding noise if ENT.CVol is enabled.
ENT.TrackSound = "wot/threads/medium_threads_fast.wav"
-- Startup Sound
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- Engine Sounds, Table, add more sounds to create a mux.
ENT.EngineSounds = {"wot/engines/light_tank_idle_00.wav"}
-- Delay before we can drive away.
ENT.StartupDelay = 1.0 -- Seconds
-- Tower Turn Stopping Sound
ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
-- Tower Moving Sound
ENT.SoundTower = "wot/tigeri/turret.wav"
-- Primary Shoot Sound
ENT.ShootSound = Sound("wot/cannons/71_kwk_l46_04.wav")
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
ENT.MaxDamage = 2500
ENT.MinDamage = 750
ENT.BlastRadius = 352

-- Body/Hull Model
ENT.Model = "models/killstr3aks/wot/british/crusader_body.mdl"
-- Tower Model
ENT.TowerModel = "models/killstr3aks/wot/british/crusader_turret.mdl"
-- Tower Pos relative to body
ENT.TowerPos  = Vector( 23 , 0 , 46 )
-- Barrle model
ENT.BarrelModel = "models/killstr3aks/wot/british/crusader_gun.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( 48.5 , 0 , 60 )
-- Adjust this if the muzzleflash looks off.
ENT.BarrelLength = 50
-- Machinegun Model
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
-- Relative to body
ENT.MGunPos = Vector( -0, 0, 60 ) 
-- Shootsound
ENT.MGunSound = Sound("wot/global/mgun.wav")

-- Turn Force
ENT.TurnMultiplier = 1.7959

-- Max velocity. 10 = slowsauce, 100 = Intergalactic travel
ENT.MaxVelocity = 40
-- Same, but reversed :P
ENT.MinVelocity = -10 //not specified in WoT wiki
-- Starting Health, Also used by the repairgun
ENT.InitialHealth = 3500

-- Ammo Table, See T-1 Cunningham for Bodygroup Ammotable reference.
ENT.AmmoStructure = {
                                                {  
                                                        Tower = 0,
                                                        Barrel = 0,
                                                        Ammo = {                                                                               
                                                                {
                                                                        PrintName = "QF 6-pdr Gun Mk. V HE",
                                                                        Type = "sent_tank_shell",
                                                                        MinDmg = 1000,
																		MaxDmg = 1500,
																		Radius = 128,
                                                                        Delay = ENT.PrimaryDelay,
                                                                        Sound = ENT.ShootSound,
                                                                };
																{
																		PrintName = "QF 6-pdr Gun Mk. V AP",
																		Type = "sent_tank_apshell",
																		MinDmg = 900,
																		MaxDmg = 1800,
																		Radius = 128,
																		Delay = ENT.APDelay,
																		Sound = ENT.ShootSound,
																};
                                                        };
                                                };
                                                
                                        };
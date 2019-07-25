-- This should be obvious, its this folders name.
ENT.FolderName = "sent_2k12_p"
-- Used by hud stuff
ENT.Type = "vehicle"
-- base entity we derive from
ENT.Base = "base_anim"
-- Used by hud, menus etc.
ENT.PrintName	= "2K12 Kub - DMCA by Bohemia Interactive send complaints to jay.crowe@bistudio.com"
-- Your name goes here
ENT.Author	= "NeuroTec\nLua: hoffa and prof.heavy\nRipping: Killstr3aKs"
-- Tier / Category in spawn menu
ENT.Category 		= "NeuroTec Ground Units";
-- Used by info popup
ENT.Description = "Mobile Ground-to-Air \n missile platform"
-- duh
ENT.Spawnable	= false
ENT.AdminSpawnable = false
-- Used for collision and damage stuff
ENT.VehicleType = VEHICLE_TANK
ENT.TankType = TANK_TYPE_AA
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
ENT.TrackPos = -5

-- Crew hit locations
ENT.CrewPositions = {
Vector( 69, -28, 47 ),
Vector( 73, 25, 47 ),
Vector( 12, 19, 58 )
}

-- This variable will make our physical wheels visible.
-- ENT.DebugWheels = true
-- Wheel Z position
ENT.TankTrackZ = 14
-- Wheel Y position
ENT.TankTrackY = 47
-- Wheel X position
ENT.TankTrackX = -25
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number.
ENT.TankNumWheels = 14
-- AngleVelocity to apply to wheels when turning
ENT.TankWheelTurnMultiplier = 222
-- AngleVelocity applied when going forward, this controls the acceleration and "horsepower"
ENT.TankWheelForceValFWD = 255
-- same as above but reverse
ENT.TankWheelForceValREV = 222
-- Adds a slight push to our tank when we start driving to simulate acceleration.
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	-90
-- Where our track models will spawn relative to tank position.
ENT.TrackPositions = {Vector( 0, 0 ,1),Vector( 0, 0 ,1 )}
-- Models used.
ENT.TrackModels = { "models/killstr3aks/wot/russian/2k12_kub_tracks_r.mdl","models/killstr3aks/wot/russian/2k12_kub_tracks_l.mdl"  }
ENT.TrackWheels = { "models/killstr3aks/wot/russian/2k12_kub_wheels_l.mdl","models/killstr3aks/wot/russian/2k12_kub_wheels_r.mdl" }

-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/2k12_kub/wheel_d", 
							"models/killstr3aks/wot/russian/2k12_kub/wheel_d_forward", 
							"models/killstr3aks/wot/russian/2k12_kub/wheel_d_reverse" }

-- Will randomize skin on spawn if >1
ENT.SkinCount = 1
-- Smaller cannon, barrel machinegun
// ENT.BarrelMGunPos = Vector( -14, -14.3, -4 )
// ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- Camera Distance from tank
ENT.CamDist = 280
-- Camera Z position
ENT.CamUp = 75
-- Cockpit position relative to Barrel.
ENT.CockpitPosition = Vector( 75, -11, 10 )
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
ENT.ShootSound = Sound("bf4/rockets/pods_rocket_engine_wave 2 0 0_2ch.wav")
-- Sound to play when tank is reloading
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
-- not necessary to use.
ENT.PrimaryAmmo = "sent_tank_300mm_rocket" 
-- Shoot delay
ENT.PrimaryDelay = 5
-- AP Delay
ENT.APDelay = 7
-- Muzzleflash
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- Can be used in ENT.AmmoTable
ENT.MaxDamage = 2500
ENT.MinDamage = 1200
ENT.BlastRadius = 512

ENT.BarrelPorts = { 
Vector( -50,-45,40 ), 
Vector( -50,0,40 ), 
Vector( -50,45,40 ) 
} -- add one vector for each slot/pod on the rocket launcher
-- Tied to ENT.BarrelPorts, need to have same number of models as vectors.
ENT.VisualShells = { 
"models/killstr3aks/wot/russian/9m336_missile_body.mdl",
"models/killstr3aks/wot/russian/9m336_missile_body.mdl",
"models/killstr3aks/wot/russian/9m336_missile_body.mdl" 
}

-- disable impact point prediction.
ENT.OverrideImpactPointPrediction = true
ENT.VehicleCrosshairType = 3
-- Also a requirement for these types of tanks.
ENT.IsAutoLoader = true
-- For something like a SCUD launcher this table would only have one index
ENT.MagazineSize = #ENT.BarrelPorts
ENT.RoundsPerSecond = 0.5

ENT.CustomMuzzle = "arty_muzzleflash"

-- Lamp Table
ENT.HeadLightsToggle = false
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
-- Positions where to place headlight sprites and lamps
ENT.HeadLights.Pos = { Vector( 117, -54, 57 ),Vector( 117, 63, 57 ) }
-- Angle correction
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- Headlight Color
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- Used by env_projectedtexture to add a flickering noise
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = "" -- Custom Texture?
-- Body/Hull Model
ENT.Model = "models/killstr3aks/wot/russian/2k12_kub_body.mdl"
-- Tower Model
ENT.TowerModel = "models/killstr3aks/wot/russian/2k12_kub_turret.mdl"
-- Tower Pos relative to body
ENT.TowerPos  = Vector( 37, 5 , 70 )
-- Barrle model
ENT.BarrelModel = "models/killstr3aks/wot/russian/2k12_kub_gun.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( -3, 5, 80 )
-- Adjust this if the muzzleflash looks off.
ENT.BarrelLength = 100
-- Machinegun Model
// ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- Relative to body
// ENT.MGunPos = Vector( -44, 0, 129 ) 
-- Shootsound
// ENT.MGunSound = Sound("wot/global/mgun.wav")


-- Max velocity. 10 = slowsauce, 100 = Intergalactic travel
ENT.MaxVelocity = 32
-- Same, but reversed :P
ENT.MinVelocity = -25
-- Starting Health, Also used by the repairgun
ENT.InitialHealth = 4000

-- Ammo Table, See T-1 Cunningham for Bodygroup Ammotable reference.
 
                                       
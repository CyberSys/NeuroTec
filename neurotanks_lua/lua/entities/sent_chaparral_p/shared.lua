-- This should be obvious, its this folders name.
ENT.FolderName = "sent_chaparral_p"
-- Used by hud stuff
ENT.Type = "vehicle"
-- base entity we derive from
ENT.Base = "base_anim"
-- Used by hud, menus etc.
ENT.PrintName	= "M48 Chaparral"
-- Your name goes here
ENT.Author	= "NeuroTec\nLua: hoffa and prof.heavy\nRipping: Killstr3aKs"
-- Tier / Category in spawn menu
ENT.Category 		= "NeuroTec - Anti-Air Vehicles";
-- Used by info popup
ENT.Description = "Mobile Anti-Air launcher"
-- duh
ENT.Spawnable	= true
ENT.AdminSpawnable = true
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

ENT.CanFloat = true
ENT.FloatRatio = 2.55
ENT.FloatBoost = 1000
-- Crew hit locations
-- ENT.CrewPositions = {
-- Vector( 69, -28, 47 ),
-- Vector( 73, 25, 47 ),
-- Vector( 12, 19, 58 )
-- }

-- This variable will make our physical wheels visible.
-- ENT.DebugWheels = true
-- Wheel Z position
ENT.TankTrackZ = 14
-- Wheel Y position
ENT.TankTrackY = 47
-- Wheel X position
ENT.TankTrackX = 5
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number.
ENT.TankNumWheels = 10
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
ENT.TrackModels = { "models/killstr3aks/wot/american/m48_chaparral_tracks_r.mdl","models/killstr3aks/wot/american/m48_chaparral_tracks_l.mdl"  }
-- ENT.TrackWheels = { "models/killstr3aks/wot/russian/2k12_kub_wheels_l.mdl","models/killstr3aks/wot/russian/2k12_kub_wheels_r.mdl" }

-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/american/m48_chaparral/m113a3_track_co", 
							"models/killstr3aks/wot/american/m48_chaparral/m113a3_track_co_forward", 
							"models/killstr3aks/wot/american/m48_chaparral/m113a3_track_co_reverse" }

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
ENT.SeatPos = Vector( 87, 40, 64 )
-- Pilto Seat Angle, change Pitch if model is outside tank.
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( -26, 0, 95 )
-- ENT.CopilotAngle = Angle( 0, -90, 0 )
-- ENT.CopilotFollowTurret = false
-- Grinding noise if ENT.CVol is enabled.
ENT.TrackSound = "wot/pershing/threads.wav"
-- Startup Sound
ENT.StartupSound = Sound( "vehicles/ural-truck/start.wav" )
ENT.EngineSounds = {"vehicles/ural-truck/idle_ural.wav"}
-- Delay before we can drive away.
ENT.StartupDelay = 1.0 -- Seconds
-- Tower Turn Stopping Sound
ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
-- Tower Moving Sound
ENT.SoundTower = "wot/tigeri/turret.wav"
-- Primary Shoot Sound
ENT.ShootSound = Sound("npc/turret_floor/shoot1.wav")
-- Sound to play when tank is reloading
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
-- not necessary to use.
ENT.PrimaryAmmo = "sent_tank_missile" 
-- Shoot delay
ENT.PrimaryDelay = 0.1
-- AP Delay
ENT.APDelay = 0.1
-- Muzzleflash
ENT.PrimaryEffect = ""


-- Can be used in ENT.AmmoTable
ENT.MaxDamage = 75
ENT.MinDamage = 35
ENT.BlastRadius = 64

-- ENT.BarrelPorts = { 
-- Vector( -25,-33.5,-13 ), 
-- Vector( -25,-33.5,12 ), 
-- Vector( -25,33.5,-13 ),
-- Vector( -25,33.5,12 )  
-- } -- add one vector for each slot/pod on the rocket launcher
-- Tied to ENT.BarrelPorts, need to have same number of models as vectors.
-- ENT.VisualShells = { 
-- "models/killstr3aks/wot/american/aa_missile_body.mdl",
-- "models/killstr3aks/wot/american/aa_missile_body.mdl",
-- "models/killstr3aks/wot/american/aa_missile_body.mdl",
-- "models/killstr3aks/wot/american/aa_missile_body.mdl"
-- }

-- disable impact point prediction.
ENT.OverrideImpactPointPrediction = true
ENT.VehicleCrosshairType = 3
-- Also a requirement for these types of tanks.
-- ENT.IsAutoLoader = true
-- For something like a SCUD launcher this table would only have one index
-- ENT.MagazineSize =  1#ENT.BarrelPorts
ENT.ForcedMagazineCount = 250
ENT.RoundsPerSecond = 0.7

ENT.CustomMuzzle = "arty_muzzleflash"

-- Lamp Table
ENT.HeadLightsToggle = false
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
-- Positions where to place headlight sprites and lamps
ENT.HeadLights.Pos = { Vector( 125, -48, 69 ),Vector( 125, 48, 69 ), Vector( 125, 37, 69 ), Vector( 125, -37, 69 ) }
-- Angle correction
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ),Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- Headlight Color
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- Used by env_projectedtexture to add a flickering noise
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = "" -- Custom Texture?

ENT.MicroTurretPositions = {Vector( 0, 0, 0 )}
ENT.MicroTurretModels = {  "models/props_junk/sawblade001a.mdl" }
ENT.MicroTurretAngles = { Angle( 0,0,0 ) }
ENT.MicroTurretEnt = "sent_chaparral_turret_p"


-- Body/Hull Model
ENT.Model = "models/killstr3aks/wot/american/m48_chaparral_body.mdl"
-- Tower Model
ENT.TowerModel = "models/aftokinito/wot/american/paladin_mgun_base.mdl"
-- ENT.TowerModel = 
-- Tower Pos relative to body
ENT.TowerPos  = Vector( 92, 40, 112 )
-- Barrle model
ENT.BarrelModel = "models/killstr3aks/wot/american/m1a1_mg.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( 97.5, 40, 120 )
-- Adjust this if the muzzleflash looks off.
ENT.BarrelLength = 32
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
 
                                       
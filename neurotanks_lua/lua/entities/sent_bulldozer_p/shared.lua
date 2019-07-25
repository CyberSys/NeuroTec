ENT.FolderName = "sent_bulldozer_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Bulldozer"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: StarChick971"
ENT.Category 		= "NeuroTec Ground Units";
ENT.Description = "Dozers gonna doze"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = false
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
-- ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 5.955

ENT.DebugWheels = true
ENT.WheelWeight = 3000

ENT.TankTrackZ = -25
ENT.TankTrackY = -30
ENT.TankTrackX = -30
ENT.TankNumWheels = 6

ENT.TankWheelTurnMultiplier = 555
ENT.TankWheelForceValFWD = 222
ENT.TankWheelForceValREV = 222


ENT.MaxBarrelPitch = 10

ENT.IsMineSweeper = true
ENT.MineDeployerPos = Vector( -58, 0, -30 )
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 250
ENT.CamUp = -50
ENT.CockpitPosition = Vector( -37, 0, 40 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -36, 0, 0 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

-- Thread sounds?
ENT.HasCVol = true
-- Ranges from 0.0 to 1.0
ENT.CVol = 0.8
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
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2700
ENT.MinDamage = 1400
ENT.BlastRadius = 156

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}





ENT.HeadLights.Pos = { 
	Vector( 52, -17, 12 ), 
	Vector( 52, 17, 12 ), 
	Vector( 42, -7, 43 ), 
	Vector( 42, 7, 43 ),
	Vector( -57, 6, 47 ),
	Vector( -57, -6, 47 )
	}
ENT.HeadLights.Angles = { 
	Angle( 0, 180, 0 ), 
	Angle( 0, 180, 0 ), 
	Angle( 25, 180, 0 ), 
	Angle( 25, 180, 0 ),   
	Angle( 25, 0, 0 ), 
	Angle( 25, 0, 0 )
	}
ENT.HeadLights.Colors = { 
	Color( 255, 255, 255, 255 ), 
	Color( 255, 255, 255, 255 ),
	Color( 255, 255, 255, 255 ),  
	Color( 255, 255, 255, 255 ),
 	Color( 255, 255, 255, 255 ),  
	Color( 255, 255, 255, 255 ) 
 }
ENT.HeadLightProjectionPattern = "mnomnomnomnomnomnomnomno"
-- ENT.HeadLightProjectionTexture = ""
-- If the tracks are a separate model we need these variables.
ENT.ComplexTracks = false
ENT.HideTrucks = true
ENT.CanAttack = false
ENT.AngleForceDirection = 10

ENT.VehicleCrosshairType = 5 -- 5 == nothing
ENT.TrackPos = -50
-- ENT.WheelPositions = {Vector( 0,28,-23 ),Vector( 0,-28,-23 )}
ENT.TrackPositions = {Vector( 0,28,-20 ),Vector( 0,-28,-20 )}
ENT.TrackModels = { 
						"models/works/bulldozer_track.mdl",
						"models/works/bulldozer_track.mdl"  
						}
						
ENT.TrackOffset = Vector( 0,0,0 )
						
-- ENT.TrackWheels = {  	"models/works/bulldozer_track.mdl",
						-- "models/works/bulldozer_track.mdl"   }
					
ENT.TrackAnimationOrder = { "models/bulldozer/single_track_chain", 
							"models/bulldozer/single_track_chaIN_FORWARD",
							"models/bulldozer/single_track_chain_reverse"
						}


ENT.Model = "models/works/bulldozer_body.mdl"
ENT.TowerModel = "models/props_junk/PopCan01a.mdl"
ENT.TowerPos  = Vector( 0, 0, 20 )
ENT.BarrelModel = "models/props_junk/PopCan01a.mdl"
ENT.BarrelPos = Vector( 0, 0, 0 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 15
-- Limit eye angles
-- ENT.LimitView = 0

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 11
ENT.MinVelocity = -11
ENT.Acceleration = 8

ENT.InitialHealth = 4500
ENT.HealthVal = nil
ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0


// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


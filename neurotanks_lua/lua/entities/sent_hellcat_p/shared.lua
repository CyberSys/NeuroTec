ENT.FolderName = "sent_hellcat_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "M18 Hellcat"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier VI";
ENT.Description = "WW2 Tank Destroyer LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = true
ENT.HasCVol = true
ENT.TrackPos = -6.75
ENT.HideDriver = true
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 58, -21, 50 ),
Vector( 57, 22, 48 ),
Vector( -37, 1, 46 )
}

ENT.TankTrackZ = 10
ENT.TankTrackY = 40
ENT.TankTrackX = -25
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 450
ENT.TankWheelForceValFWD = 490
ENT.TankWheelForceValREV = 490

ENT.SkinCount = 1
-- Camera stuff
ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( -20, 10, 20 )

ENT.MouseScale3rdPerson = 0.065
ENT.MouseScale1stPerson = 0.065
ENT.TurnMultiplier = 2.295
ENT.TurnMultiplierMoving = 0.45

ENT.ArmorThicknessFront = 0.35
ENT.ArmorThicknessSide = 0.35
ENT.ArmorThicknessRear = 0.35

-- ENT.StartAngleVelocity = 10

-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
-- ENT.TankRecoilAngleForce = 	0.1

ENT.CopilotPos = Vector( 0, 14, 50 )
ENT.CopilotAngle = Angle( 0, -90, 0 )
ENT.SeatPos = Vector( -12, -12, 5 )
ENT.SeatAngle = Angle( 0, 0, 0 )

ENT.CockpitSeatMoveWithTower = true

ENT.StartAngleVelocity = 5.5

-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = -15


ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
--ENT.MaxDamage = 1900
--ENT.MinDamage = 1250
--ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 92, -28, 48 ), Vector( 92, 28, 48 ) }
ENT.HeadLights.TPos = { Vector( -99, 45, 53 ),Vector( -99, -45, 53 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/american/m18_hellcat_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/m18_hellcat_turret.mdl"
ENT.TowerPos  = Vector( 3.5, 0, 53 )
ENT.TowerParts = { 1, 2 }

ENT.BarrelModel = "models/aftokinito/wot/american/m18_hellcat_gun.mdl"
ENT.BarrelParts = { 3, 7 }
ENT.BarrelOffset = true
ENT.BarrelPos = { Vector( 38.5, 0, 71.7 ), Vector( 45, 0, 68 ) }
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- If the tracks are a separate model we need these variables.

ENT.ComplexTracks = true

ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/american/m18_hellcat_tracks_l.mdl",
						"models/aftokinito/wot/american/m18_hellcat_tracks_r.mdl"  
						}
						
ENT.TrackOffset = Vector( 0,0,3 )
						
ENT.TrackWheels = { "models/aftokinito/wot/american/m18_hellcat_wheels_l.mdl",
					"models/aftokinito/wot/american/m18_hellcat_wheels_r.mdl" }
					
ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/m18_hellcat/grant_track", 
							"models/aftokinito/wot/american/m18_hellcat/grant_track_forward", 
							"models/aftokinito/wot/american/m18_hellcat/grant_track_reverse"	}

// Speed Limits
ENT.MaxVelocity = 72
ENT.MinVelocity = -20
ENT.Acceleration = 3

ENT.InitialHealth = 1300
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


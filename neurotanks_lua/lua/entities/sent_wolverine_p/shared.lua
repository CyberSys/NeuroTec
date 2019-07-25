ENT.FolderName = "sent_wolverine_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "M10 Wolverine"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier V";
ENT.Description = "WW2 Tank Destroyer LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasBarrelMGun = false
ENT.HasMGun = true
ENT.HasParts = true
ENT.HasCVol = true
ENT.TrackPos = -6.75
ENT.HideDriver = true

-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 44, -12, 55 ),
Vector( 36, 19, 55 ),
Vector( -13, 4, 35 )
};

ENT.TankTrackZ = 11
ENT.TankTrackY = 35
ENT.TankTrackX = -35
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 255
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.SkinCount = 1
-- Camera stuff
ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 3, 10, 20 )

ENT.SeatPos = Vector( -5, -12, 5 )
ENT.SeatAngle = Angle( 0, 0, 0 )
ENT.CockpitSeatMoveWithTower = true
ENT.StartAngleVelocity = 5.5
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = -100

-- Gunner pos
ENT.CopilotPos = Vector( -15, 12, 68 )
ENT.CopilotAngle = Angle( 0, 90, 0 )
-- ENT.StandByCoMGun = true -- Standing pose instead of sitting
ENT.CopilotWeightedSequence = ACT_DRIVE_JEEP

ENT.MGunModel = "models/l4d2_50cal_hack.mdl"
ENT.MGunPos = Vector( -41, 0, 110 )
ENT.MGunAng = Angle( 0, 180, 0 )
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

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
ENT.MaxDamage = 1900
ENT.MinDamage = 1250
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 83, -34, 59 ), Vector( 83, 34, 59 ) }
ENT.HeadLights.TPos = { Vector( -114, 36, 64 ), Vector( -114, -36, 64 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/american/wolverine_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/wolverine_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 67 )
ENT.TowerPart = 0
ENT.BarrelModel = "models/aftokinito/wot/american/wolverine_gun.mdl"
ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 45, 0, 80 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
-- If the tracks are a separate model we need these variables.
ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/american/wolverine_tracks_l.mdl","models/aftokinito/wot/american/wolverine_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/wolverine/grant_track", 
							"models/aftokinito/wot/american/wolverine/grant_track_forward", 
							"models/aftokinito/wot/american/wolverine/grant_track_reverse"	}
-- ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- ENT.MGunPos = Vector( -44, 0, 129 ) 
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 48
ENT.MinVelocity = -12
ENT.Acceleration = 1

ENT.InitialHealth = 4000
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


ENT.FolderName = "sent_zbd09_p"

ENT.CanFloat = true
ENT.FloatRatio = 4.55

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "ZBD-09"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Smithy285"
ENT.Category 		= "NeuroTec Tanks - Amphibious Vehicles";
ENT.Description = "Armored Combat Vehicle"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.CameraChaseTower = false
-- ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MaxBarrelPitch = 15
-- ENT.DebugWheels = true
ENT.VehicleCrosshairType = 3 -- BF3 Style Abrams Crosshair

-- Makes the copilot follow the tank rather than tower
ENT.CopilotFollowBody = true


ENT.CrewPositions = {
	Vector( 40, 10, 45 ),
	Vector( 39, -12, 44 ),
	Vector( -10, 19, 55 ),
	Vector( -12, -15, 53 )
}

ENT.WheelAngles = {
	Angle( 0, 180, 0 ),
	Angle( 0, 0, 0 ),

	Angle( 0, 180, 0 ),
	Angle( 0, 0, 0 ),

	Angle( 0, 180, 0 ),
	Angle( 0, 0, 0 ),
	
	Angle( 0, 180, 0 ),
	Angle( 0, 0, 0 )
}

ENT.WheelAxles = {
	Vector( 90, -57.5, -32 ), -- First ( Left )
	Vector( 90.53, 57, -32.47 ), -- First  ( Right )

	Vector( 35, -57.5, -32.44 ), -- Second ( Left )
	Vector( 34.93, 57, -31.16 ), -- Second  ( Right )

	Vector( -41.94, -57.5, -33.13 ), -- Third ( Left )
	Vector( -40.69, 57, -30.41 ), -- Third  ( Right )

	Vector( -97.32, -57.5, -33.1 ), -- Forth ( Left )
	Vector( -97.82, 57, -32.6 ), -- Forth  ( Right )
}

local zpos = 80
local xpos = 20

ENT.TubePos = { 
	Vector( xpos, 35, zpos ), 
	Vector( xpos, 31, zpos ), 
	Vector( xpos, 31, zpos ), 
	Vector( xpos-5, -22, zpos ), 
	Vector( xpos-5, -22, zpos ), 
	Vector( xpos-5, -22, zpos ), 
}

ENT.TubeAng = { 
	Angle( -25, 5, 0 ), 
	Angle( -25, 15, 0 ), 
	Angle( -25, 20, 0 ), 
	Angle( -21, -5, 0 ), 
	Angle( -21, -15, 0 ), 
	Angle( -21, -20, 0 ) 
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { { 1, -1 }, { 2, 1 }, { 3, -1 }, { 4, 1 }, { 5, -1 }, { 6, 1 }, { 7, -1 }, { 8, 1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2, 3, 4 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 260
ENT.RWDTorque = -135
ENT.MaxVelocity = 30
ENT.MinVelocity = -10
ENT.WheelMass = 5500 
ENT.WheelHubMass = 7500 
ENT.MaxSteeringVal = .31
ENT.DriveWheelMaxYaw = 30
-- ENT.Acceleration = 1
ENT.SteerForce	= 0.3000
ENT.WheelMdls = { 
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl",
	"models/vehicles/smithy285/bf3/zbd_09/wheel_2.mdl"
}

-- ENT.TankWheelTurnMultiplier = 350
-- ENT.TankWheelForceValFWD = 390
-- ENT.TankWheelForceValREV = 340

-- ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
-- ENT.TrackModels = { "models/aftokinito/wot/german/pziv_tracks_l.mdl","models/aftokinito/wot/german/pziv_tracks_r.mdl"  }
-- ENT.TrackAnimationOrder = { "models/aftokinito/wot/german/pzIV/hummel_track", 
							-- "models/aftokinito/wot/german/pzIV/hummel_track_forward", 
							-- "models/aftokinito/wot/german/pzIV/hummel_track_reverse" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( 5, 12.2, 0.5 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.CustomMuzzle = "AA_muzzleflash"

ENT.RecoilForce = 99

ENT.CamDist = 250
ENT.CamUp = 20
ENT.CockpitPosition = Vector( 18.31, -0.79, 5 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 37.93, -3.38, 17.25 )
ENT.SeatAngle = Vector( 0, 0, 0 )
--ENT.CopilotPos = Vector( 34.81, -18.25, 60.31 )
ENT.ChillSeatPositions = { }
ENT.ChillSeatAngles = { }

ENT.OverrideImpactPointPrediction = true
ENT.BulletSpread = Angle( .005,.005,.005 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf2/tanks/stryker_engine_startup.wav" )
ENT.EngineSounds = {"bf2/tanks/stryker_engine_01.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf2/tanks/t-90_shoot.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2000
ENT.MinDamage = 1250
ENT.BlastRadius = 128

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}

ENT.HeadLights.Pos = {
	Vector( 158.59, 25.18, 5.28 ), -- Front right
	Vector( 158.25, -26, 4.68 ), -- Front left
}

ENT.HeadLights.TPos = {
	Vector( -150.1, -50.44, -2.54 ), -- Back right
	Vector( -150.1, 49.59, -2.72 ) -- Back left
}

ENT.HeadLights.Angles = {
	Angle( 0, 180, 0 ),
	Angle( 0, 180, 0 ),
}

ENT.HeadLights.Colors = {
	Color( 255, 251, 230, 255 ),
	Color( 255, 255, 230, 255 ),
}

ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.ExhaustPosition = Vector( -136.35, -50.69, 32.68 )

ENT.Model = "models/vehicles/smithy285/bf3/zbd_09/body.mdl"
ENT.TowerModel = "models/vehicles/smithy285/bf3/zbd_09/turret.mdl"
ENT.TowerPos  = Vector( -55, 0, 45 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/vehicles/smithy285/bf3/zbd_09/barrel_2.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 34, 0, 41 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MicroTurretFollowParentTower = true

ENT.MicroTurretPositions = {
	Vector( -55, -15, 61 )
}

ENT.MicroTurretModels = {
	"models/vehicles/smithy285/bf3/zbd_09/50_cal_2.mdl"
}

ENT.MicroTurretAngles = {
	Angle( 0, 0, 0 )
}

ENT.MicroTurretAmmo = "sent_autocannon_shell"
ENT.MicroTurretDelay = 0.35
ENT.MicroTurretEnt = "sent_zbd09_miniturret_p"

// Speed Limits

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


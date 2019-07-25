ENT.FolderName = "sent_223_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "sdkfz 223"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: P Heavy"
ENT.Category 		= "NeuroTec Tanks - Cars?";
ENT.Description = "Armored Car"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
-- ENT.SkinCount = 1
ENT.TrackPos = -6.95
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 40, 10, 45 ),
Vector( 39, -12, 44 ),
Vector( -10, 19, 55 ),
Vector( -12, -15, 53 )
};

-- ENT.TankTrackZ = 12
-- ENT.TankTrackY = 44
-- ENT.TankTrackX = -40
-- ENT.TankNumWheels = 4
ENT.WheelAngles = {
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
}
ENT.WheelAxles = {
-- front axle
Vector( 67, -39, 7 ),
Vector( 67, 39, 7 ),
-- rear axle
Vector( -42, -39, 7 ),
Vector( -42, 39, 7 )
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { {1, 1 }, {2, -1 },  { 3, 1 }, { 4, -1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2 }

ENT.WheelMass = 30000 
ENT.WheelHubMass = 32500 

-- ENT.WheelTorque = 152 -- units/m^2
ENT.FWDTorque = 155
ENT.RWDTorque = -155
ENT.MaxVelocity = 30
ENT.MinVelocity = -25
ENT.SteerForce	= 10
ENT.MaxSteeringVal = 30
ENT.DriveWheelMaxYaw = 35
-- ENT.MaxSteeringVal = 55.66
-- ENT.SteerForce	= 10

ENT.WheelMdls = { 
"models/sdkfz222/sdkfz222_wheel.mdl",
"models/sdkfz222/sdkfz222_wheel.mdl",
"models/sdkfz222/sdkfz222_wheel.mdl",
"models/sdkfz222/sdkfz222_wheel.mdl"
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
ENT.BarrelMGunPos = Vector( 5, 12.2, 0.5 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
ENT.CustomMuzzle = "AA_muzzleflash"
ENT.RecoilForce = 9999999/2

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 25, 5, 15 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector(15, 0, 5 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "kumagames/20mm.wav" )
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.15
ENT.APDelay = 0.15
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.IsAutoLoader = false
ENT.MagazineSize = 50
ENT.RoundsPerSecond = 5
ENT.MaxDamage = 5
ENT.MinDamage = 5
ENT.BlastRadius = 32
ENT.ForcedMagazineCount = 500 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 89, -25, 37 ), Vector( 89, 27, 36 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/sdkfz222/sdkfz222body.mdl"
ENT.TowerModel = "models/sdkfz222/sdkfz222turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 55.5 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 0, 0, 50 )
ENT.BarrelLength = 120
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/props_c17/furnitureDrawer001a_Shard01.mdl"
ENT.MGunPos = Vector( 0, 0, 30 )
ENT.CMGunPos = Vector(0,0,0)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

-- // Speed Limits

-- ENT.Acceleration = 1

ENT.InitialHealth = 2000
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


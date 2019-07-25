ENT.FolderName = "sent_brdm-2_p"

ENT.CanFloat = true
ENT.FloatRatio = 4.55

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "MAKESHIFT BRDM-2"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Amphibious Vehicles";
ENT.Description = "Armored Combat Vehicle"
ENT.Spawnable	= true -- thanks BI
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.CameraChaseTower = true
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
};

-- ENT.TankTrackZ = 12
-- ENT.TankTrackY = 44
-- ENT.TankTrackX = -40
-- ENT.TankNumWheels = 4
ENT.WheelAngles = {
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 )
}
ENT.WheelAxles = {
-- front axles
Vector( 50, -42, 21 ),
Vector( 50, 42, 21 ),
-- rear axles
Vector( -77, -42, 21 ),
Vector( -77, 42, 21 ),
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { { 1, -1 }, { 2, 1 }, { 3, -1 }, { 4, 1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 160
ENT.RWDTorque = -135
ENT.MaxVelocity = 30
ENT.MinVelocity = -10
ENT.WheelMass = 5500 
ENT.WheelHubMass = 7500 
ENT.MaxSteeringVal = 4
ENT.DriveWheelMaxYaw = 30
-- ENT.Acceleration = 1
ENT.SteerForce	= 5
ENT.WheelMdls = { 
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl"
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
ENT.CockpitPosition = Vector( 15, 10, 5 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector(50, 13, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 50, -13, 35 )
ENT.ChillSeatPositions = { Vector( -35, -11, 35 ) , Vector( -35, 11, 35 ) , Vector( -10, 9, 48 ) }
ENT.ChillSeatAngles = { Angle( 0,-90,0 ) , Angle( 0,-90,0 ) , Angle( 0,-90,5 ) }

ENT.OverrideImpactPointPrediction = true
ENT.BulletSpread = Angle( .005,.005,.005 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf2/tanks/stryker_engine_startup.wav" )
ENT.EngineSounds = {"bf2/tanks/stryker_engine_01.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/cannons/25mm_bushmaster.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = .3
ENT.APDelay = 5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 200
ENT.MinDamage = 100
ENT.BlastRadius = 100
ENT.ForcedMagazineCount = 300 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 96, -37, 65 ), Vector( 96, 37, 65 ), Vector( 96, -25, 67 ), Vector( 96, 25, 67 )}
ENT.HeadLights.TPos = { Vector( -130, -42, 70 ), Vector( -130, 42, 70 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 230, 255 ), Color( 255, 255, 230, 255 ),  Color( 255, 255, 230, 255 ), Color( 255, 255, 230, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.ExhaustPosition = Vector( -134, -35, 70 ), Vector( -15, 48, 60 )

ENT.Model = "models/killstr3aks/wot/russian/btr-80_body.mdl"
ENT.TowerModel = "models/aftokinito/neurotanks/french/ebr-75_turret.mdl"
ENT.TowerPos  = Vector( -25, 0, 74 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/neurotanks/french/ebr-75_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 1, 0, 91 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
-- ENT.MGunPos = Vector( -15, -32.7, 94 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("bf4/misc/mg_fire.wav")

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


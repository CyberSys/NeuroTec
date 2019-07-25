ENT.FolderName = "sent_btr-80_p"

ENT.CanFloat = true
ENT.FloatRatio = 4.0

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "BTR-80"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
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
ENT.CameraChaseTower = true
-- ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MaxBarrelPitch = 15
-- ENT.DebugWheels = true
ENT.VehicleCrosshairType = 2 -- BF3 Style Abrams Crosshair
ENT.OverrideImpactPointPrediction = true

local zpos = 80
local xpos = 15
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
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 )
}
ENT.WheelAxles = {
-- front axles
Vector( 89, -45, 23 ),
Vector( 89, 52, 23 ),
Vector( 33, -46, 23 ),
Vector( 33, 50, 23 ),
-- rear axles
Vector( -38.5, -47, 23 ),
Vector( -38.5, 50, 23 ),
Vector( -94.5, -48, 23 ),
Vector( -94.5, 50, 23 )
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { /*{ 1, -1 }, { 2, 1 },*/  { 3, -1 }, { 4, 1 }, { 5, -1 }, { 6, 1 },  { 7, -1 }, { 8, 1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2, 3, 4 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 110
ENT.RWDTorque = -90
ENT.MaxVelocity = 42
ENT.MinVelocity = -20
ENT.WheelMass = 5500 
ENT.WheelHubMass = 7500 
ENT.DriveWheelMaxYaw = 44
-- ENT.Acceleration = 1
ENT.MaxSteeringVal = 0.15
ENT.SteerForce	= 0.52
ENT.WheelMdls = { 
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
"models/killstr3aks/wot/russian/btr-80_wheels_l.mdl",
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
ENT.BarrelMGunPos = Vector( 5, 12.2, 0.5 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
ENT.CustomMuzzle = "mg_muzzleflash"
ENT.RecoilForce = 99

ENT.CamDist = 330
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 25, 25, 15 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector(-35, 0, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf4/engines/mrap_start_idle_stop_wave 0 0 0_1ch.wav" )
ENT.EngineSounds = {"bf4/engines/mrap_start_idle_stop_wave 0 0 1_1ch.wav"}
ENT.ShutDownSound = "bf4/engines/mrap_start_idle_stop_wave 0 0 2_1ch.wav"
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/cannons/bushmaster_fire_close_wave 0 0 0_2ch.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = .1
ENT.APDelay = .1
ENT.PrimaryEffect = "ChopperMuzzleFlash"
ENT.BulletSpread = Angle( .005,.0011,.0011 )

-- ENT.IsAutoLoader = true
-- ENT.MagazineSize = 40
-- ENT.RoundsPerSecond = 8
ENT.ReloadSound1 = ""
ENT.ReloadSound2 = Sound("bf4/cannons/into_tow_us_wave 0 0 0_2ch.wav")
ENT.ForcedMagazineCount = 1500 -- override weight class based ammo count

// Weapons
ENT.MaxDamage = 155
ENT.MinDamage = 15
ENT.BlastRadius = 128


ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 100, -12, 85 ), Vector( 100, -12, 85 )}
ENT.HeadLights.TPos = { Vector( -149, -31, 68 ), Vector( -149, 31, 68 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/russian/btr-80_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/btr-80_turret.mdl"
ENT.TowerPos  = Vector( 39, 3.5, 75 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/btr-80_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 28, 2.5, 103 )
ENT.BarrelLength = 162
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
-- ENT.MGunPos = Vector( -15, -32.7, 94 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

// Speed Limits

ENT.InitialHealth = 3500
ENT.HealthVal = nil
ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 100
ENT.DeathTimer = 0


// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


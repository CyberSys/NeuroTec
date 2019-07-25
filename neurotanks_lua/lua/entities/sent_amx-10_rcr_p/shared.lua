ENT.FolderName = "sent_amx-10_rcr_p"

ENT.CanFloat = true
ENT.FloatRatio = 5.55
ENT.FloatBoost = -170
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "AMX-10 RCR"
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
ENT.HasFLIR = true
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
Angle( 0, 	0, 0 ),
Angle( 0, -180, 0 ),
Angle( 0, 0, 0 ),
Angle( 0, -180, 0 ),
Angle( 0, 0, 0 ),
Angle( 0, -180, 0 )
}
ENT.WheelAxles = {
-- front axles
Vector( 64, -45, 25 ),
Vector( 64, 45, 25),
-- rear axles
Vector( 0, -45, 25 ),
Vector( 0, 45, 25 ),
Vector( -65, -45, 25 ),
Vector( -65, 45, 25 )
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { /*{ 1, -1 }, { 2, 1 },*/  { 3, -1 }, { 4, 1 }, { 5, -1 }, { 6, 1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2 }
-- ENT.MaxSteeringVal = 45
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = -120
ENT.RWDTorque = 90
ENT.MaxVelocity = 60
ENT.MinVelocity = -30
ENT.WheelMass = 5500 
ENT.WheelHubMass = 7500 
ENT.DriveWheelMaxYaw = 30
-- ENT.Acceleration = 1
ENT.SteerForce	= 500000
ENT.WheelMdls = { 
"models/killstr3aks/wot/french/amx-10_rcr_wheels_l.mdl",
"models/killstr3aks/wot/french/amx-10_rcr_wheels_l.mdl",
"models/killstr3aks/wot/french/amx-10_rcr_wheels_l.mdl",
"models/killstr3aks/wot/french/amx-10_rcr_wheels_l.mdl",
"models/killstr3aks/wot/french/amx-10_rcr_wheels_l.mdl",
"models/killstr3aks/wot/french/amx-10_rcr_wheels_l.mdl"
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
ENT.BarrelMGunPos = Vector( -25, 7.5, -2.2 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"
ENT.CustomMuzzle = "tank_muzzleflash"
ENT.RecoilForce = 99

ENT.CamDist = 300
ENT.CamUp = 10
ENT.CockpitPosition = Vector( 25, 15, 5 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector(-35, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf4/engines/amx-10_startup.wav" )
ENT.EngineSounds = {"bf4/engines/amx-10_engine.wav"}
ENT.StartupDelay = 1.6 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/cannons/125mm_cannon_fire.wav" )
ENT.ReloadSound = Sound("bf4/cannons/120mm_cannon_reload.wav")
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 5
ENT.PrimaryEffect = "ChopperMuzzleFlash"



// Weapons
ENT.MaxDamage = 2000
ENT.MinDamage = 1200
ENT.BlastRadius = 256
ENT.ForcedMagazineCount = 30 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 93, -47, 64 ), Vector( 93, 47, 64 )}
ENT.HeadLights.TPos = { Vector( -127, -43, 64 ), Vector( -127, 43, 64 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 230, 255 ), Color( 255, 255, 230, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.ExhaustPosition = Vector( -15, -48, 60 )

ENT.Model = "models/killstr3aks/wot/french/amx-10_rcr_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/french/amx-10_rcr_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 64 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/french/amx-10_rcr_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 56, 0, 80 )
ENT.BarrelLength = 162
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
ENT.MGunPos = Vector( -15, -32.7, 94 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("bf2/weapons/KORD_fire_1p.mp3")

// Speed Limits

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


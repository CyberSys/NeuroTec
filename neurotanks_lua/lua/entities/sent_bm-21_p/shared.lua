ENT.FolderName = "sent_bm-21_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "BM-21 GRAD"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Multiple Rocket Launching System"
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
-- ENT.DebugWheels = true
-- ENT.VehicleCrosshairType = 2 -- BF3 Style Abrams Crosshair

ENT.ArtyView = true

ENT.CrewPositions = {
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
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
}
ENT.WheelAxles = {
-- front axle
Vector( 88, -40, 15 ),
Vector( 88, 39, 15 ),
-- rear axle
Vector( -48, -40, 15 ),
Vector( -48, 39, 15 ),
Vector( -102, -40, 15 ),
Vector( -102, 39, 15 )
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = {  { 3, 1 }, { 4, -1 },{ 5, 1 }, { 6, -1 } } -- { 1, 1 }, { 2, -1 },
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 105
ENT.RWDTorque = -105
ENT.MaxVelocity = 42
ENT.MinVelocity = -42
ENT.WheelMass = 6000 
ENT.WheelHubMass = 8500 
ENT.MaxSteeringVal = 2
ENT.SteerForce	= 2000
-- ENT.Acceleration = 1
-- ENT.SteerForce	= 5
ENT.WheelMdls = { 
"models/killstr3aks/wot/russian/bm-21_grad_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-21_grad_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-21_grad_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-21_grad_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-21_grad_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-21_grad_wheels_l.mdl"
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
ENT.RecoilForce = -99

ENT.BarrelPorts = { 
Vector( -30,-45,20 ), 
Vector( -30,-35,20 ), 
Vector( -30,-25,20 ), 
Vector( -30,-15,20 ),
Vector( -30,-5,20 ),
Vector( -30,5,20 ),
Vector( -30,15,20 ), 
Vector( -30,25,20 ),
Vector( -30,35,20 ), 
Vector( -30,45,20 )
}

ENT.CamDist = 250
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 40, 20, 50 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 40, 17, 45 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 40, -18, 45 )
ENT.CopilotFollowBody = true

ENT.TrackSound = ""
ENT.StartupSound = Sound( "vehicles/ural-truck/start.wav" )
ENT.EngineSounds = {"vehicles/ural-truck/idle_ural.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/rockets/projectile_missile_engine_wave 0 0 0_1ch.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.5
ENT.APDelay = 0.5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.IsAutoLoader = true
ENT.MagazineSize = 20
ENT.RoundsPerSecond = 3
ENT.MaxDamage = 500
ENT.MinDamage = 500
ENT.BlastRadius = 512
ENT.ForcedMagazineCount = 100 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 130, -29, 44 ), Vector( 130, 27, 44 )}
ENT.HeadLights.TPos = { Vector( -135, -37, 30 ), Vector( -135, 37, 30 ),Vector( 58, -12.5, 97 ), Vector( 59, -1, 98 ),Vector( 58, 10.5, 97 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""
ENT.ExhaustPosition = Vector( 0, 0, 0 )

ENT.Model = "models/killstr3aks/wot/russian/bm-21_grad_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/bm-21_grad_turret.mdl"
ENT.TowerPos  = Vector( -80, 0, 52 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/bm-21_grad_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( -110, 1.2, 56 )
ENT.BarrelLength = 120
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
ENT.MGunPos = Vector( -15, -32.7, 94 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

// Speed Limits

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


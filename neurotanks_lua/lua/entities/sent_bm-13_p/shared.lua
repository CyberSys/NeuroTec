ENT.FolderName = "sent_bm-13_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "BM-13 Katyusha"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Multiple Rocket Launching System"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.CameraChaseTower = false
-- ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MaxBarrelPitch = 30
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
Vector( 89, -32, 15 ),
Vector( 89, 27, 15 ),
-- rear axle
Vector( -35, -32, 15 ),
Vector( -35, 27, 15 ),
Vector( -70, -32, 15 ),
Vector( -70, 27, 15 )
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
ENT.MaxSteeringVal = 0.5
ENT.SteerForce	= 205200
-- ENT.Acceleration = 1
-- ENT.SteerForce	= 5
ENT.WheelMdls = { 
"models/killstr3aks/wot/russian/bm-13_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-13_wheels_l.mdl",
"models/killstr3aks/wot/russian/bm-13_wheels_r.mdl",
"models/killstr3aks/wot/russian/bm-13_wheels_r.mdl",
"models/killstr3aks/wot/russian/bm-13_wheels_r.mdl",
"models/killstr3aks/wot/russian/bm-13_wheels_r.mdl",
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
Vector( -47,-38.2,25.4 ), 
Vector( -47,-27.2,25.4 ), 
Vector( -47,-16.2,25.4 ), 
Vector( -47,-5.3,25.4 ),
Vector( -47,5.3,25.4 ),
Vector( -47,16.5,25.4 ),
Vector( -47,27.6,25.4 ), 
Vector( -47,38.2,25.4 ),
Vector( -47,-38.2,35 ), 
Vector( -47,-27.2,35 ), 
Vector( -47,-16.2,35 ), 
Vector( -47,-5.3,35 ),
Vector( -47,5.3,35 ),
Vector( -47,16.5,35 ),
Vector( -47,27.6,35 ), 
Vector( -47,38.2,35 )
}

ENT.VisualShells = {
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl"
}

ENT.CamDist = 250
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 40, 20, 50 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 20, 5, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 40, -18, 45 )
-- ENT.CopilotFollowBody = true

ENT.TrackSound = ""
ENT.StartupSound = Sound( "vehicles/ural-truck/start.wav" )
ENT.EngineSounds = {"vehicles/ural-truck/idle_ural.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/rockets/katyusha_rocket.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 1
ENT.APDelay = 0.5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.IsAutoLoader = true
ENT.MagazineSize = 16
ENT.RoundsPerSecond = 3.5
ENT.MaxDamage = 750
ENT.MinDamage = 500
ENT.BlastRadius = 724
ENT.ForcedMagazineCount = 160 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 100, -19, 40 ), Vector( 100, 15, 40 )}
ENT.HeadLights.TPos = { Vector( -99, -2, 33 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""
ENT.ExhaustPosition = Vector( -11, 37, 15 )

ENT.Model = "models/killstr3aks/wot/russian/bm-13_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/bm-13_turret.mdl"
ENT.TowerPos  = Vector( -49, -2, 36 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/bm-13_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( -77, -2, 51 )
ENT.BarrelLength = 120
ENT.MaxBarrelYaw = 0 -- Only works if HasTower is set to false

ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
ENT.MGunPos = Vector( -15, -32.7, 94 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

// Speed Limits

ENT.InitialHealth = 1500
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


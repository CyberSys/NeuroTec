ENT.FolderName = "sent_stryker_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_ARTILLERY
ENT.Base = "base_anim"
ENT.PrintName	= "SCUD Launcher"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Mobile Launch Platform"
ENT.Spawnable	= true -- thanks BI
ENT.AdminSpawnable = true
ENT.VehicleType = TANK_TYPE_ARTILLERY
ENT.IsArtillery = false
ENT.ArtyView = true
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.CameraChaseTower = false
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MaxBarrelPitch = 15
ENT.DebugWheels = true
ENT.VehicleCrosshairType = 5 -- BF3 Style Abrams Crosshair

ENT.CrewPositions = {
Vector( 40, 10, 45 ),
Vector( 39, -12, 44 ),
Vector( -10, 19, 55 ),
Vector( -12, -15, 53 )
};

-- hide real tower,
ENT.HasTower = false
ENT.BarrelPorts = { Vector( 225, 0, 47 )}
-- ENT.VisualShells = { "models/hawx/weapons/bgm-109 tomahawk.mdl"}
ENT.VisualShells = { "models/aftokinito/neurotanks/russian/scud_scud.mdl"}
ENT.IsAutoLoader = true
ENT.MagazineSize = #ENT.BarrelPorts
ENT.RoundsPerSecond = 0.1

ENT.IsScudLauncher = true

ENT.CustomMuzzle = "AA_muzzleflash"

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
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),

}
local wheelX = 70
ENT.WheelAxles = {
-- front axles
Vector( 155, wheelX, -50 ),
Vector( 155, -wheelX, -50 ),
Vector( 66, wheelX, -50 ),
Vector( 66, -wheelX, -50 ),
Vector( -88, wheelX, -50 ),
Vector( -88, -wheelX, -50 ),
Vector( -176, wheelX, -50 ),
Vector( -176, -wheelX, -50 )
}
ENT.TowerTurnVolume = 1.0
ENT.ChillSeats = {Vector( 180, -55, -3 ), Vector( 180, 55, -3 )}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { { 1, 1 }, { 2, -1 },  { 3, 1 }, { 4, -1 }, { 5, 1 }, { 6, -1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2, 3, 4 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 88
ENT.RWDTorque = -88
ENT.MaxVelocity = 25
ENT.MinVelocity = -22
ENT.WheelMass = 3500 
ENT.WheelHubMass = 13500 
ENT.DriveWheelMaxYaw = 30
-- ENT.Acceleration = 1
ENT.MaxSteeringVal = 0.1
ENT.SteerForce	= 829
ENT.WheelMdls = { 
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl",
"models/aftokinito/neurotanks/russian/scud_wheel.mdl"
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
ENT.RecoilForce = 9999999/1.2
ENT.CamLocalToTank = true

ENT.CamDist = 500
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 306, 70, 45 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 222, 55, -2 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 222, -55, -2 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf2/tanks/stryker_engine_startup.wav" )
ENT.EngineSounds = {"bf2/tanks/stryker_engine_01.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/misc/scud_fire.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 15
ENT.APDelay = 15
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 12000
ENT.MinDamage = 5250
ENT.BlastRadius = 2424
-- ENT.ForcedMagazineCount = 300 -- override weight class based ammo count
ENT.ExhaustPosition = Vector( 173, -99, 15 )

-- Afto, just increase this variable if you want automagic reloads of SCUDs.
ENT.ForcedMagazineCount = 10

-- ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { 
Vector( 265, -68, -0 ),
Vector( 274, -70, -16 ),
Vector( 274, -60, -16 ),
Vector( 274, 62, -16 ),
Vector( 274, 73, -16 ),
Vector( 267, 70, 1 )
}

ENT.HeadLights.Angles = { 
Angle( 0, 180, 0 ), 
Angle( 0, 180, 0 ), 
Angle( 0, 180, 0 ), 
Angle( 0, 180, 0 ), 
Angle( 0, 180, 0 ), 
Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { 
Color( 255, 251, 143, 255 ), 
Color( 255, 251, 143, 255 ), 
Color( 255, 251, 143, 255 ), 
Color( 255, 251, 143, 255 ), 
Color( 255, 251, 143, 255 ), 
Color( 255, 251, 143, 255 ) }

ENT.HeadLights.TPos = {
Vector( -250, 78, -11 ),
Vector( -254, 73, -6 ),
Vector( -254, 63, -4 ),
Vector( -254, -57, -5 ),
Vector( -253, -69, -6 ),
Vector( -251, -74, -12 )}


ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/neurotanks/russian/scud_body.mdl"
ENT.TowerModel = "models/aftokinito/neurotanks/russian/scud_launcherback.mdl"
ENT.TowerPos  = Vector( -250, 0, 0 )
--ENT.TowerPart = 1
-- ENT.BarrelModel = "models/aftokinito/neurotanks/russian/scud_launcher.mdl"
ENT.BarrelModel =  "models/aftokinito/neurotanks/russian/scud_launcherback.mdl"
--ENT.BarrelPart = 0
ENT.MaxBarrelYaw = 0

ENT.BarrelPos = Vector( -250, 0, 0 )
ENT.BarrelLength = 362
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
ENT.MGunPos = Vector( -15, -32.7, 94 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

// Speed Limits

ENT.InitialHealth = 3500
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


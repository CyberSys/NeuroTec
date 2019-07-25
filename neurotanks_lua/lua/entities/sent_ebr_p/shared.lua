ENT.FolderName = "sent_stryker_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "Panhard EBR"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Cars?";
ENT.Description = "DONOR Tactical Patience Killer"
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
ENT.VehicleCrosshairType = 2 
local zpos = 80
local xpos = 15
ENT.TubePos = { 
Vector( xpos, 35, zpos )*0.75, 
Vector( xpos, 31, zpos )*0.75, 
Vector( xpos, 31, zpos )*0.75, 
Vector( xpos-5, -22, zpos )*0.75, 
Vector( xpos-5, -22, zpos )*0.75, 
Vector( xpos-5, -22, zpos )*0.75, 
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
Vector( 72, 18, 6 )*0.75,
Vector( 67, -20, 6 )*0.75,
Vector( -63, -13, -3 )*0.75,
Vector( -63, 26, -3 )*0.75

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
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 )
}
local wheelx = 60
ENT.WheelAxles = {
Vector( 128, wheelx, -31 )*0.75,
Vector( 128, -wheelx, -31 )*0.75,
Vector( 43, wheelx, -31 )*0.75,
Vector( 43, -wheelx, -31 )*0.75,
Vector( -40, wheelx, -31 )*0.75,
Vector( -40, -wheelx, -31 )*0.75,
Vector( -124, wheelx, -31 )*0.75,
Vector( -124, -wheelx, -31 )*0.75,
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { { 1, -1 }, { 2, 1 },  { 3, 1 }, { 4, -1 }, { 5, 1 }, { 6, -1 },  { 7, 1 }, { 8, -1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2, 7, 8 }
ENT.SteerOrderDirections = { 1, 1, -1, -1 }


ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 110
ENT.RWDTorque = -100
ENT.MaxVelocity = 85
ENT.MinVelocity = -42
ENT.WheelMass = 7500
ENT.WheelHubMass = 14750
ENT.DriveWheelMaxYaw = 45

-- ENT.Acceleration = 1
-- ENT.SteerForce	= 50000
ENT.SteerForce	= 185200
-- ENT.Se = 10000000
ENT.WheelMdls = { 
"models/aftokinito/neurotanks/french/ebr-75_wheel1.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel1.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel2.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel2.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel2.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel2.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel1.mdl",
"models/aftokinito/neurotanks/french/ebr-75_wheel1.mdl"}

ENT.RecoilForce = 9999999/1.2

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 25, 25, 15 )*0.75
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector(-35, 0, 5 )*0.75
ENT.SeatAngle = Vector( 0, 0, 0 )*0.75
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf2/tanks/stryker_engine_startup.wav" )
ENT.EngineSounds = {"bf2/tanks/stryker_engine_01.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf2/tanks/t-90_shoot.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 3
ENT.APDelay = 3
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2000
ENT.MinDamage = 1250
ENT.BlastRadius = 128

ENT.IsAutoLoader = true
ENT.MagazineSize = 6
ENT.RoundsPerSecond = 0.5


-- ENT.ForcedMagazineCount = 300 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 145, -20, 9 )*0.75, Vector( 142, 21, 9 )*0.75 }
-- ENT.HeadLights.TPos = { Vector( -128, -31, 41 ), Vector( -128, 44, 41 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/neurotanks/french/ebr-75_body.mdl"
ENT.TowerModel = "models/aftokinito/neurotanks/french/ebr-75_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 24.5 )*0.75
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/neurotanks/french/ebr-75_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 0.8, 0, 46)
ENT.BarrelLength = 162
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
ENT.MaxBarrelPitch = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
-- ENT.MGunPos = Vector( -15, -32.7, 94 )*0.75
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

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


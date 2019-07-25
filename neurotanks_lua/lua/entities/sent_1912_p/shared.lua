ENT.FolderName = "sent_1912_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "Military Truck MY1912"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Cars?";
ENT.Description = "Troop Transport"
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
-- ENT.DebugWheels = true
ENT.VehicleCrosshairType = 5 -- BF3 Style Abrams Crosshair

ENT.ArtyView = false

ENT.WheelAngles = {
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 )
}
ENT.WheelAxles = {
Vector( 77, 44, 4 ),
Vector( 77, -44, 4 ),
Vector( 10, 44, 4 ),
Vector( 10, -44, 4 ),
Vector( -106, 44, 4 ),
Vector( -106, -44, 4 )
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = {  { 1, 1 }, { 2, -1 }, { 3, 1 }, { 4, -1 },{ 5, 1 }, { 6, -1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2 } --, 3, 4 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 125
ENT.RWDTorque = -125
ENT.MaxVelocity = 50
ENT.MinVelocity = -32
ENT.WheelMass = 6000 
ENT.WheelHubMass = 8500 
ENT.MaxSteeringVal = 0.45
ENT.SteerForce	= 535520
ENT.DriveWheelMaxYaw = 35
-- ENT.Acceleration = 1
-- ENT.SteerForce	= 5
ENT.WheelMdls = { 
"models/aftokinito/neurotanks/german/l912_wheel1.mdl",
"models/aftokinito/neurotanks/german/l912_wheel1.mdl",
"models/aftokinito/neurotanks/german/l912_wheel1.mdl",
"models/aftokinito/neurotanks/german/l912_wheel1.mdl",
"models/aftokinito/neurotanks/german/l912_wheel1.mdl",
"models/aftokinito/neurotanks/german/l912_wheel1.mdl"
}

ENT.RecoilForce = -99

ENT.BarrelPorts = { Vector( 66,0,16 ) }

ENT.CamDist = 550
ENT.CamUp = 60
ENT.CockpitPosition = Vector( -10, 20, 20 )

ENT.SeatPos = Vector( 113, 32, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 113, -32, 30 )
ENT.CopilotFollowBody = true
	
ENT.OverrideImpactPointPrediction = true
ENT.BulletSpread = Angle( .005,.0011,.0011 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "vehicles/ural-truck/start.wav" )
ENT.EngineSounds = {"vehicles/ural-truck/idle_ural.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "kumagames/20mm.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.15
ENT.APDelay = 0.15
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
-- ENT.IsAutoLoader = true
-- ENT.MagazineSize = 50
-- ENT.RoundsPerSecond = 5
ENT.MaxDamage = 35
ENT.MinDamage = 15
ENT.BlastRadius = 32
ENT.ForcedMagazineCount = 500 -- override weight class based ammo count

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

ENT.Model = "models/aftokinito/neurotanks/german/l912_body5.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/paladin_mgun_base.mdl"
ENT.TowerPos  = Vector( 115, 0, 82 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 115, 0, 82 )
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


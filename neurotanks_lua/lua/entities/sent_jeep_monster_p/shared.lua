ENT.FolderName = "sent_jeep_monster_p"

ENT.CanFloat = true
ENT.FloatRatio = 4.55
ENT.InitialHealth = 1500

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_CAR
ENT.Base = "base_anim"
ENT.PrintName	= "Jeep Monster"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Cars?";
ENT.Description = "It´s a monster D:"
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
ENT.VehicleCrosshairType = 3 -- BF3 Style Abrams Crosshair

-- Makes the copilot follow the tank rather than tower
ENT.CopilotFollowBody = true


-- ENT.CrewPositions = {
-- Vector( 40, 10, 45 ),
-- Vector( 39, -12, 44 ),
-- Vector( -10, 19, 55 ),
-- Vector( -12, -15, 53 )
-- };

ENT.WheelAngles = {
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 ),
Angle( 0, 180, 0 ),
Angle( 0, -0, 0 )
}
ENT.WheelAxles = {
-- front axles
Vector( 65, -38, 10 ),
Vector( 65, 38, 10 ),
-- rear axles
Vector( -56, -40, 5 ),
Vector( -56, 40, 5 ),
}

-- This might be a bit confusing but this is the Index of the WheelAxles table.
-- This would make WheelAxle[3] and [4] be the driving wheels. 
-- the 1 or -1 controls direction of wheel travel
ENT.DriveOrder = { { 1, -1 }, { 2, 1 }, { 3, -1 }, { 4, 1 } } -- 
-- wheels that turn, also WheelAxle index, this means entry 1 and 2 will be our steering wheels
ENT.SteerOrder = { 1, 2 }
ENT.WheelTorque = 1 -- units/m^2
ENT.FWDTorque = 88
ENT.RWDTorque = -75
ENT.MaxVelocity = 35
ENT.MinVelocity = -20
ENT.WheelMass = 15000 
ENT.WheelHubMass = 15000 
ENT.MaxSteeringVal = 3.0
ENT.DriveWheelMaxYaw = 40
ENT.SteerForce	= 150000
ENT.WheelMdls = { 
"models/killstr3aks/wot/american/m142_wheels_l.mdl",
"models/killstr3aks/wot/american/m142_wheels_l.mdl",
"models/killstr3aks/wot/american/m142_wheels_l.mdl",
"models/killstr3aks/wot/american/m142_wheels_l.mdl"
-- "models/aftokinito/neurotanks/german/l912_wheel1.mdl",
-- "models/aftokinito/neurotanks/german/l912_wheel1.mdl",
-- "models/aftokinito/neurotanks/german/l912_wheel1.mdl",
-- "models/aftokinito/neurotanks/german/l912_wheel1.mdl"
-- "models/aftokinito/neurotanks/russian/scud_wheel.mdl",
-- "models/aftokinito/neurotanks/russian/scud_wheel.mdl",
-- "models/aftokinito/neurotanks/russian/scud_wheel.mdl",
-- "models/aftokinito/neurotanks/russian/scud_wheel.mdl"
}

ENT.RecoilForce = 99
ENT.CamDist = 200
ENT.CamUp = 0
ENT.CockpitPosition = Vector( 15, 10, 5 )
ENT.SeatPos = Vector(0, 18, 23 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 0, -18, 23 )
ENT.ChillSeatPositions = { Vector( -50, -11, 25 ) , Vector( -50, 11, 25 )}
ENT.ChillSeatAngles = { Angle( 0,-90,0 ) , Angle( 0,-90,0 ) }
ENT.OverrideImpactPointPrediction = true
ENT.BulletSpread = Angle( .005,.005,.005 )
ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf4/engines/jeep_startup.wav" )
ENT.EngineSounds = {"bf4/engines/jeep_engine.wav"}
ENT.StartupDelay = 2.5 -- Seconds
ENT.TowerStopSound = "bf4/engines/jeep_stop.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/rockets/tow_rocket.wav" )
ENT.ReloadSound = Sound("bf4/rockets/tow_reload.wav")
ENT.PrimaryAmmo = "sent_tank_rocket" 
ENT.PrimaryDelay = 8
ENT.PrimaryEffect = "ChopperMuzzleFlash"
ENT.MaxDamage = 2000
ENT.MinDamage = 1000
ENT.BlastRadius = 128
ENT.ForcedMagazineCount = 15 -- override weight class based ammo count
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 81, -21, 39 ), Vector( 81, 21, 39 )}
ENT.HeadLights.TPos = { Vector( -81, -32, 34 ), Vector( -81, 32, 34 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 230, 255 ), Color( 255, 255, 230, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""
ENT.ExhaustPosition = Vector( -80, -35, 20 )
ENT.Model = "models/killstr3aks/wot/american/jeep_tow_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/american/jeep_tow_turret.mdl"
ENT.TowerPos  = Vector( -26, -27, 66 )
ENT.BarrelModel = "models/killstr3aks/wot/american/jeep_tow_gun.mdl"
ENT.BarrelPos = Vector( -26, -21.5, 76 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
ENT.MGunSound = Sound("bf4/misc/mg_fire.wav")


ENT.FolderName = "sent_mcccxxxvii_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "The Great IckyKreuzerIIZ"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3akS"
ENT.Category 		= "NeuroTec Tanks - Icky's Palace";
ENT.Description = "WW4 Palace Holder LEVEL 5000"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasBarrelMGun = true
-- ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
-- ENT.HasCMGun = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95

ENT.ArtyView = true

ENT.HugeDeathExplosion = true

ENT.ExitPos = Vector( -6, 63, 790 )

ENT.CrewPositions = {
Vector( 80, 1, 64 ),
Vector( 106, 24, 45 ),
Vector( 103, -24, 46 ),
Vector( -0, -3, 61 )
}
-- ENT.DebugWheels = true

ENT.TankTrackZ = 140
ENT.TankTrackY = 450
ENT.TankTrackX = -350
ENT.TankNumWheels = 18
ENT.TankWheelRadius = 150
ENT.TankWheelSpace = 300
ENT.BarrelPorts = { 
Vector( 736, -126, 3 ),
Vector( 735, -1, 4 ),
Vector( 735, 125, 4 )
 }
ENT.IsUltraSlow = true
ENT.TurnMultiplier = 0.32
ENT.NoRecoil = true
ENT.CameraChaseTower = true

ENT.TankWheelTurnMultiplier = 1
ENT.TankWheelForceValFWD = 7400
ENT.TankWheelForceValREV = 6400
-- ENT.BarrelMGunPos = Vector( -0, -17, 79 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")
-- ENT.HasStaticSecondaryGuns = true
-- ENT.StaticGunPositions = { Vector( -39, -43.5, 20.4 )}
-- ENT.StaticGunAngles = { Angle( 0, 180, 0 ) }
-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
-- ENT.StaticGunCooldown = 0.115
ENT.MouseScale3rdPerson = 0.035
ENT.MouseScale1stPerson = 0.035		
ENT.MicroTurretPositions = {
Vector( 760, 300, 910 ), 
Vector( -1152, 424, 783 ), 
Vector( -1152, -424, 783 ), 
Vector( 838, -494, 783 ) 
}
ENT.MicroTurretModels = { "models/aftokinito/wot/russian/t28_turret_s.mdl",
"models/aftokinito/wot/russian/t28_turret_s.mdl",
"models/aftokinito/wot/russian/t28_turret_s.mdl",
"models/aftokinito/wot/russian/t28_turret_s.mdl" }
ENT.MicroTurretAngles = { Angle( 0,0,0 ),Angle( 0,180,0 ),Angle( 0,180,0 ), Angle( 0,0,0 ) }
ENT.MicroTurretAmmo = "sent_tank_shell"
ENT.MicroTurretDelay = 1.0
ENT.MicroTurretEnt = "sent_ratte_turret"

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { 
"models/killstr3aks/wot/german/p1000_ratte_tracks_l.mdl",
"models/killstr3aks/wot/german/p1000_ratte_tracks_r.mdl"  
}
ENT.TrackWheels = { 
"models/killstr3aks/wot/german/p1000_ratte_wheels_l.mdl",
"models/killstr3aks/wot/german/p1000_ratte_wheels_r.mdl"  
}
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/german/p1000_ratte/maus_track", 
							"models/killstr3aks/wot/german/p1000_ratte/maus_track_forward", 
							"models/killstr3aks/wot/german/p1000_ratte/maus_track_reverse"	}
-- ENT.VehicleCrosshairType = 3

ENT.CamDist = 2280
ENT.CamUp = 250
ENT.CockpitPosition = Vector( 5, 17, 10 )

ENT.SeatPos = Vector( 760, 300, 735 )
ENT.SeatAngle = Vector( 90, 0, 0 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 3
ENT.APDelay = 3
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 15500
ENT.MinDamage = 12300
ENT.BlastRadius = 2512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
local headlightdist = 1290
ENT.HeadLights.Pos = { 
Vector( headlightdist, -523, 667 ),
Vector( headlightdist, -504, 667 ),
Vector( headlightdist, -491, 667 ),
Vector( headlightdist, -487, 667 ),
Vector( headlightdist, 474, 668 ),
Vector( headlightdist, 488, 668 ),
Vector( headlightdist, 502, 668 ),
Vector( headlightdist, 507, 668 )
 };
 
ENT.HeadLights.TPos = {
Vector( -1460, 507, 579 ),
Vector( -1460, 496, 579 ),
Vector( -1460, 475, 579 ),
Vector( -1460, 464, 579 )
}
ENT.HeadLights.Angles = { 
Angle( -20, 180, 0 ), 
Angle( -15, 180, 0 ), 
Angle( -10, 180, 0 ),
Angle( -5, 180, 0 ), 
Angle( -5, 180, 0 ), 
Angle( -10, 180, 0 ),
Angle( -15, 180, 0 ), 
Angle( -20, 180, 0 ),
}
ENT.HeadLights.Colors = { 
Color( 255, 255, 255, 255 ), 
Color( 255, 255, 255, 255 ),
Color( 255, 255, 255, 255 ), 
Color( 255, 255, 255, 255 ),
Color( 255, 255, 255, 255 ), 
Color( 255, 255, 255, 255 ), 
Color( 255, 255, 255, 255 ), 
Color( 255, 255, 255, 255 )
 }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/german/p1000_ratte_body.mdl"
ENT.TowerModel = "models/battleships/yamato/yamato_mainturret.mdl"
ENT.TowerPos  = Vector( 760, 300, 735 )
ENT.BarrelModel = "models/battleships/yamato/yamato_mainturret_cannon.mdl"
ENT.BarrelPos = Vector( 950, 300, 820.5 )
ENT.BarrelLength = 950

ENT.CustomMuzzle = "arty_muzzleflash"

// Speed Limits
ENT.MaxVelocity = 500
ENT.MinVelocity = 10

ENT.InitialHealth = 125000
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


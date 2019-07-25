ENT.FolderName = "sent_kv-6_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "KV-6 Behemoth"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nCreation: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier X";
ENT.Description = "WW2 Premium Super Heavy Tank LEVEL 5"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasBarrelMGun = false
-- ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
-- ENT.HasCMGun = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MaxBarrelPitch = 15
ENT.MaxBarrelYaw = 150

ENT.CrewPositions = {
Vector( 180, 0, 80 ),
Vector( 250, 24, 45 ),
Vector( 250, -24, 46 ),
Vector( 30, 20, 150 )
-- Vector( 30, -20, 150 ),
-- Vector( -180, 0, 80 )
}
-- ENT.DebugWheels = true

ENT.TankTrackZ = 14
ENT.TankTrackY = 50
ENT.TankTrackX = -45
ENT.TankNumWheels = 30

ENT.TankWheelTurnMultiplier = 0
ENT.TankWheelForceValFWD = 300
ENT.TankWheelForceValREV = 240
ENT.IsUltraSlow = true
ENT.TurnMultiplier = 0.7

-- ENT.BarrelMGunPos = Vector( -0, -17, 79 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")
-- ENT.HasStaticSecondaryGuns = true
-- ENT.StaticGunPositions = { Vector( -39, -43.5, 20.4 )}
-- ENT.StaticGunAngles = { Angle( 0, 180, 0 ) }
-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
-- ENT.StaticGunCooldown = 0.115
ENT.CameraChaseTower = true
ENT.MicroTurretUseOwnHealth = true
ENT.MicroTurretPositions = {Vector( 40, 0, 70 ), Vector( -180, 0, 70 )}
ENT.MicroTurretModels = { "models/killstr3aks/wot/russian/kv-6_bigturret.mdl"}
ENT.MicroTurretAngles = { Angle( 0,0,0 ), Angle( 0,0,0 ) }
ENT.MicroTurretAmmo = "sent_artillery_shell"
ENT.MicroTurretDelay = 0.35
ENT.MicroTurretEnt = {"sent_kv-6_bigturret_p", "sent_kv-6_medturret_p"}

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/killstr3aks/wot/russian/kv-6_tracks_l.mdl","models/killstr3aks/wot/russian/kv-6_tracks_r.mdl"  }
ENT.TrackWheels = { "models/killstr3aks/wot/russian/kv-6_wheels_l.mdl","models/killstr3aks/wot/russian/kv-6_wheels_r.mdl"  }
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/kv-6/kv-1s_track", 
							"models/killstr3aks/wot/russian/kv-6/kv-1s_track_forward", 
							"models/killstr3aks/wot/russian/kv-6/kv-1s_track_reverse"	}
-- ENT.VehicleCrosshairType = 3

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 15, 17, 10 )

ENT.SeatPos = Vector( 170, 0, 30 )
ENT.SeatAngle = Vector( 90, 0, 0 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "wot/engines/kv-6_startup.wav" )
ENT.EngineSounds = {"wot/engines/kv-6_engine.wav"}
ENT.StartupDelay = 1.2 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/cannons/main_gun_85-107mm.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 6
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1500
ENT.MinDamage = 1300
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 270, -23, 62 ),Vector( 270, -23, 62 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/russian/kv-6.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/kv-6_midturret.mdl"
ENT.TowerPos  = Vector( 170, 0, 70.5 )
ENT.BarrelModel = "models/killstr3aks/wot/russian/kv-6_midgun.mdl"
ENT.BarrelPos = Vector( 210, 0, 85.5 )
ENT.BarrelLength = 100

// Speed Limits
ENT.MaxVelocity = 15
ENT.MinVelocity = -10

ENT.InitialHealth = 25000
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


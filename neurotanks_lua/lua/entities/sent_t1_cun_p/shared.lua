ENT.FolderName = "sent_t1_cun_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "T1 Cunningham"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier I";
ENT.Description = "WW2 Light Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasBarrelMGun = true
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( -8, -0, 50 ),
Vector( -36, -2, 42 )
}
ENT.TankTrackZ = 14
ENT.TankTrackY = 30	
ENT.TankTrackX = -35
ENT.TankNumWheels = 8

ENT.TurnMultiplier = 2.35

ENT.TankWheelTurnMultiplier = 250
ENT.TankWheelForceValFWD = 570
ENT.TankWheelForceValREV = 570

-- ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
-- ENT.HasCMGun = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MuzzleScale = 0.85
ENT.BurstSize = 4
-- ENT.BurstFire = true 
ENT.BurstCooldown = 0.25
-- ENT.BarrelMGunPos = Vector( -0, -17, 79 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")
-- ENT.HasStaticSecondaryGuns = true
-- ENT.StaticGunPositions = { Vector( -39, -43.5, 20.4 )}
-- ENT.StaticGunAngles = { Angle( 0, 180, 0 ) }
-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
-- ENT.StaticGunCooldown = 0.115

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/american/t1_cunningham_tracks_l.mdl","models/aftokinito/wot/american/t1_cunningham_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/t1_cunningham/t1_cunningham_track", 
							"models/aftokinito/wot/american/t1_cunningham/t1_cunningham_track_reverse", 
							"models/aftokinito/wot/american/t1_cunningham/t1_cunningham_track_forward"	}
-- ENT.VehicleCrosshairType = 3

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 5, 17, 10 )

ENT.SeatPos = Vector( -29, 0, 10 )
ENT.SeatAngle = Vector( 90, 0, 0 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.BurstSound = Sound("wot/t1_cun/burst.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.1
ENT.NonBurstDelay = 4
ENT.APDelay = 0.25
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 250
ENT.MinDamage = 50
ENT.BlastRadius = 250

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 100, -35, 57 ),Vector( 100, 35, 57 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/american/t1_cunningham_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/t1_cunningham_turret.mdl"
ENT.TowerPos  = Vector( -29, 0, 57 )
ENT.BarrelModel = "models/aftokinito/wot/american/t1_cunningham_gun.mdl"
ENT.BarrelPos = Vector( -8, -7, 66 )
ENT.BarrelLength = 100

// Speed Limits
ENT.MaxVelocity = 41
ENT.MinVelocity = -10
ENT.Acceleration = 2

ENT.InitialHealth = 1200
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


ENT.FolderName = "sent_t34-85_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "T-34-85"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier VI";
ENT.Description = "WW2 Medium Tank LEVEL 1"
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
-- Vector( 98, -21, 46 )
ENT.CrewPositions = {
Vector( 73, 16, 47 ),
Vector( 86, -13, 36 ),
Vector( -18, -0, 63 )
}
ENT.FlamethrowerPos = Vector( 98, -21, 46 )
ENT.FlamethrowerAng = Angle( -8, 180, 0 )
ENT.FlamethrowerMdl = "models/weapons/w_smg1.mdl"
ENT.FlamethrowerParticle = "flamethrower_initial"

-- ENT.DebugWheels = true

ENT.TankTrackZ = 12
ENT.TankTrackY = 46
ENT.TankTrackX = -25
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 400
ENT.TankWheelForceValFWD = 300
ENT.TankWheelForceValREV = 222

-- ENT.BarrelMGunPos = Vector( -0, -17, 79 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")
-- ENT.HasStaticSecondaryGuns = true
-- ENT.StaticGunPositions = { Vector( -39, -43.5, 20.4 )}
-- ENT.StaticGunAngles = { Angle( 0, 180, 0 ) }
-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
-- ENT.StaticGunCooldown = 0.115

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/russian/t34-85_tracks_l.mdl","models/aftokinito/wot/russian/t34-85_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/russian/t34-85/t-34_track", 
							"models/aftokinito/wot/russian/t34-85/t-34_track_forward", 
							"models/aftokinito/wot/russian/t34-85/t-34_track_reverse"	}
-- ENT.VehicleCrosshairType = 3

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 5, 17, 10 )

ENT.SeatPos = Vector( 35, 0, 39 )
ENT.SeatAngle = Vector( 0, 0, 90 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1500
ENT.MinDamage = 1300
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 100, -35, 57 ),Vector( 100, 35, 57 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/russian/t34-85_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/russian/t34-85_turret.mdl"
ENT.TowerPos  = Vector( 35, 0, 58 )
ENT.BarrelModel = "models/aftokinito/wot/russian/t34-85_gun.mdl"
ENT.BarrelPos = Vector( 75, 0, 72.5 )
ENT.BarrelLength = 100
ENT.StartAngleVelocity = 1.5
// Speed Limits
ENT.MaxVelocity = 54
ENT.MinVelocity = -20
ENT.Acceleration = 1

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


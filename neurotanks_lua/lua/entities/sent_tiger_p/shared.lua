ENT.FolderName = "sent_tiger_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Panzerkampfwagen Tiger I"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: beat the zombie\nModel Adaption: Aftokinito \n Help: Sillirion"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier VI";
ENT.Description = "WW2 Premium Heavy Tank (Flamethrower)"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.HasParts = true
ENT.HasCVol = true

ENT.CrewPositions = {
Vector( 64, 22, 55 ),
Vector( 61, -29, 56 ),
Vector( -24, 2, 65 ),
Vector( -72, 2, 52 )
}
ENT.FlamethrowerPos = Vector( 91, -22, 60 )
ENT.FlamethrowerAng = Angle( -8, 180, 0 )
ENT.FlamethrowerMdl = "models/weapons/w_smg1.mdl"
ENT.FlamethrowerParticle = "flamethrower_initial"

-- ENT.DebugWheels = true

ENT.TankTrackZ = 12
ENT.TankTrackY = 60
ENT.TankTrackX = -25
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 200
ENT.TankWheelForceValFWD = 435
ENT.TankWheelForceValREV = 435


ENT.MouseScale3rdPerson = 0.055
ENT.MouseScale1stPerson = 0.045
ENT.TurnMultiplier = 1.15
ENT.TurnMultiplierMoving = 0.45

ENT.ArmorThicknessFront = 0.25
ENT.ArmorThicknessSide = 0.25
ENT.ArmorThicknessRear = 0.55

ENT.StartAngleVelocity = 2.5
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	25

ENT.TrackPos = -6.75

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/beat the zombie/wot/german/tiger_i_tracks_l.mdl","models/beat the zombie/wot/german/tiger_i_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/german/tracks/pzvi_tiger_i_track", 
							"models/beat the zombie/wot/german/tracks/pzvi_tiger_i_track_forward", 
							"models/beat the zombie/wot/german/tracks/pzvi_tiger_i_track_reverse"	}

ENT.SkinCount = 12
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -14, -14.3, -4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 5, 10, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 15 )
ENT.SeatAngle = Vector( -5, 0, 0 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.ShutDownSound = "vehicles/airboat/fan_motor_shut_off1.wav"
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1900
ENT.MinDamage = 1250
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 9, 0, 59 ), Vector( 52, -31, 45 ), Vector( 52, 31, 45 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/beat the zombie/wot/german/tiger_i_body.mdl"
ENT.TowerModel = "models/beat the zombie/wot/german/tiger_i_turret.mdl"
ENT.TowerPos  = Vector( -5, 0, 65 )
ENT.TowerPart = 0
ENT.BarrelModel = "models/beat the zombie/wot/german/tiger_i_gun.mdl"
ENT.BarrelPart = 4
ENT.BarrelPos = Vector( 43, 1, 80 )
ENT.BarrelLength = 75
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, 0, 69 ) 
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 15
ENT.MinVelocity = -8 //not specified in WoT wiki
ENT.Acceleration = 0

ENT.InitialHealth = 6000
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



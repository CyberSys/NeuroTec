ENT.FolderName = "sent_m4a3e2shermanjumbo_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "M4A3E2 Sherman Jumbo"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier VI";
ENT.Description = "WW2 Medium Tank LEVEL 3"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -11.95
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 50, 10, 37 ),
Vector( 58, -14, 37 ),
Vector( 13, 1, 55 ),
Vector( -26, -5, 46 )
}
-- Vector( 76, -17, 38 )
ENT.FlamethrowerPos = Vector( 76, -17, 38 )
ENT.FlamethrowerAng = Angle( -8, 180, 0 )
ENT.FlamethrowerMdl = "models/weapons/w_smg1.mdl"
ENT.FlamethrowerParticle = "flamethrower_initial"

	
ENT.TankTrackZ = 2
ENT.TankTrackY = 35
ENT.TankTrackX = -44
ENT.TankNumWheels = 12
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( -10,-4,-12 ),Vector( -10,-4,-12 )}
ENT.TrackModels = { 
						"models/professorheavy/m4a3e8 sherman/m4e8tracks_l.mdl",
						"models/professorheavy/m4a3e8 sherman/m4e8tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/professorheavy/m4a3e8 sherman/m4e8wheels_l.mdl",
					"models/professorheavy/m4a3e8 sherman/m4e8wheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/wot/american/shermanjumbo/Sherman_Jumbo_track", 
							"models/wot/american/shermanjumbo/Sherman_Jumbo_track_forward", 
							"models/wot/american/shermanjumbo/Sherman_Jumbo_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -6, 18, 12 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 10, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 4
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1950
ENT.MinDamage = 1250
ENT.BlastRadius = 612

ENT.Model = "models/professorheavy/m4a3e2 sherman jumbo/m4e2body.mdl"
ENT.TowerModel = "models/professorheavy/m4a3e2 sherman jumbo/m4e2turret.mdl"
ENT.TowerPos  = Vector( -2, 0, 53 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/m4a3e8 sherman/m4e8gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 25, -3, 60 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, -1.25, 65 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 35
ENT.MinVelocity = -15
ENT.Acceleration = 5

ENT.InitialHealth = 5000
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


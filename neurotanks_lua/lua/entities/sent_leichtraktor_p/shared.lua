ENT.FolderName = "sent_leichtraktor_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "LTraktor"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: beat the zombie\nModel Adaption: Jake/Sillirion"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier I";
ENT.Description = "WW2 Light Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 22, 19, 50 ),
Vector( -27, -2, 52 )
}
ENT.TankTrackZ = 12
ENT.TankTrackY = 35
ENT.TankTrackX = -30
ENT.TankNumWheels = 8

ENT.TankWheelTurnMultiplier = 50
ENT.TankWheelForceValFWD = 800
ENT.TankWheelForceValREV = 800


ENT.MaxRange = 12000					
ENT.TrackPositions = {Vector( 0,0,5 ),Vector( 0,0,5 )}
ENT.TrackModels = { 
						"models/beat the zombie/wot/leichtraktor/ltraktortracks_l.mdl",
						"models/beat the zombie/wot/leichtraktor/ltraktortracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/leichtraktor/ltraktor_track", 
							"models/beat the zombie/wot/leichtraktor/ltraktor_track_forward", 
							"models/beat the zombie/wot/leichtraktor/ltraktor_track_reverse"	}


ENT.BurstFire = true
ENT.BurstSize = 5

ENT.SkinCount = 1
ENT.TrackPos = 2

ENT.CamDist = 250
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 0, -5, 10 )
ENT.SeatPos = Vector( -30, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.35
ENT.PrimaryEffect = "ChopperMuzzleFlash"

ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 9, 0, 59 ), Vector( 52, -31, 45 ), Vector( 52, 31, 45 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.BarrelMuzzleReferencePos = Vector( 21, 2.6, 0 )
ENT.ExhaustPosition = Vector( -56, -33, 50 ) 

ENT.Model = "models/beat the zombie/wot/leichtraktor/leichtraktor_body.mdl"
ENT.TowerModel = "models/beat the zombie/wot/leichtraktor/leichtraktor_tower.mdl"
ENT.TowerPos  = Vector( -36, 3, 53 )
ENT.BarrelModel = "models/beat the zombie/wot/leichtraktor/leichtraktor_gun.mdl"
ENT.BarrelPos = Vector( -8, 4, 68 )
ENT.BarrelLength = 90

ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
ENT.MGunPos = Vector( -44, 0, 129 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

// Speed Limits
ENT.MaxVelocity = 36
ENT.MinVelocity = -10 //not specified in WoT wiki

ENT.InitialHealth = 1500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 350
ENT.MinDamage = 150
ENT.BlastRadius = 128

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


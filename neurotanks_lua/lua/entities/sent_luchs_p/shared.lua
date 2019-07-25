ENT.FolderName = "sent_luchs_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "PzKpfw II Luchs"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: beat the zombie\nModel Adaption: Jake/Sillirion"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier IV";
ENT.Description = "WW2 Light Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
-- ENT.DebugWheels = true
ENT.CrewPositions = { Vector( 30, 15, 52 ),Vector( -19, -7, 54 )}
ENT.TankTrackZ = 11
ENT.TankTrackY = 35
ENT.TankTrackX = -25
ENT.TankNumWheels = 8

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 700
ENT.TankWheelForceValREV = 700


					ENT.TrackPositions = {Vector( 1,0,5 ),Vector( 1,0,5 )}
ENT.TrackModels = { 
						"models/beat the zombie/wot/luchs/luchstracks_l.mdl",
						"models/beat the zombie/wot/luchs/luchstracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/german/tracks/Luchs_track", 
							"models/beat the zombie/wot/german/tracks/Luchs_track_forward", 
							"models/beat the zombie/wot/german/tracks/Luchs_track_reverse"	}

							-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -26, 13.9, 7 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"


ENT.SkinCount = 1

ENT.BurstFire = true
ENT.BurstSize = 5

ENT.CamDist = 250
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 20, 10, 15 )
ENT.SeatPos = Vector( 0, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.305
ENT.PrimaryEffect = "ChopperMuzzleFlash"
	
ENT.ExhaustPosition = Vector( -86, 27, 48 )
ENT.BarrelMuzzleReferencePos = Vector( 55, 0, 6.6 )

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 59, 35, 53.5 ), Vector( 59, -35, 53.5 ) }
ENT.HeadLights.TPos = { Vector( -74, 33, 41 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

-- ENT.EngineSounds = { "vehicles/crane/crane_idle_loop3.wav", "vehicles/crane/crane_idle_loop3.wav" }
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.Model = "models/beat the zombie/wot/luchs/luchs_body.mdl"
ENT.TowerModel = "models/beat the zombie/wot/luchs/luchs_tower.mdl"
ENT.TowerPos  = Vector( 1, 0, 58 )
ENT.BarrelModel = "models/beat the zombie/wot/luchs/luchs_gun.mdl"
ENT.BarrelPos = Vector( 28, 0, 58 )
ENT.BarrelLength = 120

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, 0, 69 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

// Speed Limits
ENT.MaxVelocity = 60
ENT.MinVelocity = -10 // not specified in WoT wiki
ENT.Acceleration = 2

ENT.InitialHealth = 2500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 250
ENT.MinDamage = 120
ENT.BlastRadius = 128

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


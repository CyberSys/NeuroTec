ENT.FolderName = "sent_maus_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Maus"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Beat the zombie"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier X";
ENT.Description = "WW2 Super Heavy Tank LEVEL 5"
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
ENT.TrackPos = -4.95
ENT.DebugWheels = true

ENT.CrewPositions = {
					Vector( 12, -12, 55 ),
					Vector( 122, -29,55 ),
					Vector( 123, 24, 55 ),
					Vector( -40, -9, 55 )
					}
ENT.MouseScale3rdPerson = 0.035
ENT.MouseScale1stPerson = 0.035		
ENT.RecoilForce = 9999999/4
ENT.ArmorThicknessFront = 0.75
ENT.ArmorThicknessSide = 0.37
ENT.ArmorThicknessRear = 0.65

ENT.TankTrackZ = 17
ENT.TankTrackY = 50
ENT.TankTrackX = -40
ENT.TankNumWheels = 18
ENT.TurnMultiplier = 1.2

ENT.TankWheelTurnMultiplier = 250
ENT.TankWheelForceValFWD = 200
ENT.TankWheelForceValREV = 200

ENT.TrackPositions = {Vector( 4,0,5 ),Vector( 4,0,5 )}
ENT.TrackModels = { 
						"models/professorheavy/maus/maustracks_l.mdl",
						"models/professorheavy/maus/maustracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/beat the zombie/wot/german/tracks/maus_track", 
							"models/beat the zombie/wot/german/tracks/maus_track_forward", 
							"models/beat the zombie/wot/german/tracks/maus_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( 15, -17, 0 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 350
ENT.CamUp = 100
ENT.CockpitPosition = Vector( 10, 5, 20 )
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
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 4
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 4000
ENT.MinDamage = 2500
ENT.BlastRadius = 550

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = {Vector( 147, -57, 73 ), Vector( 147, 55, 74 )}
ENT.HeadLights.TPos = { Vector( -162, 55, 64 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ),  Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""



ENT.Model = "models/professorheavy/maus/mausbody.mdl"
ENT.TowerModel = "models/professorheavy/maus/mausturret.mdl"
ENT.TowerPos  = Vector( -50, 0, 80 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/maus/mausgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 22, 0, 100 )
ENT.BarrelLength = 200
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -30, -1.25, 115 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -10 //Not specified in WoT wiki
ENT.Acceleration = 5

ENT.InitialHealth = 10000
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


ENT.FolderName = "sent_tetrarch_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "Tetrarch"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier II";
ENT.Description = "WW2 Light Tank LEVEL 1"
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
ENT.TrackPos = -6.95
ENT.RecoilForce = 999999
ENT.CrewPositions = {
						Vector( 40, -2, 43 ),
						Vector( -47, 2, 36 ),
						Vector( -16, 6, 50 )
					}

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/british/tetrarch_tracks_l.mdl","models/aftokinito/wot/british/tetrarch_tracks_r.mdl"  }
ENT.TrackWheels = { "models/aftokinito/wot/british/tetrarch_wheels_l.mdl","models/aftokinito/wot/british/tetrarch_wheels_r.mdl" }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/british/tetrarch/tetrarch_ll_track", 
							"models/aftokinito/wot/british/tetrarch/tetrarch_ll_track_forward", 
							"models/aftokinito/wot/british/tetrarch/tetrarch_ll_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -10, -9, -0.5 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

-- ENT.DebugWheels = true

ENT.TankTrackZ = 12
ENT.TankTrackY = 35
ENT.TankTrackX = -25
ENT.TankNumWheels = 8
ENT.TurnMultiplier = 2.25
ENT.TankWheelTurnMultiplier = 400
ENT.TankWheelForceValFWD = 333
ENT.TankWheelForceValREV = 333

ENT.CamDist = 300
ENT.CamUp = -100
ENT.CockpitPosition = Vector( 0, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 25 )
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
ENT.MaxDamage = 1250
ENT.MinDamage = 790
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 45, -38, 44 ), Vector( 45, 38, 44 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 200, 200, 255, 255 ), Color( 200, 200, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/british/tetrarch_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/british/tetrarch_turret.mdl"
ENT.TowerPos  = Vector(5, 0.96, 50.52 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/british/tetrarch_gun.mdl"
--ENT.BarrelPart = 0
-- ENT.BarrelPos = Vector( 17.78, 62.43, -50.72 )
ENT.BarrelPos = Vector( 20.72, 0, 62.43 )
ENT.BarrelLength = 80
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -10, -1.25, 55 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 64
ENT.MinVelocity = -20
ENT.Acceleration = 0

ENT.InitialHealth = 3250
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
ENT.AmmoTypes = { 
				
				{
					PrintName = "40mm QF 2-pounder AP",
					Type = "sent_tank_apshell",
					MinDmg =55,
					MaxDmg = 165,
					Radius = 20,
					Delay = ENT.PrimaryDelay,
					Sound = ENT.ShootSound,
				};
				{
					PrintName = "40mm QF 2-pounder HE",
					Type = "sent_tank_shell",
					MinDmg = 65,
					MaxDmg = 155,
					Radius = ENT.BlastRadius,
					Delay = ENT.PrimaryDelay,
					Sound = ENT.ShootSound,
				};
				{
					PrintName = "40mm QF 2-pounder APHE",
					Type = "sent_tank_armorpiercing",
					MinDmg = 155,
					MaxDmg = 205,
					Radius = ENT.BlastRadius,
					Delay = ENT.PrimaryDelay,
					Sound = ENT	.ShootSound,
				}
			
			};

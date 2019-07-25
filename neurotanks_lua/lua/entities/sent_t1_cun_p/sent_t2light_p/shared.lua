ENT.FolderName = "sent_t2light_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "T2 Light Tank"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier II";
ENT.Description = "WW2 Premium Light Tank LEVEL 2"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.DebugWheels = true

ENT.TankTrackZ = 12
ENT.TankTrackY = 33
ENT.TankTrackX = -30
ENT.TankNumWheels = 6
ENT.TurnMultiplier = 2.0
ENT.MaxRange = 10260
ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 590
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 0.500,-2.600,4 ),Vector( 0.500,2.900,4 )}
ENT.TrackModels = { 
						"models/america/t2lt/t2lttracks_l.mdl",
						"models/america/t2lt/t2lttracks_r.mdl"  
						}

ENT.TrackAnimationOrder = { "models/wot/america/t2lt/t2_lt_a_track", 
							"models/wot/america/t2lt/t2_lt_a_track_forward", 
							"models/wot/america/t2lt/t2_lt_a_track_reverse" }

ENT.CamDist = 200
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 10, 5, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 10 )
ENT.SeatAngle = Vector( -25, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.35
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1000
ENT.MinDamage = 500
ENT.BlastRadius = 200

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 41, -30, 30 ), Vector( 41, 33, 30 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ),  Angle (0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/america/t2lt/t2ltbody.mdl"
ENT.TowerModel = "models/america/t2lt/t2ltturret.mdl"
ENT.TowerPos  = Vector( -2, 0, 42.300 )
ENT.BarrelModel = "models/america/t2lt/t2ltgun.mdl"
ENT.BarrelPos = Vector( 13.400, 1, 47.500 )
ENT.BarrelLength = 65
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

ENT.BurstFire = true
ENT.BurstSize = 3

// Speed Limits
ENT.MaxVelocity = 72
ENT.MinVelocity = -20
ENT.Acceleration = 47

ENT.InitialHealth = 2000
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


ENT.FolderName = "sent_pzic_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "PzKpfw I Ausf C"
ENT.Author	= "NeuroTec/nLua: Hoffa/nRipping: beat the zombie"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier III";
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
ENT.CrewPositions = { Vector( 30, 15, 52 ),Vector( -19, -7, 54 )}
ENT.TankTrackZ = 25
ENT.TankTrackY = 40
ENT.TankTrackX = -50
ENT.TankNumWheels = 8

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 700
ENT.TankWheelForceValREV = 700


					ENT.TrackPositions = {Vector( 5.500,1,4 ),Vector( 5.500,0,4 )}
ENT.TrackModels = { 
						"models/wot/germany/pzic/pzictracks_l.mdl",
						"models/wot/germany/pzic/pzictracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/germany/panzer i c/panther_track", 
							"models/wot/germany/panzer i c/panther_track_forward", 
							"models/wot/germany/panzer i c/panther_track_reverse"	}



ENT.SkinCount = 1

ENT.BurstFire = true
ENT.BurstSize = 5

ENT.CamDist = 150
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 20, 10, 15 )
ENT.SeatPos = Vector( 0, 0, 0 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.305
ENT.PrimaryEffect = "ChopperMuzzleFlash"
	
ENT.ExhaustPosition = Vector( -86, 27, 48 )
ENT.BarrelMuzzleReferencePos = Vector( 55, 0, 6.6 )

ENT.HeadLightsToggle = false
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 43, 18, 53 ),Vector( 42, -35, 54 ) }
ENT.HeadLights.TPos = { Vector( -87, -36, 48 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

-- ENT.EngineSounds = { "vehicles/crane/crane_idle_loop3.wav", "vehicles/crane/crane_idle_loop3.wav" }
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.Model = "models/wot/germany/pzic/pzicbody.mdl"
ENT.TowerModel = "models/wot/germany/pzic/pzicturret.mdl"
ENT.TowerPos  = Vector( -20, -14, 60 )
ENT.BarrelModel = "models/wot/germany/pzic/pzicgun.mdl"
ENT.BarrelPos = Vector( 4, -17.500, 65 )
ENT.BarrelLength = 120


// Speed Limits
ENT.MaxVelocity = 79
ENT.MinVelocity = -15
ENT.Acceleration = 35

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


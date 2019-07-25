ENT.FolderName = "sent_cromwell_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Cromwell"
ENT.Author	= "NeuroTec\nLua: Prof.Heavy\nRipping: Prof.Heavy"
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
ENT.TrackPos = -4.95
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 52, -14, 35 ),
Vector( 30, 20, 36 ),
Vector( -16, -2, 39 ),
Vector( -60, 2, 33 )
}
ENT.TankTrackZ = -3
ENT.TankTrackY = 45
ENT.TankTrackX = -40
ENT.TankNumWheels = 10
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 35,-15,-10 ),Vector( 35,-15,-10 )}
ENT.TrackModels = { 
						"models/professorheavy/cromwell/cromwelltrack_l.mdl",
						"models/professorheavy/cromwell/cromwelltrack_r.mdl"  
						}
ENT.TrackWheels = { "models/professorheavy/cromwell/cromwellwheels_l.mdl",
					"models/professorheavy/cromwell/cromwellwheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/aftokinito/wot/british/tetrarch/tetrarch_ll_track", 
							"models/aftokinito/wot/british/tetrarch/tetrarch_ll_track_forward", 
							"models/aftokinito/wot/british/tetrarch/tetrarch_ll_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -12, 5, 6 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 15 )
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
ENT.MaxDamage = 1600
ENT.MinDamage = 1050
ENT.BlastRadius = 612

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = {Vector( 89, -17, 26 ), Vector( 90, 20, 25 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ),  Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/professorheavy/cromwell/cwomwellbody.mdl"
ENT.TowerModel = "models/professorheavy/cromwell/cwomwellturret.mdl"
ENT.TowerPos  = Vector( 7, 0, 42 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/cromwell/cwomwellgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 29.000, -2, 50 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, -1.25, 65 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 64
ENT.MinVelocity = -15 //not specified in WoT wiki
ENT.Acceleration = 5

ENT.InitialHealth = 4400
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


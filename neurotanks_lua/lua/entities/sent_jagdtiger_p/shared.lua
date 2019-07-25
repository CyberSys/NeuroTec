ENT.FolderName = "sent_jagdtiger_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "JagdTiger"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof.heavy\nRipping: Prof.heavy"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier VII";
ENT.Description = "WW2 Tank Destroyer LEVEL 2"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 1.55

ENT.CrewPositions = {
Vector( 68, 26, 49 ),
Vector( 42, -9, 58 ),
Vector( -5, 19, 65 )
}


-- ENT.DebugWheels = true

ENT.TankTrackZ =  15
ENT.TankTrackY = 50
ENT.TankTrackX = -40
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444

ENT.ArmorThicknessFront = 0.55
ENT.ArmorThicknessSide = 0.37
ENT.ArmorThicknessRear = 0.65


ENT.TrackPositions = {Vector( 0,0.0001,3.500 ),Vector( 0,0.0001,3.500 )}
ENT.TrackModels = { 
						"models/wot/germany/jagdtiger/185tracks_l.mdl",
						"models/wot/germany/jagdtiger/185tracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/german/tracks/tiger_ii_track", 
							"models/wot/german/tracks/tiger_ii_track_forward", 
							"models/wot/german/tracks/tiger_ii_track_reverse" }


ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 3000
ENT.MinDamage = 1500
ENT.BlastRadius = 350

ENT.RecoilForce = 9999999/2
-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 59, -27, 48 ), Vector( 70, 18, 43 ), Vector( 59, 28, 48 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 )  }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 )  }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""


ENT.Model = "models/wot/germany/jagdtiger/185body.mdl"
ENT.TowerModel = "models/wot/germany/jagdtiger/185gun.mdl"
ENT.TowerPos  = Vector( 70, -9, 60 )
ENT.BarrelModel = "models/wot/germany/jagdtiger/185gun.mdl"
ENT.BarrelPos = Vector( 50, 0, 80  )
ENT.BarrelLength = 200
ENT.MaxBarrelYaw = 19
-- Limit eye angles
ENT.LimitView = 60

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 38
ENT.MinVelocity = -14
ENT.Acceleration = 24

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


ENT.FolderName = "sent_sturmtiger_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Sturmtiger"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Tank Destroyer"
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
ENT.TurnMultiplier = 2.155

-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 64, 20, 62 ),
Vector( 58, -40, 61 ),
Vector( -21, -37, 89 ),
Vector( -19, 4, 88 )
}

ENT.ArmorThicknessFront = 0.3
ENT.ArmorThicknessRear = 0.09
ENT.ArmorThicknessSide = 0.3

ENT.TankTrackZ = 11
ENT.TankTrackY = 55
ENT.TankTrackX = -30
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444

ENT.MaxBarrelPitch = 20

-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 320
ENT.CamUp = 72
ENT.CockpitPosition = Vector( 15, 25, 12 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 22 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf2/weapons/lw155_artillery_fire.mp3")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2700
ENT.MinDamage = 1400
ENT.BlastRadius = 156

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 59, -27, 48 ), Vector( 70, 18, 43 ), Vector( 59, 28, 48 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 )  }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 )  }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""
-- If the tracks are a separate model we need these variables.
ENT.ComplexTracks = true
	
ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/german/sturmtiger_tracks_l.mdl",
						"models/aftokinito/wot/german/sturmtiger_tracks_r.mdl"  
						}
						
ENT.TrackOffset = Vector( 0,0,3 )
						
ENT.TrackWheels = { "models/aftokinito/wot/german/sturmtiger_wheels_l.mdl",
					"models/aftokinito/wot/german/sturmtiger_wheels_r.mdl" }
					
ENT.TrackAnimationOrder = { "models/aftokinito/wot/german/sturmtiger/mle108_belogorsk_tank_track", 
							"models/aftokinito/wot/german/sturmtiger/mle108_belogorsk_tank_track_forward", 
							"models/aftokinito/wot/german/sturmtiger/mle108_belogorsk_tank_track_reverse"	}


ENT.Model = "models/aftokinito/wot/german/sturmtiger_body.mdl"
ENT.TowerModel = "models/props_junk/PopCan01a.mdl"
ENT.TowerPos  = Vector( 67, -13, 40 )
ENT.BarrelModel = "models/aftokinito/wot/german/sturmtiger_gun.mdl"
ENT.BarrelPos = Vector( 64, -11.7, 79 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 15
-- Limit eye angles
ENT.LimitView = 0

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 15
ENT.MinVelocity = -15
ENT.Acceleration = 8

ENT.InitialHealth = 5500
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

ENT.RecoilForce = 9999999


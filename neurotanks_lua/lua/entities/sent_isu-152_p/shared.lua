ENT.FolderName = "sent_isu-152_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "ISU-152"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier VIII";
ENT.Description = "WW2 Tank Destroyer LEVEL 1"
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
ENT.TurnMultiplier = 2.255

-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 36, 14, 53 ),
Vector( 6, -17, 60 ),
Vector( -12, 13, 63 )
}

ENT.ArmorThicknessFront = 0.25
ENT.ArmorThicknessRear = 0.3
ENT.ArmorThicknessSide = 0.19

ENT.TankTrackZ = 12
ENT.TankTrackY = 50
ENT.TankTrackX = -30
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444

ENT.MaxBarrelPitch = 10

-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 320
ENT.CamUp = 72
ENT.CockpitPosition = Vector( 20, 15, 12 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 10 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/engines/heavy_engine_02.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/flak88/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 3100
ENT.MinDamage = 1000
ENT.BlastRadius = 156

-- ENT.HeadLightsToggle = false
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 59, -27, 48 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 )  }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 )  }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""
-- If the tracks are a separate model we need these variables.
ENT.ComplexTracks = true
	
ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/killstr3aks/wot/russian/isu-152_tracks_l.mdl",
						"models/killstr3aks/wot/russian/isu-152_tracks_r.mdl"  
						}
						
ENT.TrackOffset = Vector( 0,0,0 )
						
ENT.TrackWheels = { "models/killstr3aks/wot/russian/isu-152_wheels_l.mdl",
					"models/killstr3aks/wot/russian/isu-152_wheels_r.mdl" }
					
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/isu-152/kv-1s_track", 
							"models/killstr3aks/wot/russian/isu-152/kv-1s_track_forward", 
							"models/killstr3aks/wot/russian/isu-152/kv-1s_track_reverse"	}


ENT.Model = "models/killstr3aks/wot/russian/isu-152_body.mdl"
ENT.TowerModel = "models/props_junk/PopCan01a.mdl"
ENT.TowerPos  = Vector( 67, -13, 40 )
ENT.BarrelModel = "models/killstr3aks/wot/russian/isu-152_gun.mdl"
ENT.BarrelPos = Vector( 94, -10, 70 )
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
ENT.MaxVelocity = 43
ENT.MinVelocity = -11
ENT.Acceleration = 6

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


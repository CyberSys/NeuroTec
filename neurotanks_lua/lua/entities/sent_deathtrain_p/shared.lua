ENT.FolderName = "sent_deathtrain_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "Death Train"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Trains";
ENT.Description = "Railway Tank Destroyer"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.HideDriver = false
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 0

ENT.IsUltraSlow = true

ENT.ArmorThicknessFront = 0.25
ENT.ArmorThicknessRear = 0.3
ENT.ArmorThicknessSide = 0.19
ENT.TankWheelSpace = 380
ENT.TankTrackZ = 11
ENT.TankTrackY = 16
ENT.TankTrackX = -450
ENT.TankNumWheels = 4

ENT.TankWheelTurnMultiplier = 0
ENT.TankWheelForceValFWD = 1454
ENT.TankWheelForceValREV = 144

ENT.MaxBarrelPitch = 10
ENT.BlastRadius = 750
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 171, 1, 132 ),Vector( 171, 1, 138 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 90, 255 ), Color( 255, 255, 90, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""
ENT.CamDist = 320
ENT.CamUp = 72
ENT.CockpitPosition = Vector( 20, 25, 121 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -155, -19, 102 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "HL1/ambience/steamburst1.wav" )
ENT.ShutDownSound = Sound("plats/railstop1.wav")

ENT.EngineSounds = {"ambient/atmosphere/engine_room.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 8
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
ENT.ComplexTracks = false
	
ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
-- ENT.TrackModels = { 
						-- "models/aftokinito/wot/german/hetzer_tracks_l.mdl",
						-- "models/aftokinito/wot/german/hetzer_tracks_r.mdl"  
						-- }
						
-- ENT.TrackOffset = Vector( 0,0,3 )
						
-- ENT.TrackWheels = { "models/aftokinito/wot/german/hetzer_wheels_l.mdl",
					-- "models/aftokinito/wot/german/hetzer_wheels_r.mdl" }
					
-- ENT.TrackAnimationOrder = { "models/aftokinito/wot/german/hetzer/hetzer_track", 
							-- "models/aftokinito/wot/german/hetzer/hetzer_track_forward", 
							-- "models/aftokinito/wot/german/hetzer/hetzer_track_reverse"	}


ENT.Model = "models/aftokinito/wot/british/tetrarch_body.mdl"
ENT.TowerModel = "models/props_junk/PopCan01a.mdl"
ENT.TowerPos  = Vector( 67, -13, 40 )
ENT.BarrelModel = "models/props_phx/cannon.mdl"
ENT.BarrelPos = Vector( 67, -0, 25 )
ENT.BarrelLength = 300
ENT.MaxBarrelYaw = 1
-- Limit eye angles
-- ENT.LimitView = 0

ENT.RecoilForce = 9999999

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 200
ENT.MinVelocity = -80
ENT.Acceleration = 8

ENT.InitialHealth = 8500
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


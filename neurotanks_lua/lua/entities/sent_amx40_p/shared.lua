ENT.FolderName = "sent_amx40_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "AMX 40"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: aftokinito\n"
ENT.Category 		= "NeuroTec Tanks - Tier IV";
ENT.Description = "Light Tank"
ENT.Spawnable	= false
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasParts = true
ENT.HasCVol = true
-- ENT.MGunDebug = true
ENT.TrackPos = -10.5

-- ENT.DebugWheels = true

ENT.TankTrackZ = 14
ENT.TankTrackY = 35
ENT.TankTrackX = -30
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/french/amx40_tracks_l.mdl","models/aftokinito/wot/french/amx40_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/french/amx40/amx40_track", 
							"models/aftokinito/wot/french/amx40/amx40_track_reverse", 
							"models/aftokinito/wot/french/amx40/amx40_track_forward"	}
ENT.SkinCount = 1
-- Smaller cannon 
--ENT.BarrelMGunPos = Vector( -17, 10, 50 )
--ENT.BarrelMGunModel = "models/weapons/minigun_test.mdl"

ENT.CamDist = 300
ENT.CamUp = 70
ENT.CockpitPosition = Vector( 4, 14, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 13, 0, 30 )
ENT.SeatAngle = Vector( 90, 90, 90 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 4
ENT.APDelay = ENT.PrimaryDelay
ENT.PrimaryEffect = "ChopperMuzzleFlash"


// Weapons
ENT.MaxDamage = 750
ENT.MinDamage = 500
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 71, 26, 53 ), Vector( 71, -26, 53 ) }
ENT.HeadLights.TPos = { Vector( -87, 28, 46 ),Vector( -87, -28, 46 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/french/amx40_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/french/amx40_turret.mdl"
ENT.TowerPos  = Vector( 12, 0, 58 )
ENT.BarrelModel = "models/aftokinito/wot/french/amx40_gun.mdl"
ENT.BarrelPos = Vector( 42, 0, 72 )
-- ENT.BarrelPos1 = Vector( 90, 1, 80 )
-- ENT.BarrelPos2 = Vector( -90, 1, 80 )
-- ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
-- ENT.MGunPos = Vector( -44, 0, 129 ) 
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

//custom pos
ENT.TowersPos = {}

ENT.TowersPos[1] = {Pos = Vector( 12, 0, 58 )}
ENT.TowersPos[2] = {Pos = Vector( 14, 0, 58 )}

ENT.BarrelsPos = {}

ENT.BarrelsPos[1] = {Pos = Vector( 42, 0, 72 ), BLength = 100 }
ENT.BarrelsPos[2] = {Pos = Vector( 39.5, 0, 70 ), BLength = 200}
ENT.BarrelsPos[3] = {Pos = Vector( 34, 0, 63 ), BLength = 100}
ENT.BarrelsPos[4] = {Pos = Vector( 34, 0, 63 ), BLength = 150}
ENT.BarrelsPos[5] = {Pos = Vector( 34, 0, 63 ), BLength = 200}

-- ENT.BarrelsPos[1].BLength = 100
-- ENT.BarrelsPos[2].BLength = 200
-- ENT.BarrelsPos[3].BLength = 100
-- ENT.BarrelsPos[4].BLength = 150
-- ENT.BarrelsPos[5].BLength = 200

-- ENT.Barrel0Pos = Vector( 42, 0, 72 )
-- ENT.Barrel1Pos = Vector( 39.5, 0, 70 )
-- ENT.Barrel2Pos = Vector( 34, 0, 63 )
-- ENT.Barrel3Pos = Vector( 34, 0, 63 )
-- ENT.Barrel4Pos = Vector( 34, 0, 63 )

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -17
ENT.Acceleration = 0

ENT.InitialHealth = 2600
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


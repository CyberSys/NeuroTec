ENT.FolderName = "sent_matilda_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "Hotchkiss H35"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Medium Tanks Tier II";
ENT.Description = "WW2 Premium Medium Tank LEVEL 1"
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

ENT.RocketAmmo = "sent_tank_300mm_rocket"
local rwide = 47
local rtall = 37

ENT.RocketDelay = 15

ENT.RocketPos = { 
Vector( 21, rwide, rtall ),
Vector( 21, -rwide, rtall ),
Vector( -24, rwide, rtall ),
Vector( -24, -rwide, rtall )
}
ENT.RocketFramePositions = {  
Vector( 21, 0.5, 29 ),
Vector( 21, -0.5, 29 ),
Vector( -24, 0.5, 29 ),
Vector( -24, -0.5, 29 )
 }

ENT.RocketFrameAngles = { 
Angle( -45, 0, 0 ),
Angle( -45, 0, 0 ),
Angle( -45, 0, 0 ),
Angle( -45, 0, 0 )
}

ENT.RocketFrameModels = { 
"models/aftokinito/wot/german/h39_stuka_stuka_l.mdl", 
"models/aftokinito/wot/german/h39_stuka_stuka_r.mdl",
"models/aftokinito/wot/german/h39_stuka_stuka_l.mdl", 
"models/aftokinito/wot/german/h39_stuka_stuka_r.mdl"
}

ENT.CrewPositions = {
Vector( 53, -15, 43 ),
Vector( 55, 18, 39 ),
Vector( 6, -2, 49 )
}
ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/wot/german/h39_stuka_tracks_r.mdl", "models/aftokinito/wot/german/h39_stuka_tracks_l.mdl" }
ENT.TrackWheels = { "models/aftokinito/wot/german/h39_stuka_wheels_l.mdl","models/aftokinito/wot/german/h39_stuka_wheels_r.mdl"  }

ENT.TrackAnimationOrder = { "models/aftokinito/wot/german/h39_stuka/h39_track", 
							"models/aftokinito/wot/german/h39_stuka/h39_track_forward", 
							"models/aftokinito/wot/german/h39_stuka/h39_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -20, 4, -2 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

-- ENT.DebugWheels = true

ENT.TankTrackZ = 14
ENT.TankTrackY = 30
ENT.TankTrackX = -23
ENT.TankNumWheels = 8

ENT.TurnMultiplier = 2.0
ENT.TankWheelTurnMultiplier = 400
ENT.TankWheelForceValFWD = 333
ENT.TankWheelForceValREV = 333

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 0, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

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
ENT.HeadLights.Pos = { Vector( 81, -22, 35 ), Vector( 81, 22, 35 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/german/h39_stuka_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/german/h39_stuka_turret.mdl"
ENT.TowerPos  = Vector( 7, 0, 51 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/german/h39_stuka_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 25, -4, 61 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -0, -1.25, 55 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 27
ENT.MinVelocity = -10 //not Specified in WoT wiki
ENT.Acceleration = 0

ENT.InitialHealth = 4000
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


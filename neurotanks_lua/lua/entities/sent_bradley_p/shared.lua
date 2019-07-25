ENT.FolderName = "sent_bradley_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "M2 Bradley"
ENT.Author	= "NeuroTec\nLua: Hoffa & StarChick\nModel Adaption: StarChick"
ENT.Category 		= "NeuroTec Tanks - Amphibious Vehicles";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
-- ENT.HasMGun = true
ENT.TrackPos = -7
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 15
ENT.VehicleCrosshairType = 2 -- BF3 Style Abrams Crosshair
ENT.ShutDownSound = "vehicles/apc/apc_shutdown.wav"
ENT.SkinCount = 2

ENT.CrewPositions = {
Vector( 47, 24, 76 ),
Vector( 61, -20, 62 ),
Vector( -44, -4, 57 ),
Vector( -90, 11, 52 )
}
local zpos = 80
local xpos = 10
ENT.TubePos = { 
Vector( xpos, 35, zpos ), 
Vector( xpos, 31, zpos ), 
Vector( xpos, 31, zpos ), 
Vector( xpos-5, -22, zpos ), 
Vector( xpos-5, -22, zpos ), 
Vector( xpos-5, -22, zpos ), 
}
ENT.TubeAng = { 
Angle( -25, 5, 0 ), 
Angle( -25, 15, 0 ), 
Angle( -25, 20, 0 ), 
Angle( -21, -5, 0 ), 
Angle( -21, -15, 0 ), 
Angle( -21, -20, 0 ) 
}
--
-- // Speed Limits
ENT.MaxVelocity = 35
ENT.MinVelocity = -20

-- ENT.WheelWeight = 300

-- ENT.DebugWheels = true
-- Has MGun?
ENT.HasMGun = true
-- Gunner pos
ENT.CopilotPos = Vector( -30, -7, 83 )
ENT.MGunModel = "models/weapons/hueym60/m60.mdl"
ENT.MGunPos = Vector( -15, -10, 110 ) 
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")


ENT.TankTrackZ = 12
ENT.TankTrackY = 50
ENT.TankTrackX = -30
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 320
ENT.TankWheelForceValFWD = 330
ENT.TankWheelForceValREV = 250

ENT.CamDist = 370
ENT.CamUp = 90
ENT.CockpitPosition = Vector( 15, 20.5, 10 )

ENT.SeatPos = Vector( 15, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.HasCVol = true
ENT.CVol = 1.0
ENT.TrackSound = "wot/is7/treads.wav"
ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""

ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.5
// Weapons
ENT.MaxDamage = 850
ENT.MinDamage = 450
ENT.BlastRadius = 256
ENT.MuzzleScale = 0.85

ENT.Model = "models/aftokinito/cod4/american/bradley_body.mdl"
ENT.TowerModel = "models/aftokinito/cod4/american/bradley_turret.mdl"
ENT.TowerPos  = Vector( -30, 0, 80 )
ENT.BarrelModel = "models/aftokinito/cod4/american/bradley_gun.mdl"
ENT.BarrelPos = Vector( 0, 0, 92 )
ENT.BarrelLength = 200

ENT.ATGMPos = Vector( 13, 50, 19 )
ENT.ATGMmdl = "models/aftokinito/cod4/american/bradley_atgm.mdl"
ENT.ATGMCooldown = 4.0
ENT.ATGMAmmo = "sent_tank_atgm"
ENT.ATGMAmmoCount = 7
ENT.ATGMMaxAmmoCount = 7

ENT.RecoilForce = 5


ENT.IsAutoLoader = true
ENT.MagazineSize = 4
ENT.RoundsPerSecond = 2
ENT.ReloadSound1 = ""
ENT.ReloadSound2 = Sound("wot/chatillon/reload2.wav")

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/aftokinito/cod4/american/bradley_tracksext_l.mdl","models/aftokinito/cod4/american/bradley_tracksext_r.mdl"  }
-- ENT.TrackWheels = { "models/aftokinito/cod4/american/bradley_tracksint_l.mdl", "models/aftokinito/cod4/american/bradley_tracksint_r.mdl" }
ENT.TrackAnimationOrder = { "models/aftokinito/wot/russian/t28/t-28_track", 
							"models/aftokinito/wot/russian/t28/t-28_track_forward", 
							"models/aftokinito/wot/russian/t28/t-28_track_reverse"	}
-- ENT.MGunModel = "models/bfp4f/ground/m1a2/m1a2_gun.mdl"
-- ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

-- Gunner pos
-- ENT.CopilotPos = Vector( -20, -19, 80 )
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -3.2,-7.5, 4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.EngineVolume = 2.0
ENT.EngineSounds = {"vehicles/apc/apc_idle1.wav", "vehicles/apc/apc_idle1.wav", "vehicles/crane/crane_idle_loop3.wav" }
ENT.StartupSound = Sound( "bf2/tanks/m1a2_engine_start_idle_stop.wav" )
-- ENT.ExitSound = Sound( "
ENT.StartupDelay = 1 -- Seconds
ENT.TurnMultiplier = 2.25

ENT.ExhaustPosition = Vector( -155, 0, 50 )

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 119, -44, 55 ), Vector( 119, 44, 55 ) }
ENT.HeadLights.TPos = { Vector( -137, -45, 72 ), Vector( -137, 45, 72 ), Vector( 119, -48, 59 ), Vector( 119, 48, 59 ) }


ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""



ENT.InitialHealth = 2300
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.BulletDelay = 0
ENT.ShellDelay = 0


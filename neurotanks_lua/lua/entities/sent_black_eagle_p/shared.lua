ENT.FolderName = "sent_black_eagle_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Black Eagle"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Description = "Main Battle Tank"
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
ENT.MaxBarrelPitch = 20
ENT.VehicleCrosshairType = 3
ENT.HasFLIR = true
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 55, 16, 52 ),
Vector( 58, -22, 52 ),
Vector( 10, 3, 63 )
};
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

ENT.TankTrackZ = 16
ENT.TankTrackY = 60
ENT.TankTrackX = -10
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 300
ENT.TankWheelForceValFWD = 300
ENT.TankWheelForceValREV = 250
ENT.TurnMultiplier = 2

ENT.TrackPositions = {Vector( 4,0,4 ),Vector( 4,0,4 )}
ENT.TrackModels = { "models/killstr3aks/wot/russian/black_eagle_tracks_l.mdl","models/killstr3aks/wot/russian/black_eagle_tracks_r.mdl"  }
ENT.TrackWheels = { "models/killstr3aks/wot/russian/black_eagle_wheels_l.mdl","models/killstr3aks/wot/russian/black_eagle_wheels_r.mdl"  }
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/black_eagle/track", 
							"models/killstr3aks/wot/russian/black_eagle/track_reverse", 
							"models/killstr3aks/wot/russian/black_eagle/track_forward" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -12, 4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 5, 20, 17 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( -17, 20, 70 )

ENT.TrackSound = "bf4/misc/m1a2_treads.wav"
ENT.StartupSound = Sound( "bf4/engines/black_eagle_startup.wav" )
ENT.EngineSounds = {"bf4/engines/black_eagle_engine.wav" }
ENT.ShutDownSound = "bf4/engines/black_eagle_stop.wav"
ENT.StartupDelay = 1.80 -- Seconds

ENT.TowerStopSound = "bf4/misc/turret_loop_01_wave 0 0 1_1ch.wav"
ENT.SoundTower = "bf4/misc/turret_loop_01_wave 0 0 0_1ch.wav"
ENT.ShootSound = Sound("bf4/cannons/125mm_cannon_fire.wav")
ENT.ReloadSound = "bf4/cannons/120mm_cannon_reload2.wav"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 3000
ENT.MinDamage = 2000
ENT.BlastRadius = 256
ENT.TankRecoilAngleForce = 	1800

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 81, -22, 35 ), Vector( 81, 22, 35 )}
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/russian/black_eagle_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/black_eagle_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 59 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/black_eagle_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 55, 0, 76 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false


ENT.MGunModel = "models/killstr3aks/wot/russian/black_eagle_mG.mdl"
ENT.MGunPos = Vector( -47, -30, 108 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.12
ENT.MGunSound = Sound("bf4/misc/mg_fire.wav")

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 124, -35, 51 ), Vector( 124, 35, 51 ) }
ENT.HeadLights.TPos = { Vector( -155, -51, 53 ), Vector( -158, 59, 53 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 33
ENT.MinVelocity = -20 
ENT.Acceleration = 0.7

ENT.InitialHealth = 7200
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


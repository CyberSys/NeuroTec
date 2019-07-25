ENT.FolderName = "sent_challenger_2_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Challenger 2"
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
ENT.VehicleCrosshairType = 2
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

ENT.TankTrackZ = 17
ENT.TankTrackY = 60
ENT.TankTrackX = -10
ENT.TankNumWheels = 14


ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 300
ENT.TankWheelForceValREV = 250
ENT.TurnMultiplier = 2
ENT.StartAngleVelocity = 5

ENT.TrackPositions = {Vector( 4,0,4 ),Vector( 4,0,4 )}
ENT.ComplexTracks = false

ENT.TrackModels = { "models/killstr3aks/wot/british/challenger_2_tracks_l.mdl","models/killstr3aks/wot/british/challenger_2_tracks_r.mdl"  }
ENT.TrackWheels = { "models/killstr3aks/wot/british/challenger_2_wheels_l.mdl","models/killstr3aks/wot/british/challenger_2_wheels_r.mdl"  }
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/british/challenger_2/kette_co", 
							"models/killstr3aks/wot/british/challenger_2/kette_co_reverse", 
							"models/killstr3aks/wot/british/challenger_2/kette_co_forward" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( 60, 4.5, 100 )
-- ENT.BarrelMGunModel = "models/killstr3aks/wot/israeli/merkava_iv_mG.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 15, 20, 0 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( -23, 22.5, 87 )

ENT.TrackSound = "bf4/misc/m1a2_treads.wav"
ENT.StartupSound = Sound( "bf4/engines/challenger2_startup.wav" )
ENT.EngineSounds = {"bf4/engines/challenger2_engine.wav" }
ENT.ShutDownSound = "bf4/engines/challenger2_stop.wav"
ENT.StartupDelay = 1.20 -- Seconds

ENT.TowerStopSound = "bf4/misc/turret_loop_01_wave 0 0 1_1ch.wav"
ENT.SoundTower = "bf4/misc/turret_loop_01_wave 0 0 0_1ch.wav"
ENT.ShootSound = Sound("bf4/cannons/125mm_cannon_fire.wav")
ENT.ReloadSound = "bf4/cannons/125mm_cannon_reload2.wav"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 4.5
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

ENT.Model = "models/killstr3aks/wot/british/challenger_2_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/british/challenger_2_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 67 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/british/challenger_2_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 59, 0, 92 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
ENT.ForcedMagazineCount = 30


ENT.MGunModel = "models/killstr3aks/wot/british/challenger_2_mG.mdl"
ENT.MGunPos = Vector( -2, 25, 106 )
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.12
ENT.MGunSound = Sound("bf4/misc/mg_fire.wav")

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 140, -18, 53 ), Vector( 140, 18, 53 ) }
ENT.HeadLights.TPos = { Vector( -182, -63, 57 ), Vector( -179, 63, 57 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 45
ENT.MinVelocity = -20 
ENT.Acceleration = 0.8

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


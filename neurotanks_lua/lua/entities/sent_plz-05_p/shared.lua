ENT.FolderName = "sent_plz-05_p"

ENT.Type = "vehicle"
-- ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "PLZ-05 Tempered Hammer"
ENT.Author	= "NeuroTec\nLua: Aftokinito and Hoffo\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Artillery"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = TANK_TYPE_ARTILLERY
ENT.TankType = TANK_TYPE_ARTILLERY

ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
-- ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 0.01
ENT.MaxBarrelPitch = 80
ENT.MaxRange =  TANK_RANGE_aRTILLERY_SHELL

ENT.VehicleCrosshairType = 25 -- BF3 Style Abrams Crosshair

ENT.ArtyView = true
local zpos = 100
local xpos = 20
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
ENT.CrewPositions = {
Vector( 88, 19, 40 ),
Vector( 91, -19, 40 ),
Vector( -71, 26, 47 ),
Vector( -54, -26, 47 )

}
ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 125, -40, 50 ), Vector( 125, 52, 50 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 205, 205, 255, 255 ), Color( 205, 205, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""


ENT.RecoilForce = 9999999
ENT.DebugWheels = true

ENT.TankTrackZ =  15
ENT.TankTrackY = 52
ENT.TankTrackX = -35
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444

ENT.ComplexTracks = true
ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/killstr3aks/wot/russian/plz-05_tracks_l.mdl",
						"models/killstr3aks/wot/russian/plz-05_tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/killstr3aks/wot/russian/plz-05_wheels_l.mdl", "models/killstr3aks/wot/russian/plz-05_wheels_r.mdl" }
ENT.TrackOffset = Vector( 0,0,0 )

ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/plz-05/track", 
							"models/killstr3aks/wot/russian/plz-05/track_forward", 
							"models/killstr3aks/wot/russian/plz-05/track_reverse" }


ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -30, 12, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( -30, -12, 30 )

ENT.TrackSound = "Vehicles/apc/apc_idle1.wav"
-- ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds
ENT.EngineVolume = 2.0
ENT.EngineSounds = {"vehicles/apc/apc_idle1.wav", "vehicles/apc/apc_idle1.wav", "vehicles/crane/crane_idle_loop3.wav" }
ENT.StartupSound = Sound( "bf2/tanks/m1a2_engine_start_idle_stop.wav" )

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/cannons/120mm_main_gun.wav")
ENT.ReloadSound = "bf2/tanks/m1a2_reload.wav"
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 10
ENT.APDelay = 12
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 4500
ENT.MinDamage = 3500
ENT.BlastRadius = 1000

-- Slow beast.
ENT.TurnMultiplier = 2.35
ENT.TurnMultiplierMoving = 1.45

ENT.Model = "models/killstr3aks/wot/russian/plz-05_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/plz-05_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
ENT.BarrelModel = "models/killstr3aks/wot/russian/plz-05_gun.mdl"
ENT.BarrelPos = Vector( 0, 0, 65  )
ENT.BarrelLength = 275
-- ENT.MaxBarrelYaw = 90
-- Limit eye angles
-- ENT.LimitView = 90

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 25
ENT.MinVelocity = -15
ENT.Acceleration = 2

ENT.InitialHealth = 6000
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
ENT.PrimaryCooldown = 500
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


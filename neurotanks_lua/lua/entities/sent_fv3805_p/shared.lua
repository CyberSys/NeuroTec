ENT.FolderName = "sent_fv3805_p"

ENT.Type = "vehicle"
-- ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "FV3805"
ENT.Author	= "NeuroTec\nLua: Aftokinito and Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Artillery"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.TankType = TANK_TYPE_HEAVY

ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 0.01
ENT.MaxBarrelPitch = 50
ENT.MaxRange =  TANK_RANGE_aRTILLERY_SHELL

ENT.ArtyView = true

ENT.CrewPositions = {
Vector( 51, 18, 63 ),
Vector( 54, -22, 64 ),
Vector( 2, -8, 70 )
}

ENT.RecoilForce = 9999999
ENT.DebugWheels = true

ENT.TankTrackZ =  15
ENT.TankTrackY = 45
ENT.TankTrackX = -35
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444

ENT.ComplexTracks = true
ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/killstr3aks/wot/british/fv3805_tracks_l.mdl",
						"models/killstr3aks/wot/british/fv3805_tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/killstr3aks/wot/british/fv3805_wheels_l.mdl", "models/killstr3aks/wot/british/fv3805_wheels_r.mdl" }
ENT.TrackOffset = Vector( 0,0,0 )

ENT.TrackAnimationOrder = { "models/killstr3aks/wot/british/fv3805/comet_track", 
							"models/killstr3aks/wot/british/fv3805/comet_track_forward", 
							"models/killstr3aks/wot/british/fv3805/comet_track_reverse" }


ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -30, 12, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( -30, -12, 30 )

ENT.TrackSound = "wot/engines/treads_medium_3_01.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/engines/light_tank_idle_00.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/cannons/artillery_gun_180mm.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 10
ENT.APDelay = 12
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 4500
ENT.MinDamage = 3500
ENT.BlastRadius = 1000

-- Slow beast.
ENT.TurnMultiplier = 1.35
ENT.TurnMultiplierMoving = 0.45

ENT.Model = "models/killstr3aks/wot/british/fv3805_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/british/fv3805_turret.mdl"
ENT.TowerPos  = Vector( -31, 0, 68 )
ENT.BarrelModel = "models/killstr3aks/wot/british/fv3805_gun.mdl"
ENT.BarrelPos = Vector( -5.5, 0, 86.5  )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 20
-- Limit eye angles
ENT.LimitView = 20

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 40
ENT.MinVelocity = -8 //not specified in WoT wiki
ENT.Acceleration = 1

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
ENT.PrimaryCooldown = 500
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


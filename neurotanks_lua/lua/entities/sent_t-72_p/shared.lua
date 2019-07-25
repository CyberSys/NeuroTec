ENT.FolderName = "sent_t-72_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "T-72"
ENT.Author	= "NeuroTec\nLua: Hoffa and Prof.Heavy\nRipping: Prof.heavy"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Description = "Medium Tank"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -4.95
ENT.MaxBarrelPitch = 15
ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 75, 30, 35 ),
Vector( 80, -12, 34 ),
Vector( 24, -15, 50 ),
Vector( 14, 18, 50 )}
ENT.TankTrackZ = 12
ENT.TankTrackY = 50
ENT.TankTrackX = -10
ENT.TankNumWheels = 14
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 2,0,8 ),Vector( 2,0,8 )}
ENT.TrackModels = { 
						"models/professorheavy/t72/t72tracks_l.mdl",
						"models/professorheavy/t72/t72tracks_r.mdl"  
						}
						
ENT.TrackWheels = { "models/professorheavy/t72/t72wheels_l.mdl",
					"models/professorheavy/t72/t72wheels_r.mdl" }
						
ENT.TrackAnimationOrder = { "models/wot/russians/t-72/track_t72", 
							"models/wot/russians/t-72/track_t72_forward", 
							"models/wot/russians/t-72/track_t72_reverse"	}

							
-- 
-- Vector( 121, 36, 42 )

ENT.HeadLights = {}
ENT.HeadLights.Pos = { Vector( 120, -30, 43 ), Vector( 120, 36, 43 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 )  }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

local zpos = 80
local xpos = 80
ENT.TubePos = { 
Vector( xpos, 25, zpos ), 
Vector( xpos, -35, zpos ), 
Vector( xpos-5, 35, zpos ), 
Vector( xpos-5, -45, zpos ), 
}
ENT.TubeAng = { 
Angle( -45, 15, 0 ), 
Angle( -45, -5, 0 ), 
Angle( -45, 25, 0 ), 
Angle( -45, -5, 0 ) 
}

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 40, 20, 8 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
-- ENT.EngineSounds = {"wot/engines/medium_tank_state2.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/is7/fire2.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 2.0
ENT.APDelay = 3
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1500
ENT.MinDamage = 1000
ENT.BlastRadius = 400
ENT.RecoilForce = 9999999/3

ENT.ReloadSound = "bf2/tanks/m1a2_reload.wav"

ENT.Model = "models/professorheavy/t72/t72body.mdl"
ENT.TowerModel = "models/professorheavy/t72/t72turret.mdl"
ENT.TowerPos  = Vector( 15, 0, 57 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/professorheavy/t72/t72gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 50, 0.500, 63 )
ENT.BarrelLength = 220
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 35
ENT.MinVelocity = -25
ENT.Acceleration = 5

ENT.InitialHealth = 4000
ENT.HealthVal = nil
ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.VehicleCrosshairType = 3
// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


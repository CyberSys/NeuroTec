ENT.FolderName = "sent_m3stuart_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "M3 Stuart"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier III";
ENT.Description = "WW2 Light Tank"
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
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 14, 16, 54 ),
Vector( 10, -10, 55 ),
Vector( -1, 1, 63 )
};
ENT.TankTrackZ = 14
ENT.TankTrackY = 35
ENT.TankTrackX = -25
ENT.TankNumWheels = 8
ENT.TurnMultiplier = 2.0

ENT.RecoilForce = 9999999/3

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 0,0,2 ),Vector( 0,0,2 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/american/m5_stuart_tracks_l.mdl",
						"models/aftokinito/wot/american/m5_stuart_tracks_r.mdl"  
						}
ENT.TrackWheels = { "models/aftokinito/wot/american/m5_stuart_wheels_l.mdl",
					"models/aftokinito/wot/american/m5_stuart_wheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/m3Stuart/grant_track", 
							"models/aftokinito/wot/american/m3Stuart/grant_track_forward", 
							"models/aftokinito/wot/american/m3Stuart/grant_track_reverse"	}
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -18, 5, 0 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 0, 5, 20 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 21, 18, 6 )

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
ENT.MaxDamage = 1400
ENT.MinDamage = 950
ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 76, 32, 46 ), Vector( 76, -32, 46 )}
ENT.HeadLights.TPos = { Vector( -80, 32, 52 ),Vector( -80, -32, 52 ) }


ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }

ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/american/m3stuart_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/m3stuart_turret.mdl"
ENT.TowerPos  = Vector( 7, 0, 64 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/american/m3stuart_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 31, 0, 73 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -10, -10, 70)
ENT.CMGunPos = Vector(0,0,20)
ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 61
ENT.MinVelocity = -20
ENT.Acceleration = 5

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


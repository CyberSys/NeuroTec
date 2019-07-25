ENT.FolderName = "sent_gwmkvi_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "G.Pz. Mk. VI (e)"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof.heavy\nRipping: Prof.heavy"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Self-Propelled Gun"
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
ENT.TrackPos = -6.95
ENT.HideDriver = true
-- ENT.LimitYaw = true
ENT.TurnMultiplier = 2.35
ENT.MaxBarrelPitch = 35
-- ENT.MaxRange = TANK_RANGE_aRTILLERY_SHELL

-- ENT.ArtyView = true

ENT.CrewPositions = {
Vector( 23, 9, 32 ),
Vector( -31, -16, 43 )
}

ENT.RecoilForce = 9999999
-- ENT.DebugWheels = true

ENT.TankTrackZ =  15
ENT.TankTrackY = 30
ENT.TankTrackX = -20
ENT.TankNumWheels = 6

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444


ENT.TrackPositions = {Vector( 0,0.0001,3.500 ),Vector( 0,0.0001,3.500 )}
ENT.TrackModels = { 
						"models/wot/germany/gwmkvi/gwtracks_l.mdl",
						"models/wot/germany/gwmkvi/gwtracks_r.mdl"  
						}
ENT.TrackAnimationOrder = { "models/wot/germany/gwmkiv/Loyd_Carrier_track", 
							"models/wot/germany/gwmkiv/Loyd_Carrier_track_forward", 
							"models/wot/germany/gwmkiv/Loyd_Carrier_track_reverse" }


ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -30, 12, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( -30, -12, 30 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2500
ENT.MinDamage = 1500
ENT.BlastRadius = 750

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 30, -37, 43 ), Vector( 27, 22, 43 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 )  }
ENT.HeadLights.Colors = { Color( 255, 255, 155, 255 ), Color( 255, 255, 155, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""


ENT.Model = "models/wot/germany/gwmkvi/gwbody.mdl"
ENT.TowerModel = "models/props_junk/garbage_coffeemug001a.mdl"
ENT.TowerPos  = Vector( 0, 0, 15 )
ENT.BarrelModel = "models/wot/germany/gwmkvi/gwgun.mdl"
ENT.BarrelPos = Vector( -25, -5, 55  )
ENT.BarrelLength = 75
ENT.MaxBarrelYaw = 15
-- Limit eye angles
ENT.LimitView = 60

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 50
ENT.MinVelocity = -20
ENT.Acceleration = 16

ENT.InitialHealth = 3000
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


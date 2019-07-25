ENT.FolderName = "sent_tortoise_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "Tortoise"
ENT.Author	= "NeuroTec\nLua: Hoffa and prof.heavy\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Tank Destroyers Tier VIII";
ENT.Description = "WW2 Tank Destroyer LEVEL 1"
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
ENT.TurnMultiplier = 1.35

ENT.CrewPositions = {
Vector( 4, 17, 47 ),
Vector( 2, -29, 47 ),
Vector( -19, -24, 82 )
}

ENT.RecoilForce = 9999999
ENT.DebugWheels = true

ENT.TankTrackZ =  14
ENT.TankTrackY = 54
ENT.TankTrackX = -40
ENT.TankNumWheels = 14

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 444
ENT.TankWheelForceValREV = 444


ENT.TrackPositions = {Vector( 0,0.0001,3.500 ),Vector( 0,0.0001,3.500 )}
ENT.TrackModels = { 
						"models/killstr3aks/wot/british/tortoise_tracks_l.mdl",
						"models/killstr3aks/wot/british/tortoise_tracks_r.mdl"  
						}
ENT.TrackWheels = { 	"models/killstr3aks/wot/british/tortoise_wheels_l.mdl", 
						"models/killstr3aks/wot/british/tortoise_wheels_r.mdl" 
						}
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/british/tortoise/tortoise_track", 
							"models/killstr3aks/wot/british/tortoise/tortoise_track_forward", 
							"models/killstr3aks/wot/british/tortoise/tortoise_track_reverse" }


ENT.CamDist = 280
ENT.CamUp = 150
ENT.CockpitPosition = Vector( 10, 15, 30 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -10, 0, 30 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/tigeri/tracks2.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/flak88/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 3000
ENT.MinDamage = 2500
ENT.BlastRadius = 350

ENT.HeadLightsToggle = false
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 59, -27, 48 ), Vector( 70, 18, 43 ), Vector( 59, 28, 48 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 )  }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 )  }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""


ENT.Model = "models/killstr3aks/wot/british/tortoise_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/british/tortoise_gun.mdl"
ENT.TowerPos  = Vector( 83, 0, 69 )
ENT.BarrelModel = "models/props_junk/garbage_coffeemug001a.mdl"
ENT.BarrelPos = Vector( 70, 0, 63  )
ENT.BarrelLength = 200
ENT.MaxBarrelYaw = 20
-- Limit eye angles
ENT.LimitView = 60

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -10 //not specified in WoT wiki
ENT.Acceleration = 0

ENT.InitialHealth = 3400
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


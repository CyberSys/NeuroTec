ENT.FolderName = "sent_bm-21_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_ARTILLERY
ENT.Base = "base_anim"
ENT.PrintName	= "MLRS"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Multiple Rocket Launching System"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.CameraChaseTower = true
-- ENT.SkinCount = 1
ENT.TrackPos = -6.95
-- ENT.DebugWheels = true
-- ENT.VehicleCrosshairType = 2 -- BF3 Style Abrams Crosshair

ENT.ArtyView = true

ENT.MaxVelocity = 35
ENT.MinVelocity = -20

ENT.CrewPositions = {
Vector( -10, 19, 55 ),
Vector( -12, -15, 53 )
};
ENT.TankTrackZ = 14
-- Wheel Y position
ENT.TankTrackY = 47
-- Wheel X position
ENT.TankTrackX = -25
-- Amount of wheels, the longer tank the more wheels needed. This needs to be an even number.
ENT.TankNumWheels = 14
-- AngleVelocity to apply to wheels when turning
ENT.TankWheelTurnMultiplier = 222
-- AngleVelocity applied when going forward, this controls the acceleration and "horsepower"
ENT.TankWheelForceValFWD = 255
-- same as above but reverse
ENT.TankWheelForceValREV = 222
-- Adds a slight push to our tank when we start driving to simulate acceleration.
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	-.1
-- Where our track models will spawn relative to tank position.
ENT.TrackPositions = {Vector( 0, 0 ,1),Vector( 0, 0 ,1 )}
-- Models used.
ENT.TrackModels = { "models/aftokinito/neurotanks/american/mlrs_tracks_l.mdl","models/aftokinito/neurotanks/american/mlrs_tracks_r.mdl"  }
-- ENT.TrackWheels = { "models/killstr3aks/wot/russian/2k12_kub_wheels_l.mdl","models/killstr3aks/wot/russian/2k12_kub_wheels_r.mdl" }

-- Texture animation order: First = Idle, Second = Forward, Third = Reverse
ENT.TrackAnimationOrder = { "models/aftokinito/neurotanks/american/mlrs/d1", 
							"models/aftokinito/neurotanks/american/mlrs/d1_forward", 
							"models/aftokinito/neurotanks/american/mlrs/d1_reverse" };
							
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( 5, 12.2, 0.5 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.CustomMuzzle = "AA_muzzleflash"
ENT.RecoilForce = -99


ENT.VisualShells = {
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl"
};
ENT.BarrelPorts = { 
Vector( 65, 44, 35 ),
Vector( 65, 32, 35 ),
Vector( 65, 18, 35 ),
Vector( 65, 44, 20 ),
Vector( 65, 32, 20 ),
Vector( 65, 18, 20 ),
Vector( 65, -44, 35 ),
Vector( 65, -32, 35 ),
Vector( 65, -18, 35 ),
Vector( 65, -44, 20 ),
Vector( 65, -32, 20 ),
Vector( 65, -18, 20 )
}

ENT.CamDist = 250
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 97, 0, 90 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 110, 25, 45 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 100, -31, 45 )
ENT.ChillSeats = { Vector( 100,31,45 ) }
ENT.ChillSeatAngles = { Angle( 0,0,0 ) }

ENT.CopilotFollowBody = true

ENT.TrackSound = ""
ENT.StartupSound = Sound( "vehicles/ural-truck/start.wav" )
ENT.EngineSounds = {"vehicles/ural-truck/idle_ural.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound( "bf4/rockets/projectile_missile_engine_wave 0 0 0_1ch.wav" )
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.5
ENT.APDelay = 0.5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.IsAutoLoader = true
ENT.MagazineSize = 12
ENT.RoundsPerSecond = 2
ENT.MaxDamage = 950
ENT.MinDamage = 750
ENT.BlastRadius = 512
ENT.ForcedMagazineCount = 200 -- override weight class based ammo count

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { 
Vector( 152, -36, 68 ),
Vector( 152, -45, 68 ),
Vector( 152, 36, 68 ),
Vector( 152, 45, 68 )
}

ENT.HeadLights.TPos = { Vector( -152, -57, 40 ), Vector( -152, 57, 40 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ),Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""
ENT.ExhaustPosition = { Vector( 0, 0, 0 ) }

ENT.Model = "models/aftokinito/neurotanks/american/mlrs_body.mdl"
ENT.TowerModel = "models/aftokinito/neurotanks/american/mlrs_turret.mdl"
ENT.TowerPos  = Vector( -100, 0, 45 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/neurotanks/american/mlrs_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( -150, 0, 45 )
ENT.BarrelLength = 250
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
-- ENT.MGunPos = Vector( -15, -32.7, 94 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

-- // Speed Limits

ENT.InitialHealth = 3000
ENT.HealthVal = nill
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


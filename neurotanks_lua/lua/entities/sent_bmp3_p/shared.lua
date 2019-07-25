ENT.FolderName = "sent_bmp3_p"
ENT.AdvancedCommando = true
ENT.CommanderSeatPos = Vector( -2, -18, 40 )-- this is where the monitor will be displayed
ENT.CommanderSeatFollowTower = true
ENT.CockpitMonitorPos = Vector( 70,0,56 )
ENT.ExternalCameraPosition = Vector( 80, 50, 75 ) -- this is the origin the rendertarget captures from
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "BMP-3"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Description = "Armored Combat Vehicle"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
-- ENT.HasMGun = true
ENT.HasParts = false
ENT.HasCVol = true
ENT.CameraChaseTower = true
-- ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.MaxBarrelPitch = 15
-- ENT.DebugWheels = true
ENT.VehicleCrosshairType = 3 -- BF3 Style Abrams Crosshair
local zpos = 80
local xpos = 15
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

ENT.MaxBarrelYaw = 10

ENT.CrewPositions = {
Vector( 40, 10, 45 ),
Vector( 39, -12, 44 ),
Vector( -10, 19, 55 ),
Vector( -12, -15, 53 )
};
ENT.FloatRatio = 3.5
ENT.CanFloat = true
ENT.FloatBoost = 120000

ENT.TankTrackZ = 12
ENT.TankTrackY = 44
ENT.TankTrackX = -40
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 590
ENT.TankWheelForceValREV = 540

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { 
"models/aftokinito/neurotanks/russian/bmp-3_tracks_l.mdl",
"models/aftokinito/neurotanks/russian/bmp-3_tracks_r.mdl"  
}
ENT.TrackWheels = {
"models/aftokinito/neurotanks/russian/bmp-3_wheels_l.mdl",
"models/aftokinito/neurotanks/russian/bmp-3_wheels_r.mdl",
}

ENT.TrackAnimationOrder = { "models/aftokinito/neurotanks/russian/bmp-3/body", 
							"models/aftokinito/neurotanks/russian/bmp-3/body_forward", 
							"models/aftokinito/neurotanks/russian/bmp-3/body_reverse" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( 5, 12.2, 0.5 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"
-- ENT.CustomMuzzle = "AA_muzzleflash"
ENT.RecoilForce = 9999999/1.2

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 25, 25, 15 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 62, 0, 20 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( -2, 18, 40 )

ENT.ChillSeatPositions = { 
Vector( -30, -29, 20 ),
Vector( -30, 30, 20 ),
Vector( -58, 30, 20 ),
Vector( -59, 1, 20 ),
Vector( -57, -30, 20 )
}
ENT.ChillSeatAngles = {
Angle( 0,-90,0 ),
Angle( 0,-90,0 ),
Angle( 0,-90,0 ),
Angle( 0,-90,0 ),
Angle( 0,-90,0 )
}

ENT.MaxVelocity = 55
ENT.MinVelocity = -25
ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf2/tanks/stryker_engine_startup.wav" )
ENT.EngineSounds = {"bf2/tanks/stryker_engine_01.wav"}
ENT.StartupDelay = 2.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf4/cannons/abrams_fire.wav")
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = .15
ENT.APDelay = .15
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 250
ENT.MinDamage = 125
ENT.BlastRadius = 64
-- ENT.ForcedMagazineCount = 300 -- override weight class based ammo count
ENT.ForcedMagazineCount = 1500 -- override weight class based ammo count

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 123, 20, 63 ),Vector( 123, -20, 63 ) }
ENT.HeadLights.TPos = { Vector( -131, -49, 61 ), Vector( -131, 49, 61 ) }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 251, 143, 255 ), Color( 255, 251, 143, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""


ENT.MicroTurretPositions = {Vector( 0, 0, 20 )}
ENT.MicroTurretModels = {  "models/props_junk/sawblade001a.mdl" }
ENT.MicroTurretAngles = { Angle( 0,0,0 ) }
ENT.MicroTurretEnt = "sent_bmp3_turret_p"


ENT.Model = "models/aftokinito/neurotanks/russian/bmp-3_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/paladin_mgun_base.mdl"
ENT.TowerPos  = Vector( 87, 48, 55 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/aftokinito/wot/french/amx40_mgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 87, 48, 61 )
ENT.BarrelLength = 75
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/killstr3aks/wot/american/stryker_mg_body.mdl"
-- ENT.MGunPos = Vector( -15, -32.7, 94 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

// Speed Limits

ENT.InitialHealth = 3500
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


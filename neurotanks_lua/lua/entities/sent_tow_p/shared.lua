ENT.FolderName = "sent_tow_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.VehicleType = VEHICLE_TANK
ENT.Base = "base_anim"
ENT.PrintName	= "TOW"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: No idea"
ENT.Category 		= "NeuroTec Tanks - Static Weapons";
ENT.Description = "Static Gun"
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasCVol = false
--ENT.CockpitSeatMoveWithTower = 1
ENT.SkinCount = 1
ENT.TrackPos = -6.95

-- ENT.MouseScale3rdPerson = 0.045
-- ENT.MouseScale1stPerson = 0.045

-- Smaller cannon 
--ENT.BarrelMGunPos = Vector( -14, -1, -4 )
--ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 250
ENT.CamUp = 20
ENT.CockpitPosition = Vector( 0, 30, 40 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 38, 32, -15 )
ENT.SeatAngle = Angle( 0, 0, 0 )
ENT.HideDriver = true
ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/flak88/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_missile" 
ENT.PrimaryDelay = 6
ENT.APDelay = 6
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 3500
ENT.MinDamage = 2100
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 9, 0, 59 ), Vector( 52, -31, 45 ), Vector( 52, 31, 45 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/bf2/weapons/tow/tow_support.mdl"
ENT.TowerModel = "models/bf2/weapons/tow/tow_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 35 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/bf2/weapons/tow/tow_launcher.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 0, 0, 48 )
ENT.BarrelLength = 100
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 0
ENT.MinVelocity = 0

ENT.InitialHealth = 1500
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


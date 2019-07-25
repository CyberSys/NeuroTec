ENT.FolderName = ""

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "ZBD-09 Turret"
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = STATIC_GUN
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasCVol = false
ENT.CockpitSeatMoveWithTower = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.LimitView = 60
ENT.HideDriver = true
ENT.CustomMuzzle = "mg_muzzleflash"

ENT.CamDist = 150
ENT.CamUp = 0
ENT.CockpitPosition = Vector( 0, 0, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, -40 )
ENT.SeatAngle = Angle( 0, 0, 0 )

ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.ForcedMagazineCount = 500

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.14
ENT.APDelay = 0.14
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 175
ENT.MinDamage = 35
ENT.BlastRadius = 72

ENT.Model = "models/vehicles/smithy285/bf3/zbd_09/50_cal_2.mdl"
ENT.TowerModel = "models/vehicles/smithy285/bf3/zbd_09/50_cal_2.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/vehicles/smithy285/bf3/zbd_09/50_cal_barrel.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 23, -4, 6 )
ENT.BarrelLength = 25
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
ENT.BarrelMuzzleReferencePos = Vector( -15, 0, 0 )

ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 0
ENT.MinVelocity = 0

ENT.InitialHealth = 2500
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


ENT.FolderName = ""

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "KV-6 small turret"
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
-- ENT.LimitView = 60
ENT.HideDriver = true
ENT.CustomMuzzle = "AA_muzzleflash"

ENT.CamDist = 150
ENT.CamUp = -100
ENT.CockpitPosition = Vector( 20, 10, 0 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, -25 )
ENT.SeatAngle = Angle( 5, -90, 0 )

ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.RecoilForce = 99999

ENT.ForcedMagazineCount = 30

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/cannons/20-45mm_small_gun.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_artillery_shell" 
ENT.PrimaryDelay = 4
ENT.APDelay = 0.14
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1200
ENT.MinDamage = 500
ENT.BlastRadius = 64

ENT.Model = "models/props_junk/PopCan01a.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/kv-6_smallturret.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/kv-6_smallgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector(30, 0, 18 )
ENT.BarrelLength = 25

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


ENT.FolderName = ""

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "KV-6 medium turret"
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
ENT.CustomMuzzle = "mg_muzzleflash"
ENT.MicroTurretFollowParentTower = true
ENT.NoTowerProxy = true
ENT.MicroTurretPositions = {Vector( -10, 0, 32 )}
ENT.MicroTurretModels = { "models/killstr3aks/wot/russian/kv-6_katturret.mdl"}
ENT.MicroTurretAngles = { Angle( 0,0,0 )}
ENT.MicroTurretAmmo = "sent_autocannon_shell"
ENT.MicroTurretDelay = 0.35
ENT.MicroTurretEnt = "sent_kv-6_katturret_p"

ENT.CamDist = 150
ENT.CamUp = 0
ENT.CockpitPosition = Vector( 20, 10, 15 )
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
ENT.ShootSound = Sound("wot/cannons/main_gun_85-107mm.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_artillery_shell" 
ENT.PrimaryDelay = 6
ENT.APDelay = 0.14
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1500
ENT.MinDamage = 1300
ENT.BlastRadius = 256

ENT.Model = "models/props_junk/PopCan01a.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/kv-6_midturret.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/kv-6_midgun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector(40, 0, 15 )
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


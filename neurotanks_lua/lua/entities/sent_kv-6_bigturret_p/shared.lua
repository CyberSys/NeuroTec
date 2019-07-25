ENT.FolderName = ""

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "KV-6 Main turret"
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
ENT.CustomMuzzle = "tank_muzzleflash"

ENT.CamDist = 150
ENT.CamUp = 0
ENT.MouseScale3rdPerson = 0.075
ENT.MouseScale1stPerson = 0.055
ENT.CockpitPosition = Vector( 25, 10, 25 )

--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, -25 )
ENT.SeatAngle = Angle( 5, -90, 0 )
ENT.NoTowerProxy = true

ENT.IsAutoLoader = true
ENT.MagazineSize = 2
ENT.RoundsPerSecond = 6
ENT.MaxDamage = 3500
ENT.MinDamage = 2000
ENT.BlastRadius = 800
ENT.ForcedMagazineCount = 30

ENT.MicroTurretFollowParentTower = true
ENT.MicroTurretPositions = {Vector( -20, 0, 90 )}
ENT.MicroTurretModels = { "models/killstr3aks/wot/russian/kv-6_smallturret.mdl"}
ENT.MicroTurretAngles = { Angle( 0,0,0 )}
ENT.MicroTurretAmmo = "sent_autocannon_shell"
ENT.MicroTurretDelay = 0.35
ENT.MicroTurretEnt = "sent_kv-6_smallturret_p"

ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.RecoilForce = 99999999/7

ENT.ForcedMagazineCount = 15

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/cannons/artillery_gun_180mm.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_artillery_shell" 
ENT.PrimaryDelay = 10
ENT.APDelay = 0.14
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 3500
ENT.MinDamage = 2000
ENT.BlastRadius = 800

ENT.Model = "models/props_junk/PopCan01a.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/kv-6_bigturret.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/kv-6_biggun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 35, 0, 70 )
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


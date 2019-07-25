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
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasCVol = false
ENT.CockpitSeatMoveWithTower = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
-- ENT.LimitView = 60
ENT.HideDriver = true
ENT.CustomMuzzle = "AA_muzzleflash"
ENT.MaxBarrelYaw = 4
ENT.NoTowerProxy = true
ENT.MicroTurretFollowParentTower = true
ENT.NoDust = true


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

ENT.BarrelPorts = { 
Vector( -55,-47.2,32 ), 
Vector( -55,-33.6,32 ), 
Vector( -55,-20,32 ), 
Vector( -55,-6.3,32 ),
Vector( -55,6.3,32 ),
Vector( -55,20,32 ),
Vector( -55,33.6,32 ), 
Vector( -55,47.2,32 ),
Vector( -55,-47.2,43 ), 
Vector( -55,-33.6,43 ), 
Vector( -55,-20,43 ), 
Vector( -55,-6.3,43 ),
Vector( -55,6.3,43 ),
Vector( -55,20,43 ),
Vector( -55,33.6,43 ), 
Vector( -55,47.2,43 )
}

ENT.VisualShells = {
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl",
"models/killstr3aks/wot/russian/bm-13_rocket.mdl"
}

ENT.IsAutoLoader = true
ENT.MagazineSize = 16
ENT.RoundsPerSecond = 3.5
ENT.MaxDamage = 750
ENT.MinDamage = 500
ENT.BlastRadius = 724
ENT.ForcedMagazineCount = 160

ENT.ForcedMagazineCount = 30

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf4/rockets/katyusha_rocket.wav")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_missile" 
ENT.PrimaryDelay = 4
ENT.APDelay = 0.14
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 1200
ENT.MinDamage = 500
ENT.BlastRadius = 64

ENT.Model = "models/props_junk/PopCan01a.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/kv-6_launcher.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/kv-6_launcher.mdl"
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


ENT.FolderName = ""

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_ARTILLERY
ENT.Base = "base_anim"
ENT.PrintName	= "Pain and Death"
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
ENT.CameraChaseTower = true
ENT.ArtyView = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
-- ENT.LimitView = 60
ENT.HideDriver = true
ENT.CustomMuzzle = "arty_muzzleflash"
ENT.NoTowerProxy = true -- disable turret hitboxes.
ENT.MouseScale3rdPerson = 0.035
ENT.MouseScale1stPerson = 0.035		
ENT.CamDist = 850
ENT.CamUp = 500
ENT.CockpitPosition = Vector( 0, 10, 15 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, -25 )
ENT.SeatAngle = Angle( 5, -90, 0 )

ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.ForcedMagazineCount = 500

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 2.14
ENT.APDelay = 2.14
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 2275
ENT.MinDamage = 1231
ENT.BlastRadius = 572

ENT.Model = "models/props_wasteland/kitchen_counter001a.mdl"
ENT.TowerModel = "models/battleships/yamato/yamato_secondturret.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/battleships/yamato/yamato_secondturret_cannon.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 100, 0, 65 )
ENT.BarrelLength = 325
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
ENT.BarrelMuzzleReferencePos = Vector( -15, 0, 0 )

ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 0
ENT.MinVelocity = 0

ENT.InitialHealth = 15000
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


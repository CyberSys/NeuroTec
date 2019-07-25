ENT.FolderName = "sent_costal_gun_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_AA
ENT.VehicleType = WEAPON_TURRET
ENT.Base = "base_anim"
ENT.PrintName	= "Coastal Gun"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Professor Heavy, VinylScratch"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Costal Artillery"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.IsArtillery = false
ENT.ArtyView = true 
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasCVol = false
ENT.CockpitSeatMoveWithTower = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.ExitPos = Vector( -24,-12, 5 )
-- ENT.MouseScale3rdPerson = 0.045
-- ENT.MouseScale1stPerson = 0.045

-- Smaller cannon 
--ENT.BarrelMGunPos = Vector( -14, -1, -4 )
--ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 250
ENT.CamUp = 320
ENT.CockpitPosition = Vector( 0, 45, 40 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 30, 80 )
ENT.SeatAngle = Angle( 0, 0, 0 )
ENT.HideDriver = true
ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/cannons/artillery_gun_180mm.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 10
ENT.APDelay = 10
ENT.PrimaryEffect = "ChopperMuzzleFlash"
ENT.CustomMuzzle = "arty_muzzleflash" 
ENT.MouseScale3rdPerson = 0.035
ENT.MouseScale1stPerson = 0.035		
// Weapons
ENT.MaxDamage = 5500
ENT.MinDamage = 4100
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 9, 0, 59 ), Vector( 52, -31, 45 ), Vector( 52, 31, 45 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/props_phx/misc/bunker01.mdl"
ENT.TowerModel = "models/150mmgun base.mdl"
ENT.TowerPos  = Vector( 0, 0, 95 )
ENT.BarrelModel = "models/150mmgun.mdl"
ENT.BarrelPos = Vector( 10, 0, 180 )
ENT.BarrelLength = 300
ENT.MGunSound = Sound("wot/global/mgun.wav")

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


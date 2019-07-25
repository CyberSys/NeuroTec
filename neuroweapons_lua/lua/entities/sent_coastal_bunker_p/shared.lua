ENT.FolderName = "sent_costal_bunker_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_SUPERHEAVY
ENT.VehicleType = WEAPON_TURRET
ENT.Base = "base_anim"
ENT.PrintName	= "Coastal Bunker"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Sillirion, VinylScratch"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Costal Artillery Bunker"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.IsArtillery = true
ENT.ArtyView = true 
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasCVol = false
ENT.HideDriver = true
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
ENT.CamUp = 120
ENT.CockpitPosition = Vector( 30, 0, 0 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -30, 0, 0 )
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
ENT.MaxDamage = 3000
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

ENT.Model = "models/sillirion/normandy/bunker.mdl"
ENT.TowerModel = "models/sillirion/normandy/bunkerturret.mdl"
ENT.TowerPos  = Vector( 38, 10, 2 )
ENT.BarrelModel = "models/sillirion/normandy/bunkergun.mdl"
ENT.BarrelPos = Vector( 38, 10, 15 )
ENT.BarrelLength = 300
ENT.MGunSound = Sound("wot/global/mgun.wav")

ENT.MaxVelocity = 0
ENT.MinVelocity = 0
ENT.MaxBarrelPitch = 30
ENT.MaxBarrelYaw = 75


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


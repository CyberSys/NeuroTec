ENT.FolderName = "sent2s7pion_p"

ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "2s7 pion Artillery Cannon"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.TankType = TANK_TYPE_ARTILLERY
ENT.VehicleType = TANK_TYPE_ARTILLERY

ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = true
ENT.MaxRange = 1000
ENT.MinRange = 50
ENT.SkinCount = 1

ENT.CamDist = 305
ENT.CamUp = 270
ENT.CockpitPosition = Vector( 25, -55, 10 )
ENT.SeatPos = Vector( -140, 26, 84+43 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.PrintName	= "2s7 pion"
ENT.Model = "models/wic/ground/2s7 pion/2s7 pion_body.mdl"

// Speed Limits
ENT.MaxVelocity = 1.8 * 20
ENT.MinVelocity = -35

ENT.InitialHealth = 6500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 500
ENT.MinDamage = 100
ENT.BlastRadius = 256
ENT.CannonPitch = 0
ENT.BarrelLength = 350

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()

/* Notes:
Basic firemode with left-click while aiming at 60° shoot to 4138 units range
*/
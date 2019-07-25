ENT.FolderName = "sent_basetank_p"

ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.PrintName	= "T-80U Tank"
ENT.Author	= "Author: NeuroTec\nLua: Hoffa\n:Model Apadtion: StarChick971"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Description = "Medium Tank"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = false
ENT.HasMGun = true

ENT.VehicleCrosshairType = 3

ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.SkinCount = 4

ENT.CamDist = 200
ENT.CamUp = 50
ENT.CockpitPosition = Vector( 12, 20, 2.5 )
ENT.SeatPos = Vector( 25, -55, 10 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.HasCVol = true
ENT.CVol = 1.0
ENT.TrackSound = "wot/is7/treads.wav"
ENT.ShootSound = "bf2/tanks/t-90_shoot.wav"
ENT.ReloadSound = "bf2/tanks/t-90_reload.wav"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 3.75

ENT.Model = "models/wic/ground/t-80u/t-80u_body.mdl"
ENT.TowerModel = "models/wic/ground/t-80u/t-80u_turret.mdl"
ENT.TowerPos  = Vector( 0, 0, 56 )
ENT.BarrelModel = "models/wic/ground/t-80u/t-80u_cannon.mdl"
ENT.BarrelPos = Vector( 40, 3, 70 )
ENT.BarrelLength = 200

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 111.5, -29, 44 ), Vector( 111.5, 35, 44 ) }
ENT.HeadLights.Angles = { Angle( -4, 180, 0 ), Angle( -4, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
ENT.MGunPos = Vector( 8, -35, 98 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

// Speed Limits
ENT.MaxVelocity = 100
ENT.MinVelocity = -100

ENT.InitialHealth = 4000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 750
ENT.MinDamage = 220
ENT.BlastRadius = 256

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


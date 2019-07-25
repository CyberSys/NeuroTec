ENT.FolderName = "sent_2s7pion_p2"
	
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_ARTILLERY
ENT.Base = "base_anim"
ENT.PrintName	= "2s7 pion Artillery (BETA)"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec WIP";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = true
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.VehicleCrosshairType = 4 //Artillery crosshair
ENT.SkinCount = 3

ENT.CamDist = 305
ENT.CamUp = 270
ENT.CockpitPosition = Vector( 25, -55, 10 )
ENT.MaxBarrelYaw = 0
ENT.BarrelFOV_X = 15
ENT.BarrelFOV_Y = 10
ENT.SeatPos = Vector( -140, 26, 84+43 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = "bf2/tanks/d30_artillery_fire.mp3"
--ENT.CockpitShootSound = ""
ENT.ReloadSound = "bf2/weapons/bomb_reload.mp3"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 2.10

ENT.Model = "models/wic/ground/2s7 pion/2s7 pion_body.mdl"
ENT.TowerModel = "models/bfp4f/ground/m1a2/m1a2_tower.mdl"
ENT.TowerPos  = Vector( 0, 0, 57 )
ENT.BarrelModel = "models/wic/ground/2s7 pion/2s7 pion_cannon.mdl"
ENT.BarrelPos = Vector( 71, -6, 76 )
ENT.BarrelLength = 250

ENT.MGunModel = "models/weapons/hueym60/m60.mdl"
ENT.MGunPos = Vector( 129, -24, 57 ) + Vector( 0, 19, 27 )
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")


-- Gunner pos
ENT.CopilotPos = Vector( -20, -19, 80 )
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -3.2,-7.5, 4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

--"physics/metal/canister_scrape_smooth_loop1.wav", 
-- ENT.EngineSounds = {  }
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 153.5, -37, 48 ), Vector( 153.5, 34, 48 ) }
ENT.HeadLights.TPos = { Vector( -155, 63, 62.3 ), Vector( -155, -63, 62.3 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 1.8 * 41
ENT.MinVelocity = -35

ENT.InitialHealth = 7000
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
ENT.MaxRange = 50000

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
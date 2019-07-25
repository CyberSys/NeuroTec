ENT.FolderName = "sent_T-90_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "T-90"
ENT.Author	= "NeuroTec\nLua: Hoffa & StarChick\nModel Adaption: StarChick"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Description = "This tank doesn't work for some reason and need to be fixed, don't use it as it makes gmod crash."
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true

ENT.TrackPos = -8.5

ENT.VehicleCrosshairType = 1 -- BF3 Style Abrams Crosshair
ENT.DebugWheels = true

ENT.TankTrackZ = 13
ENT.TankTrackY = 60
ENT.TankTrackX = -25
ENT.TankNumWheels = 16

ENT.TankWheelTurnMultiplier = 200
ENT.TankWheelForceValFWD = 300
ENT.TankWheelForceValREV = 200

ENT.SkinCount = 1

ENT.CamDist = 370
ENT.CamUp = 90
ENT.CockpitPosition = Vector( 20, 0, 16 )
ENT.BarrelFOV_X = 15
ENT.BarrelFOV_Y = 10
ENT.SeatPos = Vector( -30, 0, 41 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.HasCVol = false
ENT.CVol = 1.0

ENT.ShootSound = "bf2/tanks/t-90_shoot.wav"
ENT.ReloadSound = "bf2/tanks/t-90_reload.wav"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 2

-- ENT.Model = "models/bfp4f/ground/m1a2/m1a2_body.mdl"
ENT.Model = "models/bfp4f/ground/t-90/t-90_body.mdl"
ENT.TowerModel = "models/bfp4f/ground/t-90/t-90_tower.mdl"
ENT.TowerPos  = Vector( 0, 0, 57 )
ENT.BarrelModel = "models/bfp4f/ground/t-90/t-90_barrel.mdl"
ENT.BarrelPos = Vector( 41, 0, 68 )
ENT.BarrelLength = 250

ENT.MGunModel = "models/bfp4f/ground/t-90/t-90_gun.mdl"
ENT.MGunPos = Vector( 8, -23, 99 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")

-- Gunner pos
ENT.CopilotPos = Vector( -20, -19, 80 )
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -3.2,-7.5, 4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

--"physics/metal/canister_scrape_smooth_loop1.wav", 
-- ENT.EngineSounds = {  }
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 153.5, -37, 48 ), Vector( 153.5, 37, 48 ) }
-- ENT.HeadLights.TPos = { Vector( -155, 63, 62.3 ), Vector( -155, -63, 62.3 ) }

-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 25
ENT.MinVelocity = -15

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


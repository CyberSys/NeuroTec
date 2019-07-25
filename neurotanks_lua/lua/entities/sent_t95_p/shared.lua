

ENT.FolderName = "sent_t95_p"
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "T-28 Anti-Tank"
ENT.Author	= "NeuroTec\nLua: Hoffa\nModel Adaption: Sillirion"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = true

ENT.SkinCount = 1

ENT.CamDist = 370
ENT.CamUp = 90
ENT.CockpitPosition = Vector( 25, 28, 51 )
ENT.MaxBarrelYaw = 10
ENT.SeatPos = Vector( 15, 0, 25 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = "bf2/tanks/m1a2_fire_3p.wav"
ENT.CockpitShootSound = "bf2/tanks/m1a2_fire_1p.wav"
ENT.ReloadSound = "bf2/tanks/m1a2_reload.wav"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 6.0
// Weapons
ENT.MaxDamage = 3250
ENT.MinDamage = 2450
ENT.BlastRadius = 256

ENT.Model = "models/bfp4f/ground/t-90/t-90_body.mdl"
ENT.TowerModel = "models/bfp4f/ground/m1a2/m1a2_tower.mdl"
ENT.TowerPos  = Vector( 0, 0, 57 )
ENT.BarrelModel = "models/t95/t95_gun.mdl"
ENT.BarrelPos = Vector( 71, -6, 76 )
ENT.BarrelLength = 200

ENT.MGunModel = "models/bfp4f/ground/m1a2/m1a2_gun.mdl"
ENT.MGunPos = Vector( 10, -21, 110 ) 
ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

-- Gunner pos
ENT.CopilotPos = Vector( -20, -19, 80 )
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -3.2,-7.5, 4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.EngineVolume = 5
ENT.EngineSounds = { "physics/metal/canister_scrape_smooth_loop1.wav",  "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", "ambient/levels/canals/dam_water_loop2.wav" }
ENT.StartupSound = Sound( "bf2/tanks/m1a2_engine_start_idle_stop.wav" )
-- ENT.ExitSound = Sound( "
ENT.StartupDelay = 2.3 -- Seconds

ENT.ExhaustPosition = Vector( -155, 0, 50 )

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 153.5, -37, 48 ), Vector( 153.5, 34, 48 ) }
-- ENT.HeadLights.TPos = { Vector( -155, 63, 62.3 ), Vector( -155, -63, 62.3 ) }

-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 20
ENT.MinVelocity = -15

ENT.InitialHealth = 8000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()


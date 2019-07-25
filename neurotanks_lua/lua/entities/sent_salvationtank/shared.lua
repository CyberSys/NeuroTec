ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "HKTank2018"
ENT.Author	= "Hoffa,Sillirion"
ENT.Category 		= "NeuroTec Ground Units";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = false
ENT.HasCockpit = true
ENT.HasMGun = false

ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.SkinCount = 1

ENT.CamDist = 300
ENT.CamUp = 600
ENT.CockpitPosition = Vector( 25, -55, 10 )
ENT.MaxBarrelYaw = 15
ENT.SeatPos = Vector( 43, 22, -20 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.ShootSound = "bf2/tanks/t-90_shoot.wav"
ENT.ReloadSound = "bf2/tanks/t-90_reload.wav"
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 4.5

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.EngineVolume = 0.15
ENT.EngineSounds = { "physics/metal/canister_scrape_smooth_loop1.wav",  "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", "ambient/levels/canals/dam_water_loop2.wav" }
ENT.StartupSound = Sound( "bf2/tanks/m1a2_engine_start_idle_stop.wav" )

ENT.Model = "models/t95/t95_body.mdl"
ENT.TowerModel = "models/m4sherman/m4sherman_tower.mdl"
ENT.TowerPos  = Vector( 0, 0, 0 )
ENT.BarrelModel = "models/t95/t95_gun.mdl"
ENT.BarrelPos = Vector( 190, 0, -13 )
ENT.BarrelLength = 200

ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"
ENT.MGunPos = Vector( -16, 0, 95 ) 
ENT.MGunSound = Sound("bf2/weapons/type85_fire.mp3")
ENT.Fuel = 1000
// Speed Limits
ENT.MaxVelocity = 25
ENT.MinVelocity = -25

ENT.InitialHealth = 4000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 3000
ENT.MinDamage = 1500
ENT.BlastRadius = 512

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
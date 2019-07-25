ENT.FolderName = "sent_hk250d"

ENT.VehicleCrosshairType = 3
ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "HK Tank 250D"
ENT.Author	= "NeuroTec\nLua: Hoffa\nModel: Sillirion"
ENT.Category 		= "NeuroTec Ground Units";
ENT.Description = "Heavy future Tank"
ENT.Spawnable	= false
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasBarrelMGun = false
ENT.HasParts = true
ENT.HasCVol = true

ENT.HideDriver = true
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 58, -21, 50 ),
Vector( 57, 22, 48 ),
Vector( -37, 1, 46 ) }

ENT.TrackPos = -100

ENT.SkinCount = 1
ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.EngineVolume = 0.15
ENT.EngineSounds = { "physics/metal/canister_scrape_smooth_loop1.wav",  "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", "ambient/levels/canals/dam_water_loop2.wav" }
ENT.StartupSound = Sound( "bf2/tanks/m1a2_engine_start_idle_stop.wav" )

ENT.TrackPositions = {Vector( 0.3,128,5.2 ),Vector(0.3,-128,5.2 ),Vector( -282,128,5.2 ),Vector( -282,-128,5.2 )}
ENT.TrackModels = { "models/inaki/props_vehicles/terminator_tankhk_track.mdl", "models/inaki/props_vehicles/terminator_tankhk_track.mdl" , "models/inaki/props_vehicles/terminator_tankhk_track.mdl" , "models/inaki/props_vehicles/terminator_tankhk_track.mdl"  }

ENT.TankTrackZ = 10
ENT.TankTrackY = 40
ENT.TankTrackX = -25
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 450
ENT.TankWheelForceValFWD = 490
ENT.TankWheelForceValREV = 490

ENT.MouseScale3rdPerson = 0.065
ENT.MouseScale1stPerson = 0.065
ENT.TurnMultiplier = 2.295
ENT.TurnMultiplierMoving = 0.45

ENT.ArmorThicknessFront = 0.35
ENT.ArmorThicknessSide = 0.35
ENT.ArmorThicknessRear = 0.35

ENT.StartAngleVelocity = 10

-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	0.1

ENT.ComplexTracks = false

ENT.WheelPositions = {Vector( 0,120,0 ),Vector( 0,-120,0 ),Vector( -250,-130,0 ),Vector( -250,130,0)}

ENT.TrackOffset = Vector( 0,0,3 )
								  			
ENT.CamDist = 650
ENT.CamUp = 430
ENT.CockpitPosition = Vector( 0, 50, 0 )
ENT.SeatPos = Vector( -20, 0, 250 )
ENT.SeatAngle = Vector( 0, 0, 0 )

ENT.TrackSound = "t3/hk_tank/hk_tank.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.StartupDelay = 1.0 -- Seconds

ENT.ShootSound = Sound("t3/hk_tank/plasma02.wav")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 0.3
ENT.PrimaryEffect = "ChopperMuzzleFlash"

-- Autoloader stuff
ENT.IsAutoLoader = true
ENT.MagazineSize = 50
ENT.RoundsPerSecond = 50
ENT.ReloadSound2 = Sound("wot/chatillon/reload2.wav")


// Weapons
ENT.MaxDamage = 950
ENT.MinDamage = 650
ENT.BlastRadius = 256

ENT.Model = "models/inaki/props_vehicles/terminator_tankhk_body.mdl"
ENT.TowerModel = "models/inaki/props_vehicles/terminator_tankhk_turretrot.mdl"
ENT.TowerPos  = { Vector( -30, 173, 193 ), Vector( -30, -173, 193 ) }
ENT.BarrelModel = "models/inaki/props_vehicles/terminator_tankhk_turret.mdl"
ENT.BarrelPos = { Vector( -30, 173, 193 ), Vector( -30, -173, 193 ) }
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/wic/ground/t-80u/t-80u_gun.mdl"

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
// Speed Limits
ENT.MaxVelocity = 25
ENT.MinVelocity = -25

ENT.InitialHealth = 7600
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


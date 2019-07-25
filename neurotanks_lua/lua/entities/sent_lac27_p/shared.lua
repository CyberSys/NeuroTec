ENT.FolderName = "sent_lac27_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "LCAC-27 Hovercraft"
ENT.Author	= "NeuroTec\nLua: Hoffa\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Naval";
ENT.Description = "Transport Vehicle"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = false
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.VehicleCrosshairType = 2
-- ENT.DebugWheels = true
-- ENT.CrewPositions = {
-- Vector( 55, 16, 52 ),
-- Vector( 58, -22, 52 ),
-- Vector( 10, 3, 63 )
-- };

ENT.FloatRatio = 2.0
ENT.CanFloat = true
ENT.FloatBoost = 120000
-- Hovercraft specific variables
ENT.IsHoverTank = true
ENT.HoverTraceLength = 30 -- length of traceline from vehicle 0 0 0 and down.
ENT.HoverTraceWidth = 200 -- width of trace scatter to find if we're on ground or not. Use Developer 1 to debug
ENT.HoverUpForce = 80000 -- Amount of force to apply 
ENT.HoverTraceCount = 10 -- amount of tracelines in our scatter
ENT.HoverPropForce = 8000 -- Forward Push 
ENT.HoverTurnForce = .37 -- Amount of angle velocity to add.
ENT.HoverRotorWashPoints = {
	{ "models/combine_Helicopter/helicopter_bomb01.mdl", Vector( 125, -55, 0 ) };
	{ "models/combine_Helicopter/helicopter_bomb01.mdl", Vector( -55, -55, 0 ) };
	{ "models/combine_Helicopter/helicopter_bomb01.mdl", Vector( 125, 55, 0 ) };
	{ "models/combine_Helicopter/helicopter_bomb01.mdl", Vector( -55, 55, 0 ) };
}

-- ENT.TankTrackZ = 16
-- ENT.TankTrackY = 55
-- ENT.TankTrackX = -30
-- ENT.TankNumWheels = 16

-- ENT.TankWheelTurnMultiplier = 350
-- ENT.TankWheelForceValFWD = 390
-- ENT.TankWheelForceValREV = 340

-- ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
-- ENT.TrackModels = { "models/killstr3aks/wot/russian/bmp-2_tracks_l.mdl","models/killstr3aks/wot/russian/bmp-2_tracks_r.mdl"  }
-- ENT.TrackWheels = { "models/killstr3aks/wot/russian/bmp-2_wheels_l.mdl","models/killstr3aks/wot/russian/bmp-2_wheels_r.mdl"  }
-- ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/bmp-2/track_D", 
							-- "models/killstr3aks/wot/russian/bmp-2/track_D_reverse", 
							-- "models/killstr3aks/wot/russian/bmp-2/track_D_forward" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 600
ENT.CamUp = 300
ENT.CockpitPosition = Vector( 0, 20, 5 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf4/engines/spm-3_start_idle_stop_wave 0 0 1_1ch.wav" )
ENT.EngineSounds = { "Merlin.wav", "vehicles/airboat/fan_motor_idle_loop1.wav", "ambient/levels/canals/dam_water_loop2.wav" }
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf4/cannons/30mm_cannon_fire_close_wave 1 0 0_2ch.wav")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 0.2
ENT.APDelay = 1
ENT.PrimaryEffect = "ChopperMuzzleFlash"



// Weapons
ENT.MaxDamage = 250
ENT.MinDamage = 100
ENT.BlastRadius = 72
ENT.TankRecoilAngleForce = 	-90
ENT.ForcedMagazineCount = 500 -- override weight class based ammo count
ENT.OverrideImpactPointPrediction = true

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 81, -22, 35 ), Vector( 81, 22, 35 )}
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/american/lcac-27_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/paladin_mgun_base.mdl"
ENT.TowerPos  = Vector( 427, -127, 108 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/american/m1a2_mg_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 427, -127, 108 )
ENT.BarrelLength = 80
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.ATGMPos = Vector( 10, 1.8, 35.5 )
-- ENT.ATGMmdl = "models/props_junk/PopCan01a.mdl"
-- ENT.ATGMCooldown = 4.0
-- ENT.ATGMAmmo = "sent_tank_atgm"
-- ENT.ATGMAmmoCount = 10
-- ENT.ATGMMaxAmmoCount = 10

-- ENT.IsAutoLoader = true
-- ENT.MagazineSize = 5
-- ENT.RoundsPerSecond = 3
-- ENT.ReloadSound1 = ""
-- ENT.ReloadSound2 = Sound("bf4/cannons/into_tow_us_wave 0 0 0_2ch.wav")

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 158, -60, 61 ), Vector( 158, 60, 61 ) }

-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 55
ENT.MinVelocity = -25 -- //not specified in WoT wiki
ENT.Acceleration = 1

ENT.InitialHealth = 10500
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


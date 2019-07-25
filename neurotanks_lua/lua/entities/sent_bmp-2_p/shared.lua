ENT.FolderName = "sent_bmp-2_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "BMP-2"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Amphibious Vehicles";
ENT.Description = "Armored Transport Vehicle"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = false
ENT.HasCVol = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.VehicleCrosshairType = 2
-- ENT.DebugWheels = true
ENT.CrewPositions = {
Vector( 55, 16, 52 ),
Vector( 58, -22, 52 ),
Vector( 10, 3, 63 )
};

ENT.FloatRatio = 13
ENT.CanFloat = true
ENT.FloatBoost = 120000

ENT.TankTrackZ = 16
ENT.TankTrackY = 55
ENT.TankTrackX = -30
ENT.TankNumWheels = 16

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 0,0,3 ),Vector( 0,0,3 )}
ENT.TrackModels = { "models/killstr3aks/wot/russian/bmp-2_tracks_l.mdl","models/killstr3aks/wot/russian/bmp-2_tracks_r.mdl"  }
ENT.TrackWheels = { "models/killstr3aks/wot/russian/bmp-2_wheels_l.mdl","models/killstr3aks/wot/russian/bmp-2_wheels_r.mdl"  }
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/russian/bmp-2/track_D", 
							"models/killstr3aks/wot/russian/bmp-2/track_D_reverse", 
							"models/killstr3aks/wot/russian/bmp-2/track_D_forward" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 0, 20, 5 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf4/engines/spm-3_start_idle_stop_wave 0 0 1_1ch.wav" )
ENT.EngineSounds = {"bf4/engines/spm-3_start_idle_stop_wave 0 0 2_1ch.wav" }
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf4/cannons/30mm_cannon_fire_close_wave 1 0 0_2ch.wav")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 1
ENT.APDelay = 1
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 500
ENT.MinDamage = 250
ENT.BlastRadius = 512
ENT.TankRecoilAngleForce = 	-90

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 81, -22, 35 ), Vector( 81, 22, 35 )}
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/russian/bmp-2_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/russian/bmp-2_turret.mdl"
ENT.TowerPos  = Vector( -11, 0, 73 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/russian/bmp-2_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 22, 0, 85 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.ATGMPos = Vector( 10, 1.8, 35.5 )
ENT.ATGMmdl = "models/props_junk/PopCan01a.mdl"
ENT.ATGMCooldown = 4.0
ENT.ATGMAmmo = "sent_tank_atgm"
ENT.ATGMAmmoCount = 10
ENT.ATGMMaxAmmoCount = 10

ENT.IsAutoLoader = true
ENT.MagazineSize = 5
ENT.RoundsPerSecond = 3
ENT.ReloadSound1 = ""
ENT.ReloadSound2 = Sound("bf4/cannons/into_tow_us_wave 0 0 0_2ch.wav")

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 158, -60, 61 ), Vector( 158, 60, 61 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

// Speed Limits
ENT.MaxVelocity = 35
ENT.MinVelocity = -10 //not specified in WoT wiki
ENT.Acceleration = 1

ENT.InitialHealth = 3500
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


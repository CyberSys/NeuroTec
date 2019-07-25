ENT.FolderName = "sent_fv101_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "FV101 Scorpion"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Killstr3aKs"
ENT.Category 		= "NeuroTec Tanks - Tier X";
ENT.Description = "Armored Combat Vehicle"
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

ENT.TankTrackZ = 16
ENT.TankTrackY = 45
ENT.TankTrackX = 0
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 400
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340

ENT.TrackPositions = {Vector( 0,0,4 ),Vector( 0,0,4 )}
ENT.TrackModels = { "models/killstr3aks/wot/british/fv101_tracks_l.mdl","models/killstr3aks/wot/british/fv101_tracks_r.mdl"  }
ENT.TrackAnimationOrder = { "models/killstr3aks/wot/british/fv101/m113a3_track_co", 
							"models/killstr3aks/wot/british/fv101/m113a3_track_co_reverse", 
							"models/killstr3aks/wot/british/fv101/m113a3_track_co_forward" }
-- Smaller cannon 
-- ENT.BarrelMGunPos = Vector( -14, -1, -4 )
-- ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 0, 20, 10 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -20, 0, 35 )
ENT.SeatAngle = Vector( 0, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = ""
ENT.StartupSound = Sound( "bf4/engines/constructionloader_start_idle_stop_wave 0 0 0_1ch.wav" )
ENT.EngineSounds = {"bf4/engines/constructionloader_start_idle_stop_wave 0 0 1_1ch.wav" }
ENT.ShutDownSound = "bf4/engines/constructionloader_start_idle_stop_wave 0 0 2_1ch.wav"
ENT.StartupDelay = 1.3 -- Seconds

ENT.TowerStopSound = "bf4/misc/turret_loop_01_wave 0 0 1_1ch.wav"
ENT.SoundTower = "bf4/misc/turret_loop_01_wave 0 0 0_1ch.wav"
ENT.ShootSound = Sound("bf4/cannons/30mm_rarden_fire.wav")
ENT.ReloadSound = "bf4/cannons/largeweaponreload_02_wave 0 0 2_1ch.wav"
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 3
ENT.APDelay = 5
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 200
ENT.MinDamage = 100
ENT.BlastRadius = 256
ENT.NoRecoil = false

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 81, -22, 35 ), Vector( 81, 22, 35 )}
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/killstr3aks/wot/british/fv101_body.mdl"
ENT.TowerModel = "models/killstr3aks/wot/british/fv101_turret.mdl"
ENT.TowerPos  = Vector( -40, 0, 66 )
--ENT.TowerPart = 1
ENT.BarrelModel = "models/killstr3aks/wot/british/fv101_gun.mdl"
--ENT.BarrelPart = 0
ENT.BarrelPos = Vector( 0, 0, 84 )
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.IsAutoLoader = true
ENT.MagazineSize = 3
ENT.RoundsPerSecond = 3
ENT.ReloadSound1 = ""
ENT.ReloadSound2 = Sound("bf4/cannons/largeweaponreload_02_wave 0 0 2_1ch.wav")

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
-- ENT.MGunSound = Sound("wot/global/mgun.wav")

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 125, -17, 43 ), Vector( 125, 17, 43 ) }

ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""


// Speed Limits
ENT.MaxVelocity = 50
ENT.MinVelocity = -30 //not specified in WoT wiki
ENT.Acceleration = .5

ENT.InitialHealth = 2500
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


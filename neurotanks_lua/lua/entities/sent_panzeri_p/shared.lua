ENT.FolderName = "sent_panzeri_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_LIGHT
ENT.Base = "base_anim"
ENT.PrintName	= "Pz. I"
ENT.Author	= "NeuroTec\nLua: hoffa and Prof.Heavy\nRipping: Prof.Heavy"
ENT.Category 		= "NeuroTec Tanks - Light Tanks Tier I";
ENT.Description = "WW2 Light Tank LEVEL 2"
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
ENT.HideDriver = true
-- ENT.DebugWheels = true

ENT.TankTrackZ = 4
ENT.TankTrackY = 34
ENT.TankTrackX = -28
ENT.TankNumWheels = 10
ENT.TurnMultiplier = 2.0

ENT.TankWheelTurnMultiplier = 350
ENT.TankWheelForceValFWD = 390
ENT.TankWheelForceValREV = 340
ENT.MaxRange = 11650 -- Used by IPP
ENT.MinRange = 3500

ENT.TrackPositions = {Vector( 0,0.0001,-7 ),Vector( 0,0.0001,-7 )}
ENT.TrackModels = { 
						"models/professorheavy/panzeri/pzitracks_l.mdl",
						"models/professorheavy/panzeri/pzitracks_r.mdl"  
						}
ENT.TrackWheels = { "models/professorheavy/panzeri/pziwheels_l.mdl",
					"models/professorheavy/panzeri/pziwheels_r.mdl" }

ENT.TrackAnimationOrder = { "models/wot/germany/pzi/panther_track", 
							"models/wot/germany/pzi/panther_track_forward", 
							"models/wot/germany/pzi/panther_track_reverse" }

ENT.CamDist = 300
ENT.CamUp = 60
ENT.CockpitPosition = Vector( 10, 5, 15 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( 0, 0, 15 )
ENT.SeatAngle = Vector( -15, 0, 0 )
-- ENT.CopilotPos = Vector( 21, 18, 6 )

ENT.TrackSound = "wot/is7/treads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/is7/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.ShootSound = Sound("bf2/tanks/m6_autocannon_3p.mp3")
ENT.ReloadSound = ""
ENT.PrimaryAmmo = "sent_tank_autocannon_shell" 
ENT.PrimaryDelay = 0.35
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
ENT.MaxDamage = 450
ENT.MinDamage = 350
ENT.BlastRadius = 128

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 70, 8, 34 )
, Vector( 70, 8, 34 )
 }
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ),  Angle (0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/professorheavy/panzeri/panzeri body.mdl"
ENT.TowerModel = "models/professorheavy/panzeri/panzeri turret.mdl"
ENT.TowerPos  = Vector( 1, 0, 43 )
ENT.BarrelModel = "models/professorheavy/panzeri/panzeri gun.mdl"
ENT.BarrelPos = Vector( 23, 0, 49 )
ENT.BarrelLength = 100
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false
	
-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

ENT.BurstFire = true
ENT.BurstSize = 5

// Speed Limits
ENT.MaxVelocity = 40
ENT.MinVelocity = -15 //not specified in WoT wiki
ENT.Acceleration = 5

ENT.InitialHealth = 1800
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


ENT.FolderName = "sent_arl44_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_HEAVY
ENT.Base = "base_anim"
ENT.PrintName	= "ARL 44"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: aftokinito\n"
ENT.Category 		= "NeuroTec Tanks - Heavy Tanks Tier VI";
ENT.Description = "WW2 Heavy Tank LEVEL 1"
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = true
-- ENT.HasParts = true
ENT.HasCVol = true
ENT.TrackPos = -10.5
ENT.HideDriver = true


ENT.CrewPositions = {
Vector( 51, 18, 63 ),
Vector( 54, -22, 64 ),
Vector( 2, -8, 70 )
}
-- ENT.DebugWheels = true

ENT.TankTrackZ = 10
ENT.TankTrackY = 60
ENT.TankTrackX = -30
ENT.TankNumWheels = 12

ENT.TankWheelTurnMultiplier = 300
ENT.TankWheelForceValFWD = 399
ENT.TankWheelForceValREV = 390

ENT.SkinCount = 1
-- Camera stuff
ENT.CamDist = 280
ENT.CamUp = 195
ENT.CockpitPosition = Vector( 3, 10, 20 )

-- Slow beast.
-- ENT.MouseScale3rdPerson = 0.025
-- ENT.MouseScale1stPerson = 0.025
ENT.TurnMultiplier = 1.45
ENT.TurnMultiplierMoving = 0.45

-- This tank is VERY armored.
ENT.ArmorThicknessFront = 0.5
ENT.ArmorThicknessSide = 0.35
ENT.ArmorThicknessRear = 0.75

-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	25


ENT.SeatPos = Vector( 0, 0, 0 )
ENT.SeatAngle = Angle( 0, 90, 0 )
ENT.CockpitSeatMoveWithTower = true
ENT.StartAngleVelocity = 1
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = -70
							
ENT.ComplexTracks = true

ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/french/arl44_tracks_l.mdl",
						"models/aftokinito/wot/french/arl44_tracks_r.mdl"  
						}
						
ENT.TrackOffset = Vector( 0,0,3 )
						
ENT.TrackWheels = { "models/aftokinito/wot/french/arl44_wheels_l.mdl",
					"models/aftokinito/wot/french/arl44_wheels_r.mdl" }
					
ENT.TrackAnimationOrder = { "models/aftokinito/wot/french/arl44/b1_track", 
							"models/aftokinito/wot/french/arl44/b1_track_forward", 
							"models/aftokinito/wot/french/arl44/b1_track_reverse"	}
							
ENT.SkinCount = 1
-- Smaller cannon 
ENT.BarrelMGunPos = Vector( -14, -14.3, -4 )
ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.TrackSound = "wot/arl44/threads.wav"
ENT.StartupSound = Sound( "vehicles/jetski/jetski_no_gas_start.wav" )
ENT.EngineSounds = {"wot/tigeri/idle.wav"}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("wot/tigeri/fire.wav")
ENT.ReloadSound = Sound("wot/tigeri/reload.wav")
ENT.PrimaryAmmo = "sent_tank_shell" 
ENT.PrimaryDelay = 5
ENT.APDelay = 7
ENT.PrimaryEffect = "ChopperMuzzleFlash"

// Weapons
--ENT.MaxDamage = 1900
--ENT.MinDamage = 1250
--ENT.BlastRadius = 512

ENT.HeadLightsToggle = true
ENT.HeadLightsLast = CurTime()
ENT.HeadLights = {}
ENT.HeadLights.Lamps = {}
ENT.HeadLights.Pos = { Vector( 98, -30, 57 ), Vector( 98, 30, 57 )}
ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
ENT.HeadLightProjectionTexture = ""

-- ENT.BarrelOffset = true

ENT.Model = "models/aftokinito/wot/french/arl44_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/french/arl44_turret.mdl"
ENT.TowerPos  = Vector( 2, 0, 71 )
ENT.TowerParts = { 1, 2 }

ENT.BarrelModel = "models/aftokinito/wot/french/arl44_gun.mdl"
-- ENT.BarrelParts = { 2, 7 }
ENT.BarrelPos = Vector( 55, -9.3, 102 ) --, Vector( 47, 0, 87 ) }
ENT.BarrelLength = 220
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

ENT.MGunModel = "models/items/AR2_Grenade.mdl"
ENT.MGunPos = Vector( -10, 0, 79 ) 
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 37
ENT.MinVelocity = -10 //not specified in WoT wiki
ENT.Acceleration = 2.5

ENT.InitialHealth = 5000
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
 

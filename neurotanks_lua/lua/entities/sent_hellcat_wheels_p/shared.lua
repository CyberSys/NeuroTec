ENT.FolderName = "sent_hellcat_wheels_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_MEDIUM
ENT.Base = "base_anim"
ENT.PrintName	= "M18 Hellcat"
ENT.Author	= "NeuroTec\nLua: Aftokinito\nRipping: Aftokinito"
ENT.Category 		= "NeuroTec Work In Progress";
ENT.Description = "Tank Destroyer"
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_TANK
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasParts = true
ENT.HasCVol = true
ENT.TrackPos = -6.75
ENT.HideDriver = true




ENT.SkinCount = 1
-- Camera stuff
ENT.CamDist = 280
ENT.CamUp = 75
ENT.CockpitPosition = Vector( 3, 10, 20 )

ENT.MouseScale3rdPerson = 0.035
ENT.MouseScale1stPerson = 0.035
ENT.TurnMultiplier = 0.95
ENT.TurnMultiplierMoving = 0.45

ENT.ArmorThicknessFront = 0.35
ENT.ArmorThicknessSide = 0.35
ENT.ArmorThicknessRear = 0.35

ENT.StartAngleVelocity = 1.0

-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = 	0


ENT.SeatPos = Vector( -12, -12, 55 )
ENT.SeatAngle = Angle( 0, 90, 0 )
ENT.CockpitSeatMoveWithTower = true
ENT.StartAngleVelocity = 5.5
-- The amount of kickback on the tank. If it kicks the wrong direction try removing or adding a -
ENT.TankRecoilAngleForce = -70

-- Gunner pos
--ENT.CopilotPos = Vector( -15, 12, 68 )
--ENT.CopilotAngle = Angle( 0, 90, 0 )
-- ENT.StandByCoMGun = true -- Standing pose instead of sitting
--ENT.CopilotWeightedSequence = ACT_DRIVE_JEEP

--ENT.MGunModel = "models/l4d2_50cal_hack.mdl"
--ENT.MGunPos = Vector( -41, 0, 110 )
--ENT.MGunAng = Angle( 0, 180, 0 )
--ENT.MGunSound = Sound("bf2/weapons/coaxial browning_fire.mp3")

ENT.TrackSound = "wot/tigeri/tracks2.wav"
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

--ENT.HeadLightsToggle = true
--ENT.HeadLightsLast = CurTime()
--ENT.HeadLights = {}
--ENT.HeadLights.Lamps = {}
--ENT.HeadLights.Pos = { Vector( 83, -34, 59 ), Vector( 83, 34, 59 ) }
--ENT.HeadLights.TPos = { Vector( -114, 36, 64 ), Vector( -114, -36, 64 ) }

--ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
--ENT.HeadLights.Colors = { Color( 255, 255, 255, 255 ), Color( 255, 255, 255, 255 ) }
--ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
--ENT.HeadLightProjectionTexture = ""

ENT.Model = "models/aftokinito/wot/american/m18_hellcat_body.mdl"
ENT.TowerModel = "models/aftokinito/wot/american/m18_hellcat_turret.mdl"
ENT.TowerPos  = Vector( 3.5, 0, 53 )
ENT.TowerParts = { 1, 2 }

ENT.BarrelModel = "models/aftokinito/wot/american/m18_hellcat_gun.mdl"
ENT.BarrelParts = { 3, 7 }
ENT.BarrelOffset = true
ENT.BarrelPos = { Vector( 38.5, 0, 71.7 ), Vector( 45, 0, 68 ) }
ENT.BarrelLength = 220
ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false


--- make the wheels visible during development
-- ENT.DebugWheels = true

ENT.TankTrackZ = 0
ENT.TankTrackY = 20
ENT.TankNumWheels = 10

ENT.TankWheelTurnMultiplier = 7
ENT.TankWheelForceValFWD = 25
ENT.TankWheelForceValREV = -15

-- ENT.PhysWheelPositions = {
		-- Vector( 69, y, z ),
		-- Vector( 30, y, z ),
		-- Vector( -5, y, z ),
		-- Vector( -43, y, z ),
		-- Vector( -75, y, z + 0 ),
		-- Right side wheels
		-- Vector( 69, -y, z ),
		-- Vector( 30, -y, z ),
		-- Vector( -5, -y, z ),
		-- Vector( -43, -y, z ),
		-- Vector( -75, -y, z + 0  )
	-- }

-- If the tracks are a separate model we need these variables.
ENT.ComplexTracks = true

ENT.WheelPositions = {Vector( 0,0,0 ),Vector( 0,0,0 )}
ENT.TrackModels = { 
						"models/aftokinito/wot/american/m18_hellcat_tracks_l.mdl",
						"models/aftokinito/wot/american/m18_hellcat_tracks_r.mdl"  
						}
						
ENT.TrackOffset = Vector( 0,0,3 )
						
ENT.TrackWheels = { "models/aftokinito/wot/american/m18_hellcat_wheels_l.mdl",
					"models/aftokinito/wot/american/m18_hellcat_wheels_r.mdl" }
					
ENT.TrackAnimationOrder = { "models/aftokinito/wot/american/m18_hellcat/grant_track", 
							"models/aftokinito/wot/american/m18_hellcat/grant_track_forward", 
							"models/aftokinito/wot/american/m18_hellcat/grant_track_reverse"	}

// Speed Limits
ENT.MaxVelocity = 72
ENT.MinVelocity = -72

ENT.InitialHealth = 1300
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


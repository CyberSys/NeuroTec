ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Cessna C-172 Skyhawk"
ENT.Author	= "Hoffa, StarChick, Silliron"
ENT.Category 		= "NeuroTec Civil";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.NoMgun = true
ENT.HasAfterburner = false
ENT.HasAirbrakes = false

ENT.NA_isCivilian = true
ENT.NoAirbrake = true

ENT.Model = "models/cessna/cessna172.mdl"
ENT.PropellerModel = "models/cessna/cessna172_prop.mdl"
ENT.PropellerPos = Vector( 82, 0, 0)

-- Speed Limits
ENT.MaxVelocity = 1.8 * 600
ENT.MinVelocity = 0

ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = Vector( 66, -13, -23 ) -- single vector or table of vectors.

ENT.CameraDistance = 400
ENT.CameraUp = 100
ENT.CockpitPosition = Vector( 0, 9, 23 )
				
ENT.EngineSounds = {
	"vehicles/airboat/fan_blade_Fullthrottle_loop1.wav",
	"vehicles/fast_windloop1.wav",
	"vehicles/airboat/fan_motor_Fullthrottle_loop1.wav"}

ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.WheelPos = { Vector( -13, -45, -37 ),Vector( -13, 45, -37 ), Vector( 53.5, 0, -41.5 ) }
ENT.WheelModels = {"models/fsx/warbirds/spitfire_wheel.mdl","models/fsx/warbirds/spitfire_wheel.mdl","models/fsx/warbirds/spitfire_wheel.mdl"}
ENT.LanternPos = { 
					{ 
						Mat = "sprites/greenglow1.vmt",
						Pos = Vector( 10, -216, 35 )
					};
					{ 
						Mat = "sprites/redglow3.vmt",
						Pos = Vector( 10, 216, 35 )
					};
					{ 
						Mat = "sprites/light_glow01.vmt",
						Pos = Vector( -203, 0, 72 )
					};

				}

ENT.ExtraSeats = 
								{	
									{
										Type = "Gunnerseat",
										Mdl = "models/nova/jeep_seat.mdl",
										LimitView = 0,
										Ang = Angle( 7,-90,-17 ),
										Pos =  Vector( -5, -11, -15 ),

									};
									{
										Type = "Gunnerseat",
										Mdl = "models/nova/jeep_seat.mdl",
										LimitView = 0,
										Ang = Angle( 0,-90,-17 ),
										Pos =  Vector( -34, -8, -15 ),

									};
									{
										Type = "Gunnerseat",
										Mdl = "models/nova/jeep_seat.mdl",
										LimitView = 0,
										Ang = Angle( 0,-90,-17 ),
										Pos =  Vector( -34, 8, -15 ),

									};

							}

--  How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 7

ENT.InitialHealth = 5000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.Landed = true
ENT.Landing = 100
ENT.LandDelay = nil
ENT.ToggleGear = true

--  Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8
ENT.CrosshairOffset = 0

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.05
ENT.LastPrimaryAttack = CurTime() * 100000

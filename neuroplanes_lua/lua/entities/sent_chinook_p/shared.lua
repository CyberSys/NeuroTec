ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Chinook"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.SearchLightPos = Vector( 257, -0, 29 )
ENT.SearchLightAng = Angle( 45, 0, 0 )

//Speed Limits
ENT.MaxVelocity = 900
ENT.MinVelocity = -900

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.5

ENT.InitialHealth = 7000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.Velpitch = 0

// Timers
ENT.RotorTimer = 400
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 30
ENT.FlareCount = 20
ENT.MaxFlares = 20
ENT.CrosshairOffset = -53
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.GotChopperGunner = false
-- // VTOL specific variable.
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true

ENT.HelicopterPilotSeatPos = Vector( 209, 23, 50.7 )
ENT.HelicopterPassengerSeatPos = Vector( 210, -23, 47 )

ENT.TopRotorVal = 1000
ENT.Mass = 99999999 

ENT.RotorPropellerPos = Vector( 213, 0, 144 )
ENT.TailPropellerPos =  Vector( -181, 0, 190 )
-- Side mounted, static miniguns
-- ENT.MinigunPos = { Vector( -15, 68, 27 ), Vector( -15, -68, 27 ) }

ENT.HelicopterEngineSound = "npc/manhack/mh_engine_loop1.wav"


ENT.Model = "models/wac/chinook.mdl"
ENT.RotorModel = "models/wac/chinookblade.mdl"
ENT.RotorModelTail = "models/wac/chinookblade.mdl"
ENT.TiltTailRotor = true
	
ENT.CamDist = 970
ENT.CamUp = 150

ENT.CockpitCameraPos =  Vector( 215, 23, 89 )
ENT.GunCamPos = Vector( 165, 0, -59 )

ENT.ExhaustPosition = Vector( -150, 13, 196 )


ENT.NoGuns = true

ENT.MinZoom = 10
ENT.MaxZoom = 55

	
ENT.Armament = {					
				

			}
			
			
local x,y,z = 0,0,0
-- Vector( -206, -29, 69 )
-- Vector( -204, -4, 68 )
-- Vector( -203, 12, 67 )
-- Vector( -203, 42, 67 )

ENT.ExtraSeats = {	
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,180,0 ),
						Pos =  Vector( 170, -25, 37 ),
						GunPos = Vector( 170, -43, 55 ),
						GunAng = Angle( 0, -90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( 170, -35, 47 ),
						StAng = Angle( 90, 90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl" 
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,0,0 ),
						Pos =  Vector( -106, -36, 37 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,180,0 ),
						Pos =  Vector( -106, 36, 37 ),
						NoDraw = true
					};					
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,0,0 ),
						Pos =  Vector( -50, -36, 37 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,180,0 ),
						Pos =  Vector( -50, 36, 37 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,0,0 ),
						Pos =  Vector( -0, -36, 37 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,180,0 ),
						Pos =  Vector( -0, 36, 37 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 5,180,0 ),
						Pos =  Vector( 50, 36, 37 ),
						NoDraw = true
					};
					-- {
						-- Type = "Gunnerseat",
						-- Mdl = "models/nova/jeep_seat.mdl",
						-- LimitView = 60,
						-- Ang = Angle( 0,0,0 ),
						-- Pos =  Vector( 140, 35, 60 ),
						-- GunPos = Vector( 140, 60, 77 ),
						-- GunAng = Angle( 0, 90, 0 ),
						-- GunMdl = "models/weapons/hueym60/m60.mdl",
						-- StPos = Vector( 140, 47, 68 ),
						-- StAng = Angle( 90, -90, 180 ),
						-- StMdl = "models/props_trainstation/tracksign10.mdl" 
					-- };
	}

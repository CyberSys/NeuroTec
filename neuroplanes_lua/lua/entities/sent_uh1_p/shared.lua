ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "UH-1 Iroquois"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER


ENT.SearchLightPos = Vector( 111,0,15 )
ENT.SearchLightAng = Angle( 45, 0, 0 )

ENT.Model = "models/fsx/helicopters/uh-1 iroquois.mdl"
//Speed Limits
ENT.MaxVelocity = 950
ENT.MinVelocity = -800

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.0

ENT.InitialHealth = 3500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.Velpitch = 0

// Timers
ENT.RotorTimer = 200
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8
ENT.CrosshairOffset = -53
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.GotChopperGunner = false
-- // VTOL specific variable.
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true

ENT.HelicopterPilotSeatPos = Vector( 70, 24, 30 )
ENT.HelicopterPassengerSeatPos = Vector( 70, -24, 30 )
ENT.TopRotorVal = 1000
ENT.Mass = 99999999

ENT.RotorPropellerPos = Vector(-1,0,90)
ENT.TailPropellerPos =  Vector(-301,2,119.5)
-- Side mounted, static miniguns
ENT.MinigunPos = { Vector( -15, 68, 27 ), Vector( -15, -68, 27 ) }

ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
ENT.RotorModel = "models/fsx/helicopters/uh-1 iroquois_rotor.mdl"
ENT.RotorModelTail = "models/fsx/helicopters/uh-1 iroquois_tailrotor.mdl"

ENT.CamDist = 450
ENT.CamUp = 150

ENT.CockpitCameraPos =  Vector( 79, 24, 70 ) 
ENT.GunCamPos = Vector( 165, 0, -59 )

ENT.ExhaustPosition = Vector( -89, 0, 51 )

ENT.MinZoom = 10
ENT.MaxZoom = 55
local d = 10
local f = -15
local s = 20
ENT.ExtraSeats = {	
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,180,0 ),
						Pos =  Vector( f, -25-s, 37-d ),
						GunPos = Vector( f, -43-s, 55-d ),
						GunAng = Angle( 0, -90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( f, -35-s, 47-d ),
						StAng = Angle( 90, 90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl",
						-- NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,0,0 ),
						Pos =  Vector( f, 25+s, 37-d ),
						GunPos = Vector( f, 43+s, 55-d ),
						GunAng = Angle( 0, 90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( f, 35+s, 47-d ),
						StAng = Angle( 90, -90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl",
						-- NoDraw = true
					};

					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,-90,0 ),
						Pos =  Vector( 18, -20, 30 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,-90,0 ),
						Pos =  Vector( 18, 0, 30 ),
						NoDraw = true
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,-90,0 ),
						Pos =  Vector( 18, 20, 30 ),
						NoDraw = true
					};
				
}
					
ENT.Armament = {
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( -15,50, 17), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 6, 											// Cooldown between weapons
					--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 6
				}; 
				{ 
					PrintName = "LAU-68D/A Rocket Pods"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( -15, -50, 17), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 									// Color
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 6, 											// Cooldown between weapons
					-- isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2s_dumb",								// the object that will be created.
					BurstSize = 6
				};					

				{ 
					PrintName = "static"		,		 			// print name, used by the interface
					Mdl = "models/fsx/helicopters/uh-1 iroquois_extras.mdl",  		// model, used when creating the object
					Pos = Vector( 0,0,0 ), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 									// Color
					Type = "Effect", 										// Type, used when creating the object

				};
				

			}
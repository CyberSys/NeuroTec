ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Merlin"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.Model = "models/bf2/helicopters/merlin.mdl"
//Speed Limits
ENT.MaxVelocity = 900
ENT.MinVelocity = -900

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.5

ENT.InitialHealth = 4000
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
ENT.FlareCooldown = 1
ENT.FlareCount = 1
ENT.MaxFlares = 1
ENT.CrosshairOffset = -53
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.GotChopperGunner = false
-- // VTOL specific variable.
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true

ENT.HelicopterPilotSeatPos = Vector( 211, 26, 87 )
ENT.HelicopterPassengerSeatPos = Vector( 210, -30, 80 )
ENT.TopRotorVal = 1000
ENT.Mass = 99999999

ENT.RotorPropellerPos = Vector(15,0,212)
ENT.TailPropellerPos =  Vector(-506,31,215)
-- Side mounted, static miniguns
-- ENT.MinigunPos = { Vector( -15, 68, 27 ), Vector( -15, -68, 27 ) }

ENT.HelicopterEngineSound = "npc/manhack/mh_engine_loop1.wav"
ENT.RotorModel = "models/bf2/helicopters/wz-10/wz-10_rotor.mdl"
ENT.RotorModelTail = "models/bf2/helicopters/mil mi-24/mil mi-24_tailrotor.mdl"

ENT.ExtraSeats = {	
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,180,0 ),
						Pos =  Vector( 140, -35, 60 ),
						GunPos = Vector( 140, -60, 84 ),
						GunAng = Angle( 0, -90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( 140, -50, 65 ),
						StAng = Angle( 90, 90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl" 
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,0,0 ),
						Pos =  Vector( 140, 35, 60 ),
						GunPos = Vector( 140, 60, 77 ),
						GunAng = Angle( 0, 90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( 140, 47, 68 ),
						StAng = Angle( 90, -90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl" 
					};
	}
	
ENT.CamDist = 970
ENT.CamUp = 150

ENT.CockpitCameraPos =  Vector( 222, 25, 126 ) 
ENT.GunCamPos = Vector( 165, 0, -59 )

ENT.ExhaustPosition = Vector( -150, 13, 196 )


ENT.NoGuns = true

ENT.MinZoom = 10
ENT.MaxZoom = 55

	
ENT.Armament = {					
				

			}
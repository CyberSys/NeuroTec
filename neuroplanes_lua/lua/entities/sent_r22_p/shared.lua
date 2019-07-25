ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Robinson R-22"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.Model = "models/r22/r22body.mdl"
//Speed Limits
ENT.MaxVelocity = 700
ENT.MinVelocity = -600

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.5

ENT.InitialHealth = 1200
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

ENT.HelicopterPilotSeatPos = Vector( 0, 14, 45 )
ENT.HelicopterPassengerSeatPos = Vector( 4, -16, 35	 )
ENT.TopRotorVal = 1000
ENT.Mass = 99999999

ENT.RotorPropellerPos = Vector(-27,4,135)
ENT.TailPropellerPos =  Vector(-295,8,107)
-- Side mounted, static miniguns
-- ENT.MinigunPos = { Vector( -15, 68, 27 ), Vector( -15, -68, 27 ) }

ENT.HelicopterEngineSound = "npc/manhack/mh_engine_loop1.wav"
ENT.RotorModel = "models/fsx/helicopters/uh-1 iroquois_rotor.mdl"
ENT.RotorModelTail = "models/fsx/helicopters/uh-1 iroquois_tailrotor.mdl"

ENT.CamDist = 450
ENT.CamUp = 150

ENT.CockpitCameraPos =  Vector( 10, 15, 90 ) 
ENT.GunCamPos = Vector( 165, 0, -59 )

ENT.ExhaustPosition = Vector( -75, 5, 60 )

ENT.NoGuns = true

ENT.MinZoom = 10
ENT.MaxZoom = 55

	
ENT.Armament = {					
				

			}
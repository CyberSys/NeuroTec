ENT.Type = "vehicle"
ENT.Base = "base_anim"

ENT.PrintName	= "MH-53J Pavelow New"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true

-- This Variable is used by the HUD
ENT.VehicleType = VEHICLE_HELICOPTER

-- Tells us if we should create the chopper gun object
ENT.HasMGun = false

-- Creates additional seats in a vehicle. this requires that you specify a table. See further down for example.
ENT.HasGunnerSeats = true

-- Removes the lock-on capability
ENT.CanLockon = false

-- Camera distance variables
ENT.CamDist = 1200
ENT.CamUp = 300

-- Variables used for placing cameras and seats in the cockpit
ENT.CockpitPosition = Vector( 261, 32, 107 ) 
ENT.HelicopterPilotSeatPos = Vector( 94, 0, 1 )
ENT.HelicopterPassengerSeatPos = Vector( 260, -32, 72 )

-- That big spinny thingy on the roof
ENT.RotorPropellerPos = Vector( 10, 0, 190 )
ENT.TailPropellerPos =  Vector( -691, 25, 235 )

ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"

// Equipment
ENT.MachineGunModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_cannon.mdl"
ENT.MachineGunOffset = Vector( 116, -1, -36 )
ENT.CrosshairOffset = 0

ENT.Model = "models/bf2/helicopters/mh-53j pave low iiie/mh53_b.mdl"
ENT.RotorModel =  "models/bf2/helicopters/mh-53j pave low iiie/mh53_r.mdl"
ENT.RotorModelTail = "models/bf2/helicopters/mh-53j pave low iiie/mh53_tr.mdl"

//Speed Limits
ENT.MaxVelocity = 600
ENT.MinVelocity = -600

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 3.7

ENT.InitialHealth = 15000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.Velpitch = 0

// Timers
ENT.RotorTimer = 500
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 10
ENT.FlareCount = 20
ENT.MaxFlares = 20

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.SecondaryCooldown = 5.0

ENT.GotChopperGunner = false

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true

-- This table contains information about cosmetic props such as landing gear, spotlights and such.
	ENT.Details = {
				
				{ 
					Pos = Vector( 355, -4, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_rtwheel.mdl"
					
				};
				{ 
					Pos = Vector( -70, -110, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_rtwheel.mdl"
					
				};
				{ 
					Pos = Vector( -70, -101, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_rtwheel.mdl"
					
				};
				{ 
					Pos = Vector( 58, 84, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_lfwheel.mdl" 
					
				};
				{ 
					Pos = Vector( -70, 101, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_lfwheel.mdl" 
					
				};
				{ 
					Pos = Vector( -70, 110, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_lfwheel.mdl" 
					
				};
				{ 
					Pos = Vector( 355, -4, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_gear.mdl"
					
				};
				{ 
					Pos = Vector( -70, -105, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_gear.mdl"
					
				};
				{ 
					Pos = Vector( -70, 105, 0 ),
					Ang = Angle( 0,0,0 ),
					Mdl = "models/bf2/helicopters/mh-53j pave low iiie/mh-53j_gear.mdl" 
					
				};
	}
	

	ENT.Armament = {
				{
					PrintName = "ALQ-131 ECM",
					Mdl = "models/hawx/weapons/alq 131 ecm.mdl",
					Pos = Vector( -25, 0, -20 ),
					Ang = Angle( 0, 0, 0 ),
					Col = Color( 0, 0, 0, 0), 	
					Type = "Flarepod",
					Cooldown = 0,
					isFirst = false,
					Class = ""
				};
			}
	ENT.ExtraSeats = {	
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,180,0 ),
						Pos =  Vector( 182, -35, 40 ),
						GunPos = Vector( 182, -64, 60 ),
						GunAng = Angle( 0, -90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( 182, -55, 40 ),
						StAng = Angle( 90, 90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl" 
					};
					{
						Type = "Gunnerseat",
						Mdl = "models/nova/jeep_seat.mdl",
						LimitView = 60,
						Ang = Angle( 0,0,0 ),
						Pos =  Vector( 182, 35, 40 ),
						GunPos = Vector( 182, 64, 60 ),
						GunAng = Angle( 0, 90, 0 ),
						GunMdl = "models/weapons/hueym60/m60.mdl",
						StPos = Vector( 182, 55, 40 ),
						StAng = Angle( 90, -90, 180 ),
						StMdl = "models/props_trainstation/tracksign10.mdl" 
					};
	}
	
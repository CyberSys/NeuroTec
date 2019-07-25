ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "MQ8 Drone"
ENT.Author	= "Hoffa & Sillirion"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.HasMGun = true

ENT.RotorPropellerPos = Vector( -7, 0, 95 )
ENT.TailPropellerPos =  Vector( -189, 5, 69 )
ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
	
// Equipment
-- ENT.MachineGunModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_cannon.mdl"
ENT.MachineGunOffset = Vector( 116, -1, -36 )
ENT.CrosshairOffset = 0

ENT.RotorModel =  "models/mq8/mq8_rotor.mdl"
ENT.RotorModelTail = "models/mq8/mq8_tailrotor.mdl" 


ENT.Armament = {
				{ 
					PrintName = "Homing Drone"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 25, 60, 29), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 						// Ang, object angle
					Col = Color( 0, 0, 0, 0), 	
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 0.9, 											// Cooldown between weapons
					--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_jericho_drone",								// the object that will be created.
					
				}; 
				{ 
					PrintName = "Bitches dun know bout em easter eggs"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 25, -60, 29), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 	
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 0.9, 											// Cooldown between weapons
					isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_jericho_drone",								// the object that will be created.
					
				};
			}
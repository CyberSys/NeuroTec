ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "AH-64 Apache"
ENT.Author	= "Hoffa & Sillirion"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.HasMGun = true

-- ENT.HasChopperGun = true 

ENT.HelicopterPilotSeatPos = Vector( 94, 0, 1 )
ENT.HelicopterPassengerSeatPos = Vector( 150, 0, -10 ) 
ENT.RotorPropellerPos = Vector( 24, 0, 57 )
ENT.TailPropellerPos =  Vector( -345, 12, 86 )
ENT.HelicopterEngineSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
ENT.Mass = 50000000
ENT.TopRotorVal = 1000
-- // Equipment
ENT.MachineGunModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_cannon.mdl"
ENT.MachineGunOffset = Vector( 116, -1, -36 )
ENT.CrosshairOffset = -53

ENT.RotorModel =  "models/Apache/Rotormain.mdl"
ENT.RotorModelTail = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_tail.mdl" 


ENT.Armament = {
				{ 
					PrintName = "Swarm Rockets (Evasive Counter-Measure)"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 28, 95, -20), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 						// Ang, object angle
					Col = Color( 0, 0, 0, 0), 	
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 40, 											// Cooldown between weapons
					--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_swarmer",								// the object that will be created.
					BurstSize = 15
				}; 
				{ 
					PrintName = "Swarm Rockets (Evasive Counter-Measure)"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/lau-131 a.mdl",  		// model, used when creating the object
					Pos = Vector( 28, -95, -20), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 									// Ang, object angle
					Col = Color( 0, 0, 0, 0), 	
					Type = "Pod", 										// Type, used when creating the object
					Cooldown = 40, 											// Cooldown between weapons
					isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_swarmer",								// the object that will be created.
					BurstSize = 15
				};
				{ 
					PrintName = "AIM-9 Sidewinder"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
					Pos = Vector( 19, 81, -32), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 	
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 10, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				{ 
					PrintName = "AIM-132 ASRAAM"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/aim-132 asraam.mdl",  		// model, used when creating the object
					Pos = Vector( 19, -81, -32), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 	
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 10, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				{ 
					PrintName = "Python 5"		,		 			// print name, used by the interface
					Mdl = "models/hawx/weapons/python-5.mdl",  		// model, used when creating the object
					Pos = Vector( 19, 81, -16), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 									// Ang, object angle
					Col = Color( 255, 255, 255, 255), 	
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 10, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_rocket"								// the object that will be created.
				}; 
				{ 
					PrintName = "Python 5 \"Jericho\""		,		 		// print name, used by the interface
					Mdl = "models/hawx/weapons/python-5.mdl",  				// model, used when creating the object
					Pos = Vector( 19, -81, -5), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 								// Ang, object angle
					Col = Color( 255, 255, 255, 255), 	
					Type = "Homing", 										// Type, used when creating the object
					Cooldown = 20, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2a_jericho"								// the object that will be created.
				}; 
				{
					PrintName = "AGM-65 Maverick"		,		 			// print name, used by the interface
					Mdl = "models/Apache/weaponry/rocket.mdl",  		// model, used when creating the object
					Pos = Vector( 42, -70, -39), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 						// Ang, object angle
					Col = Color( 0, 0, 0, 0), 	
					Type = "Laser", 										// Type, used when creating the object
					Cooldown = 5, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_a2l_rocket",
					Damage = 700,
					Radius = 2000
				}; 
				{ 
					PrintName = "AGM-144 Hellfire"		,		 			// print name, used by the interface
					Mdl = "models/bf2/weapons/agm-114 hellfire/agm-114 hellfire.mdl",  		// model, used when creating the object
					Pos = Vector( 42, 69, -38), 							// Pos, Hard point location on the plane fuselage.
					Ang = Angle( -3, 0, 0), 								// Ang, object angle
					Col = Color( 0, 0, 0, 0), 	
					Type = "Singlelock", 										// Type, used when creating the object
					Cooldown = 5, 											// Cooldown between weapons
					isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_hellfire_missile",								// the object that will be created.
					Radius = 1500,
					Damage = 2900
				}; 
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
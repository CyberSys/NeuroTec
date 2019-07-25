ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Base Script for Neuroplanes"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Admin";
ENT.Spawnable	= false
ENT.AdminSpawnable = true

		//Server Side

-- Caracteristics	
ENT.PlaneMDL = "models/hawx/planes/saab-39 gripen.mdl"
ENT.NbSkins = 1
ENT.MaxVelocity = 3500
ENT.MinVelocity = 0
ENT.InitialHealth = 2500

ENT.BankingFactor = 2.4 --How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.

-- Equipment
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 2, 35, 26 )
ENT.CrosshairOffset = 26
ENT.MuzzleOffset = 55
ENT.EngineMux = {}

ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

-- Effects
ENT.ReactorPos = Vector( -409, 0, 74 )
ENT.FlamePos = Vector( -409, 0, 74 )
ENT.WingTrailPos = Vector( -358, 161, 65 )

-- Armament
ENT.Armament = {

					{ 
						PrintName = "AGM-130A"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-130a.mdl",  		// model, used when creating the object
						Pos = Vector( -302, 167, 66), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",								// the object that will be created.
						Damage = 400,
						Radius = 800
					}; 

					{ 
						PrintName = "AGM-130A"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/agm-130a.mdl",  		// model, used when creating the object
						Pos = Vector( -302, -167, 66), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",								// the object that will be created.
					}; 

					{ 
						PrintName = "AIM-120 AMRAAM", 
						Mdl = "models/hawx/weapons/aim-120 amraam.mdl",	 
						Pos = Vector( -263, 109, 45 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Homing",
						Cooldown = 15,
						--isFirst	= true,
						Class = "sent_a2a_rocket"
					};
					
					{ 
						PrintName = "AIM-120 AMRAAM", 
						Mdl = "models/hawx/weapons/aim-120 amraam.mdl",	 
						Pos = Vector( -263, -109, 45 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Homing",
						Cooldown = 15,
						isFirst	= false,
						Class = "sent_a2a_rocket"
					};

					{ 
						PrintName = "AGM-84 Harpoon", 
						Mdl = "models/hawx/weapons/agm-84 harpoon.mdl",	 
						Pos = Vector( -238, 71, 42 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Homing",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_a2a_rocket"
					}; 
					{ 
						PrintName = "AGM-84 Harpoon", 
						Mdl = "models/hawx/weapons/agm-84 harpoon.mdl",	 
						Pos = Vector( -238, -71, 42 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Homing",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_a2a_rocket"
					}; 

					{ 
						PrintName = "Drop Tank", 
						Mdl = "models/hawx/weapons/drop tank2.mdl",	 
						Pos = Vector( -230 , 0, 35 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Effect",
						Cooldown = 0,
						isFirst	= false,
						Class = "sent_a2a_rocket"
					};
					{
						PrintName = "ALQ-184 ECM",
						Mdl = "models/hawx/weapons/an alq 184.mdl",
						Pos = Vector( -103, 26, 35 ),
						Ang = Angle( 0, 0, 0 ),
						Type = "Flarepod",
						Cooldown = 0,
						isFirst = false,
						Class = ""
					};
				}


		//client side
	ENT.CamDist = 900
	ENT.CamUp = 250

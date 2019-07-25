ENT.Type 			= "vehicle"
ENT.Base 			= "base_anim"
ENT.PrintName		= "A-10 Thunderbolt II"
ENT.Author			= "Hoffa"
ENT.Category 		= "NeuroTec Aviation v2";
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.VehicleType 	= VEHICLE_PLANE
ENT.HasAfterburner	= false
ENT.HasCockpit		= true
--Server Side

-- Characteristics	
ENT.Model 			= "models/hawx/planes/a-10 thunderbolt ii.mdl" -- Model of choice
ENT.CockpitModel 	= "models/hawx/planes/cockpits/a-10 thunderbolt ii_cockpit.mdl"
ENT.CockpitPos 		= Vector( 0, 0, 99 )
ENT.NbSkins			= 2 									-- Number of model skins
ENT.MaxVelocity 	= 1.8 * 1510							-- use 1.8 * topspeed
ENT.MinVelocity 	= 0										
ENT.InitialHealth 	= 7000									
ENT.HealthVal 		= nil

ENT.Manoeuvrability = 8									-- Self explanatory
ENT.BankingFactor = 2.57									

--Sounds
ENT.esound = {}
ENT.esound[1] = "military/bf2_f15_throttle_loop.wav"		--Engine sound
ENT.esound[2] = "military/bf2_f15_throttle_stop.wav"		--Engine sound ending
ENT.esound[3] = "military/bf2_f15_afterburner_loop.wav"		--Afterburner sound
ENT.esound[4] = "military/bf2_f15_afterburner_stop.wav"		--Afterburner sound ending

-- Equipment
ENT.SeatPos = Vector( 161, 0, 100 )						-- Cockpit seat position local to the plane.
ENT.SeatAngle = Vector( 5, 0, 0 )
ENT.MachineGunModel = "models/airboatgun.mdl"				-- Minigun model to use. Use models/airboatgun.mdl if you want muzzle flash.
ENT.MachineGunOffset = Vector( 255, 0, 67 )					-- Machinegun position local to the plane.
ENT.CrosshairOffset = -167									-- Height Adjustment for crosshair. This value should be the same as the Z coordinate in ENT.MachineGunOffset.

ENT.MachineGunMuzzle = "a10_muzzlesmoke"					-- Muzzle sprite or fx to use
ENT.MachineGunTracer = "AirboatGunHeavyTracer"				-- Tracer to use
ENT.MachineGunImpactFX = "HelicopterMegaBomb"

ENT.FlareCooldown = 15										-- Counter-measure cooldown in seconds when the magazine is empty
ENT.FlareCount = 20											-- Current flare loadout
ENT.MaxFlares = 20											-- Max capacity in each magazine

ENT.Destroyed = false										-- Determines if we're still in business.
ENT.DeathTimer = 0											-- Upon destruction this variable will increase each frame. Once the maximum value is reached the plane will be removed.
ENT.Burning = false											-- Emit smoke puffs?
ENT.Speed = 0												
ENT.Pitch = 0
ENT.Yaw = 0
ENT.Roll = 0

ENT.maxG = 0
ENT.Drift = 1

ENT.LastUseKeyDown = nil

		
		
-- Effects
ENT.HasPostCombustion = true
ENT.ReactorPos = { Vector( -200, -56, 125 ), Vector( -200, 56, 125 ) }
ENT.FlamePos = Vector( -50, 0, 75 )
ENT.WingTrailPos = Vector( -68, 317, 110 ) --,Vector( -68, 317, 110 ) }
ENT.TrailPos = { Vector( -76, -335, 104 ), Vector( -76, 335, 104 ) }


-- Armament
ENT.GunPos = Vector( 255, 0, 67 )	
ENT.MuzzleOffset = 260
ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1
ENT.Armament = {

					{ 
						PrintName = "Aim-9 Sidewinder [1]"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -13, -229, 77), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 								// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 

					{ 
						PrintName = "Aim-9 Sidewinder [2]", 						// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -13, 229, 77), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= nil,										// Secondary rocket. 
						Class = "sent_a2a_rocket"
					}; 

					{ 
						PrintName = "AGM-65 Maverick", 
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",	 
						Pos = Vector( -14, -187, 67 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Singlelock", 										// Type, used when creating the object
						Cooldown = 3, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_hellfire_missile",								// the object that will be created.
						Radius = 1024,
						Damage = 2500
					};
					
					{ 
						PrintName = "AGM-65 Maverick", 
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",	 
						Pos = Vector( -14, 187, 67 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Singlelock", 										// Type, used when creating the object
						Cooldown = 3, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_hellfire_missile",								// the object that will be created.
						Radius = 1024,
						Damage = 2500
					};

					{ 
						PrintName = "LAU-131A Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( -13, -139, 62 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Pod",
						Cooldown = 0.5,
						--isFirst	= true,
						Class = "sent_a2s_dumb",
						BurstSize = 2
					}; 

					{ 
						PrintName = "LAU-131A Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( -13, 139, 62 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Pod",
						Cooldown = 8,
						isFirst	= false,
						Class = "sent_a2s_dumb",
						BurstSize = 2
					}; 					

					{ 
						PrintName = "CBU-100 Clusterbomb", 
						Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
						Pos = Vector( -10, -63, 57 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_mk82",
					}; 
					
					{ 
						PrintName = "CBU-100 Clusterbomb", 
						Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
						Pos = Vector( -10, 63, 57 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_mk82",
					}; 		

					{ 
						PrintName = "GBU-12 Paveway II", 
						Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
						Pos = Vector( 0, -17, 57 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_mk82"
					}; 
					
					{ 
						PrintName = "GBU-12 Paveway II", 
						Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
						Pos = Vector( 0, 17, 57 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 0,
						isFirst	= false,
						Class = "sent_mk82"
					}; 	

					{ 
						PrintName = "Sniper XR-ATP", 
						Mdl = "models/hawx/weapons/sniper xr-atp.mdl",	 
						Pos = Vector( -18, 0, 57 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Effect",
						Cooldown = 0,
						isFirst	= nil,
						Class = ""
					}; 
					{
						PrintName = "ALQ-131 ECM",
						Mdl = "models/hawx/weapons/alq 131 ecm.mdl",
						Pos = Vector( -145, 0, 129 ),
						Ang = Angle( 0, 0, 0 ),
						Type = "Flarepod",
						Cooldown = 0,
						isFirst = nil,
						Class = ""
					};
				}


	--Client side
ENT.CamDist = 800
ENT.CamUp = 130

-- Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil

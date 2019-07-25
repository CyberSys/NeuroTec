ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Gloster Meteor"
ENT.Author	= "Hoffa, StarChick, Silliron"
ENT.Category 		= "NeuroTec Warbirds";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_WARBIRD

ENT.Model = "models/fsx/warbirds/Gloster Meteor.mdl"
//Speed Limits
ENT.MaxVelocity = 1.8 * 965
ENT.MinVelocity = 0

ENT.TrailPos = {Vector( -25, 222, 2 ),Vector( -25, -222, 2 ) }
ENT.EngineSounds = { "ambient/atmosphere/station_ambience_stereo_loop1.wav", "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", "ambient/levels/canals/dam_water_loop2.wav" }
ENT.MinigunPos = { Vector( 134, 21, 8.5 ), Vector( 134, -21, 8.5 ), Vector( 134, 21, -4.5 ), Vector( 134, -21, -4.5 ) }
ENT.MinigunSound = "IL-2/gun_17_22.mp3"
ENT.FireTrailPos = { Vector( -27, 92, -11 ), Vector( -27, -92, -11 ) }


ENT.CamDist = 600
ENT.CamUp = 100
ENT.CockpitCameraPos = Vector( 119, 1, 30 )
ENT.ExhaustPositions = { Vector( -27, 92, -11 ), Vector( -27, -92, -11 ) }


// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 2.4

ENT.InitialHealth = 2750
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0
-- 
ENT.Armament = {
					
					{ 
						PrintName = "RP-3 Rocket",
						Mdl = "models/hawx/weapons/zuni mk16.mdl" ,
						Pos = Vector( 16, 160, -9), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.5, 										// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_R4M_rocket"
					}; 	
					{ 
						PrintName = "RP-3 Rocket",
						Mdl = "models/hawx/weapons/zuni mk16.mdl" ,
						Pos = Vector( 16, -160, -9), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.5, 										// Cooldown between weapons
						-- isFirst	= false,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_R4M_rocket"
					}; 					
					{ 
						PrintName = "RP-3 Rocket",
						Mdl = "models/hawx/weapons/zuni mk16.mdl" ,
						Pos = Vector( 16, 176, -7), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.5, 										// Cooldown between weapons
						--isFirst	= true,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_R4M_rocket"
					}; 					
					{ 
						PrintName = "RP-3 Rocket",
						Mdl = "models/hawx/weapons/zuni mk16.mdl" ,
						Pos = Vector( 16, -176, -7), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.5, 										// Cooldown between weapons
						-- isFirst	= false,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_R4M_rocket"
					}; 					
					{ 
						PrintName = "RP-3 Rocket",
						Mdl = "models/hawx/weapons/zuni mk16.mdl" ,
						Pos = Vector( 16, 192, -5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.5, 										// Cooldown between weapons
						--isFirst	= true,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_R4M_rocket"
					}; 					
					{ 
						PrintName = "RP-3 Rocket",
						Mdl = "models/hawx/weapons/zuni mk16.mdl" ,
						Pos = Vector( 16, -192, -5), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								// Ang, object angle
						Type = "Dumb", 										// Type, used when creating the object
						Cooldown = 0.5, 										// Cooldown between weapons
						-- isFirst	= false,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_R4M_rocket"
					}; 					
		
				}
				
// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 20, 60, 45 )
ENT.CrosshairOffset = 45

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.04



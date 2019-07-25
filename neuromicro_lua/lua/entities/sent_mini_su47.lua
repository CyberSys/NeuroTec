ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Su-47 Berkut"
ENT.Author	= "Radek"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 400
ENT.ControlSurfaces  = {
	Elevator = {
				{	
					Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_elevator_l.mdl", 
					Pos = Vector( -27, 14, 4.47 ),
					Ang = Angle( 0,0,0 )
				};
				{	
					Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_elevator_r.mdl", 
					Pos = Vector( -32.1, -14, 4.4 ),
					Ang = Angle( 0,0,0 )
				};

			},
	Rudder = {	
				{	
					Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_rudder_l.mdl",
					Pos = Vector(-23,13.3,14.6),
					Ang = Angle( 11.2,0,-6.8 )
				};
			
				{	
					Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_rudder_r.mdl",
					Pos = Vector(-23,-12.95,14.6),
					Ang = Angle( 11.2,0,6.8 )
				};
			}; 
			
	Ailerons = {
			{
			Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_aileron_l.mdl",
			Pos = Vector(-13.3,38.2,4.45),
			Ang = Angle( 0,-32.9,0 )
			};
			{
			Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_aileron_r.mdl",
			Pos = Vector(-13.3,-37.7,4.45),
			Ang = Angle( 0,32.9,0 )
			};
		};
	Flaps = {
			{
			Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_canard_l.mdl",
			Pos = Vector(4.7,13,4.8),
			Ang = Angle( 0,0,0 )
			};
			{
			Mdl = "models/radek/neuroplanes/rus/su47_berkut/su47_canard_r.mdl",
			Pos = Vector(4.7,-13,4.8),
			Ang = Angle( 0,0,0)
			};
	
		};
}
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 60, 18.35, 0.25 ),
			Ang = Angle(),
			Scale = 0.03
		};
		Compass = {
			Pos = Vector( 60, 7.5, -4.75 ),
			Ang = Angle(),
			Scale = 0.02
		};		
		FuelCounter = {
			Pos = Vector( 60, 7.5, 0.25 ),
			Ang = Angle(),
			Scale = 0.02
		};
		VSpeed = {
			Pos = Vector( 60, 2, -5.25 ),
			Ang = Angle(),
			Scale = 0.018
		};
		Clock = {
			Pos = Vector( 60, -5, -.5 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Altimeter = {
			Pos = Vector( 60, 8.5, -15.5 ),
			Ang = Angle(0,0,-40),
			Scale = 0.021
		};
		Airspeed = {
			Pos = Vector( 60, 2.0, -.5),
			Ang = Angle(),
			Scale = 0.018
		};
		Throttle = {
			Pos = Vector( 60, 4, -10 ),
			Ang = Angle(0,0,-40),
			Scale = 0.04
		};	
		EngineTemp = {
			Pos = Vector( 60, -5, -4.5 ),
			Ang = Angle(0,0,-0),
			Scale = 0.015
		};
	}
ENT.CockpitModel = ""

ENT.Model 			= "models/radek/neuroplanes/rus/su47_berkut/su47_body.mdl"
ENT.TailModel 		= "models/radek/neuroplanes/rus/su47_berkut/su47_tail.mdl"
ENT.WingModels 		= { "models/radek/neuroplanes/rus/su47_berkut/su47_wing_l.mdl", 
						"models/radek/neuroplanes/rus/su47_berkut/su47_wing_r.mdl" }
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl","models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailPos			= Vector( -21.7, 0, 0)
ENT.WingPositions 	= {  Vector( -25,13.7,0.5 ),
						Vector( -20.5,-13.7,4.7 ) }
						
ENT.PropellerAttachedToWings = false 
ENT.PropellerPos 	= { Vector( -40, -5, 2.8 ), Vector( -40, 5, 2.8 )  }
ENT.HideProp = true
ENT.PropellerFireOffset = 32

--- Physics                                                                          
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 7300 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 6800 	-- how fast we drop speed
ENT.RudderMultiplier = 23 			-- how much we turn 
ENT.PitchValue = 11					-- how fast we rise / dive
ENT.AutoRollYawFactor = 210			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 37		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 3*60			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 1050			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 7.5					-- momentum damping
ENT.AngDamping = 6.4					-- angular momentum damping
ENT.PropForce = 125					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 11					-- Propeller Phys Obj Mass
ENT.BankForce = 750					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2550				-- Wheel weight
ENT.BankForceDivider = 1.5
ENT.PitchForceDivider = 2.7
ENT.YawForceDivider = 0.7
ENT.OverrideWeldStrenght = 0
ENT.CanSteerAtLowVelocity = false
ENT.SuperFlaps = false 


-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.9 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 30 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.PhysicalAmmo = false
-- ENT.MeanFuckingCannon = true
-- ENT.MeanCannonSonicSound = "micro/gau8_humm2.wav"
-- ENT.MeanCannonSonicSoundEnd = { "micro/gau8_humm4.wav", "micro/gau8_humm5.wav", "micro/gau8_humm6.wav" }

-- ENT.NoSecondaryWeapons = true
-- ENT.BurstSize = 3
-- ENT.RoundsPerSecond = 1
-- ENT.BurstDuration = 0.08

ENT.TracerScale1 = 0.05
ENT.TracerScale2 = 0.05
ENT.ImpactScale = 1
ENT.TracerGlowProxy = .5

ENT.NoLockon = false
ENT.PrimaryCooldown = 0.3
ENT.MuzzleOffset = 85
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 250
ENT.MaxDamage = 350
ENT.Radius = 16
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = "wt/guns/ho103_loop.wav" 
-- ENT.PrimaryStopSound = "micro/gau8_end_test.wav"
ENT.ContigiousFiringLoop = true
ENT.MegaMuzzle = true 


-- ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( 0, 6, -1 ) }
ENT.PrimaryMaxShots = 10

-- End of weapons

-- Visuals
ENT.CameraDistance = 165
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 27, 0.2, 7.8 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 2 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = 1

ENT.ExhaustPos = { 
Vector( -54,4,3 ), Vector( -54,-4,5 )
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"physics/metal/canister_scrape_smooth_loop1.wav",
	"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav",
	"lockon/A10AroundEngine.mp3"
	} 

-- Additional variables for using shells in ammo table
ENT.BombSound = "wt/guns/bk37_singleshot_1.wav" -- if LaunchSound isnt working in the armament table, use this as fallback.
ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT._2ndRecoilAngle = 1
ENT.TracerScale1  = 0.12
ENT.TracerScale2 = 0.1
ENT.TracerGlowProxy = 1 
ENT.ArmamentAttachedToWings = true 
ENT.FatRecoil = true
ENT.RecoilForce = -600000 --- Units/s force
ENT.RecoilAngle = 3.05 -- Degrees up on pitch axis
ENT.RecoilDuraiton = 0.059 -- Seconds
ENT.MoveExhaustWithElevator = false 

ENT.ArmamentDamageSystem = true
ENT.Armament = {



					{ 
						PrintName = "GBU-12 Paveway II",
						Mdl = "models/starchick971/hawx/weapons/gbu-12 paveway-ii.mdl" ,
						Pos = Vector( -14, -5.75, -2.5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 5, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "wt/misc/bomb_drop.wav"
					}; 	
					
					{  
						PrintName = "GBU-12 Paveway II",
						Mdl = "models/starchick971/hawx/weapons/gbu-12 paveway-ii.mdl" ,
						Pos = Vector( -14, 5.75, -2.5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "wt/misc/bomb_drop.wav"
					}; 	
					
					{  
						PrintName = "AGM-84 Harpoon",
						Mdl = "models/starchick971/hawx/weapons/agm-84 harpoon.mdl" ,
						Pos = Vector( -14, 18, 2), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2.5, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 	
					{  
						PrintName = "AGM-84 Harpoon",
						Mdl ="models/starchick971/hawx/weapons/agm-84 harpoon.mdl" ,
						Pos = Vector( -14, -18, 2), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2.5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					};  	
					
					{  
						PrintName = "Air-to-Ground Missile",
						Mdl = "models/starchick971/hawx/weapons/agm-65 maverick.mdl" ,
						Pos = Vector( -14, 28, 2), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Singlelock",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
					--	-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 	
					{  
						PrintName = "Air-to-Ground Missile",
						Mdl ="models/starchick971/hawx/weapons/agm-65 maverick.mdl" ,
						Pos = Vector( -14, -28, 2), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Singlelock",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
						-- -- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 	

					--{ 
						--PrintName = "Napalm",
						--Mdl = "models/starchick971/hawx/weapons/drop tank.mdl" ,
						--Pos = Vector( -4, 0, -4.7), 							-- Pos, Hard point location on the plane fuselage.
						--Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						--Type = "Bomb",						-- Type, used when creating the object
						--BurstSize = 1,
						--Cooldown = 15, 										-- Cooldown between weapons
						--isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						--Class = "sent_mini_napalm",
						-- Color = Color( 0,0,0,0 ),
						--LaunchSound = "wt/misc/bomb_drop.wav"
					--}; 	
					
				};
if( SERVER ) then
 
        AddCSLuaFile(  )
        function ENT:SpawnFunction( ply, tr, class )
                local SpawnPos =  ply:GetPos() + ply:GetUp() * 512
                local ent = ents.Create( class )
                ent:SetPos( SpawnPos )
                ent:SetAngles( ply:GetAngles() )
                ent:Spawn()
                ent:Activate()
                -- constraint.Weld( ent, game.GetWorld(), 0,0,0, true )
                timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
                if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
                        ent:AddAdminEquipment()
                end
 
                return ent
        end
        function ENT:Initialize() self:CivAir_DefaultInit() end
        function ENT:UpdateTransmitState()      return TRANSMIT_ALWAYS end
        function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
        function ENT:OnRemove() self:CivAir_OnRemove() end
        function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
        function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
        function ENT:Think() end
       
        function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
        function ENT:SecondaryAttack( wep, id ) if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
        function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime )
       
                self:JetAir_Think()
                self:GetPhysicsObject():AddAngleVelocity( Vector( -7, 0, 2 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) )
       
        end
 
end
        util.PrecacheModel( ENT.CockpitModel )
if( CLIENT ) then
 
        function ENT:Initialize() self:CivAir_CInit() end
        function ENT:Think()end
        function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
        function ENT:Draw()
                self:DrawModel()
                self:CivAir_Draw()
        end
        function ENT:OnRemove()
        end
end
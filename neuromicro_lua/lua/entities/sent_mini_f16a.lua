ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "F-16A Fighting Falcon"
ENT.Author	= "Radek"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 400
ENT.ControlSurfaces  = {
	Elevator = {
				{	
					Mdl = "models/radek/neuroplanes/US/F-16A/f16a_elevator_l.mdl", 
					Pos = Vector( -24.7, 6, 0.8 ),
					Ang = Angle( 0,0,0 )
				};
				{	
					Mdl = "models/radek/neuroplanes/US/F-16A/f16a_elevator_r.mdl", 
					Pos = Vector( -25.4, -6, 0.8 ),
					Ang = Angle( 0,0,0 )
				};

			},
	Rudder = 	{	
					Mdl = "models/radek/neuroplanes/US/F-16A/f16a_rudder.mdl",
					Pos = Vector(-24.5,0,13.6),
					Ang = Angle( 20,0,0 )
				};
			 
			
	Ailerons = {
			{
			Mdl = "models/radek/neuroplanes/US/F-16A/f16a_aileron_l.mdl",
			Pos = Vector(-18,13.5,9.3),
			Ang = Angle( 0,12,0 )
			};
			{
			Mdl = "models/radek/neuroplanes/US/F-16A/f16a_aileron_r.mdl",
			Pos = Vector(-18,-14.5,9.3),
			Ang = Angle( 0,-9,0 )
			};
		};
}
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 60, 18.35, 1.25 ),
			Ang = Angle(),
			Scale = 0.03
		};
		Compass = {
			Pos = Vector( 60, 7.5, -3.75 ),
			Ang = Angle(),
			Scale = 0.02
		};		
		FuelCounter = {
			Pos = Vector( 60, 7.5, 1.25 ),
			Ang = Angle(),
			Scale = 0.02
		};
		VSpeed = {
			Pos = Vector( 60, 2, -4.25 ),
			Ang = Angle(),
			Scale = 0.018
		};
		Clock = {
			Pos = Vector( 60, -5, -1.5 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Altimeter = {
			Pos = Vector( 60, 8.5, -15.5 ),
			Ang = Angle(0,0,-40),
			Scale = 0.021
		};
		Airspeed = {
			Pos = Vector( 60, 2.0, -1.5),
			Ang = Angle(),
			Scale = 0.018
		};
		Throttle = {
			Pos = Vector( 60, 4, -10 ),
			Ang = Angle(0,0,-40),
			Scale = 0.04
		};	
		EngineTemp = {
			Pos = Vector( 60, -5, -3.5 ),
			Ang = Angle(0,0,-0),
			Scale = 0.015
		};
	}
ENT.CockpitModel = ""

ENT.Model 			= "models/radek/neuroplanes/US/F-16A/f16a_body.mdl"
ENT.TailModel 		= "models/radek/neuroplanes/US/F-16A/f16a_tail.mdl"
ENT.WingModels 		= { "models/radek/neuroplanes/US/F-16A/f16a_wing_l.mdl", 
						"models/radek/neuroplanes/US/F-16A/f16a_wing_r.mdl" }
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl","models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailPos			= Vector( -12, 0, 8.45)
ENT.WingPositions 	= {  Vector( -13,6.1,9.35 ),
						Vector( -13.2,-6.1,9.35 ) }
						
ENT.PropellerAttachedToWings = false 
ENT.PropellerPos 	= { Vector( -37, 0, 8 ) }
ENT.HideProp = true
ENT.PropellerFireOffset = 32

--- Physics                                                                          
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 7300 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 6800 	-- how fast we drop speed
ENT.RudderMultiplier = 12 			-- how much we turn 
ENT.PitchValue = 5					-- how fast we rise / dive
ENT.AutoRollYawFactor = 210			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 300		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 3*60			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 1050			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.2					-- momentum damping
ENT.AngDamping = 5.7					-- angular momentum damping
ENT.PropForce = 125					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 11					-- Propeller Phys Obj Mass
ENT.BankForce = 2*3200					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2550				-- Wheel weight
ENT.BankForceDivider = 1.1
ENT.PitchForceDivider = 2.9
ENT.YawForceDivider = 1.8
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
ENT.PrimaryShootSound = "wt/guns/cannon_t_160_loop.wav" 
-- ENT.PrimaryStopSound = "micro/gau8_end_test.wav"
ENT.ContigiousFiringLoop = true
ENT.MegaMuzzle = true 


-- ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( 0, 0, 2 ) }
ENT.PrimaryMaxShots = 10

-- End of weapons

-- Visuals
ENT.CameraDistance = 130
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 19.3, 0, 14 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 2 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = 1

ENT.ExhaustPos = Vector( -47,0,3 )

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

ENT.ArmamentDamageSystem = false
ENT.Armament = {
				
					{  
						PrintName = "AGM-84 Harpoon",
						Mdl = "models/starchick971/hawx/weapons/agm-84 harpoon.mdl" ,
						Pos = Vector( -14, 18, 7), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -14, -18, 7), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -14, 24, 7), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -14, -24, 7), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Singlelock",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
						-- -- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					};
					{ 
						PrintName = "Python-5",
						Mdl = "models/starchick971/hawx/weapons/python-5.mdl" ,
						Pos = Vector( -12, -11, 7), 							-- Pos, Hard point location on the plane fuselage.
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
						PrintName = "Python-5",
						Mdl = "models/starchick971/hawx/weapons/python-5.mdl" ,
						Pos = Vector( -12, 11, 7), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2.5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 						
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
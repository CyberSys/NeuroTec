ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Saab J-35 Draken"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro";
ENT.Country = "Sweden"
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 500
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 35, 2.5, -2 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Compass = {
			Pos = Vector( 35, 4.5, -2.25 ),
			Ang = Angle(),
			Scale = 0.008
		};
		VSpeed = {
			Pos = Vector( 35, -.5, -2.25 ),
			Ang = Angle(),
			Scale = 0.008
		};		
		Airspeed = {
			Pos = Vector( 35, -.5, -4.35 ),
			Ang = Angle(),
			Scale = 0.008
		};
		Clock = {
			Pos = Vector( 35, 4.5, -5.0 ),
			Ang = Angle(),
			Scale = 0.005
		};	
		Throttle = {
			Pos = Vector( 35, 3.8, -4.5 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Altimeter = {
			Pos = Vector( 35, 2.55, -5.25 ),
			Ang = Angle(),
			Scale = 0.01
		}
	}
	
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_elevator.mdl", 
			Pos = Vector(-33.5,0,-3), --Vector(-10.5,0,-0.5 ),
			Ang = Angle( 0,0,0 )
			};  
	Rudder = 
			{	
				Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_rudder.mdl",
				Pos = Vector(-41,00,7.5 ), --Pos = Vector(-9.5,20.5,7.5),
				Ang = Angle( 0,0,0 )
			};
			
			
	Ailerons = {
			{
			Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_aileron_l.mdl",
			Pos = Vector( -30.5, 0, -4 ), --Pos = Vector(-10,47,0),
			Ang = Angle( 0,10,0 )
			};
			{
			Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_aileron_r.mdl",
			Pos = Vector( -30.5, 0, -4	), --Pos = Vector(-10,-47,0),
			Ang = Angle(0,-10,0)
			};


		};
	Flaps = {
			{
			Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_flap_l1.mdl",
			Pos = Vector(-30.2,0.3,-3.75 ), --Pos = Vector(-11,14,-2),
			Ang = Angle( 0,10,0 )
			};
			{
			Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_flap_r1.mdl",
			Pos = Vector( -30.2,-0.3,-3.75 ), --Pos = Vector(-11,-14,-2),
			Ang = Angle( 0,-10,0 )
			};
			-- {
			-- Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_flap_l2.mdl",
			-- Pos = Vector(-34.2,0.3,-3.75 ), --Pos = Vector(-11,14,-2),
			-- Ang = Angle( 0,0,0 )
			-- };
			-- {
			-- Mdl = "models/hoffa/neuroplanes/sweden/saab/draken_flap_r2.mdl",
			-- Pos = Vector( -34.2,-0.3,-3.75 ), --Pos = Vector(-11,-14,-2),
			-- Ang = Angle( 0,0,0 )
			-- };
			
			
			
		};
}
ENT.OverrideWeldStrenght = 90000000

ENT.ArmamentDamageSystem = true 
ENT.Armament = {
					{ 
						PrintName = "Python-5",
						Mdl = "models/starchick971/hawx/weapons/python-5.mdl" ,
						Pos = Vector( -26, -25.75, -5), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -26, 25.75, -5), 							-- Pos, Hard point location on the plane fuselage.
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
						PrintName = "AGM-84 Harpoon",
						Mdl = "models/starchick971/hawx/weapons/agm-84 harpoon.mdl" ,
						Pos = Vector( -18, -18.5, -6.5), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -18, 18.5, -6.5), 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl = "models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos = Vector( 0, -11, -6.7), 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos = Vector( 0, 11, -6.7), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Singlelock",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
						-- -- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 				
					
				};
ENT.Model 			= "models/hoffa/neuroplanes/sweden/saab/draken_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/sweden/saab/draken_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/sweden/saab/draken_wing_l.mdl", 
						"models/hoffa/neuroplanes/sweden/saab/draken_wing_r.mdl" }
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailAttachedToWings = true 
ENT.TailPos			= Vector( 0, 0, 0 )
ENT.WingPositions 	= { Vector(0,0,0),Vector(0,0,0) }
						
ENT.PropellerAttachedToWings = false 
ENT.PropellerPos 	= { Vector( -40, -0, -1 )  }
ENT.PropellerFireOffset = 2

--- Physics                                                                          
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 10000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 9500 	-- how fast we drop speed
ENT.RudderMultiplier = 25 			-- how much we turn 
ENT.PitchValue = 45					-- how fast we rise / dive
ENT.AutoRollYawFactor = 170			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 1000		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 59			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 2124			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 11					-- Propeller Phys Obj Mass
ENT.BankForce = 2220					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 2.5
ENT.PitchForceDivider = .9
ENT.YawForceDivider = 0.3

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 30 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.PhysicalAmmo = true
-- ENT.MeanFuckingCannon = false
-- ENT.MeanCannonSonicSound = "micro/gau8_humm2.wav"
-- ENT.MeanCannonSonicSoundEnd = { "micro/gau8_humm4.wav", "micro/gau8_humm5.wav", "micro/gau8_humm6.wav" }

-- ENT.NoSecondaryWeapons = true
ENT.BurstSize = 3
ENT.RoundsPerSecond = 1
ENT.BurstDuration = 0.08

ENT.TracerScale1 = 0.05
ENT.TracerScale2 = 0.05
ENT.ImpactScale = 1
ENT.TracerGlowProxy = .5

ENT.NoLockon = false
ENT.PrimaryCooldown = 0.025
ENT.MuzzleOffset = 85
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 40
ENT.MaxDamage = 80
ENT.Radius = 12
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = "wt/guns/type97_gun.wav" 
-- ENT.PrimaryStopSound = "micro/gau8_end_test.wav"
ENT.ContigiousFiringLoop = true
-- ENT.MegaMuzzle = true 


-- ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( 5, 4, -2.5 ) } --, Vector( 16, 2.5, 2.35 ),Vector( 16, -2.5, 2.35 ) }
ENT.PrimaryMaxShots = 25

-- End of weapons
ENT.StartupSound = ""

-- Visuals
ENT.CameraDistance = 125
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 27.5, 0, 0.0 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 2 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = 1

ENT.ExhaustPos = { 
Vector( -50,0,-1.7 ) 
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"physics/metal/canister_scrape_smooth_loop1.wav",
	"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav",
	"lockon/A10AroundEngine.mp3"
	}

-- Additional variables for using shells in ammo table
ENT.BombSound = "wt/guns/50mm_shot.wav" -- if LaunchSound isnt working in the armament table, use this as fallback.
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

-- ENT.ArmamentDamageSystem = true 
-- ENT.Armament = {

				-- };
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 555
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
	function ENT:Initialize() 
	
		self:CivAir_DefaultInit()
		
		constraint.NoCollide( self.Wings[1], self.Tail, 0,0 )
		constraint.NoCollide( self.Wings[2], self.Tail, 0,0 )
		
		
	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think()  
		self:JetAir_Think()
		self:SonicBoomTicker()
		self:NextThink( CurTime()-1)
	end
	
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
	
	
		self:GetPhysicsObject():AddAngleVelocity( Vector( 25, -25, .8)  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end
if( CLIENT ) then 
	

	function ENT:Initialize() 
		
		self:CivAir_CInit() 

	end
	function ENT:Think()
	
		
	end
	
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() 
		self:DrawModel()
		self:CivAir_Draw() 
	end
	function ENT:OnRemove()
	end
end

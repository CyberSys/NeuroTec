ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "AV-8B Harrier II"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro";
ENT.Country = "UK"
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 400
ENT.ControlSurfaces  = {
	Elevator = {
				{		
					Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_elevator_1.mdl", 
					Pos = Vector(-49.5,-2, 12.5 ), --Vector(-10.5,0,-0.5 ),
					Ang = Angle( -5,-22,15 )
				};
				{		
					Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_elevator_2.mdl", 
					Pos = Vector(-49.5,2,12.5 ), --Vector(-10.5,0,-0.5 ),
					Ang = Angle( 15,25,-15 )
				};
			};  
	Rudder = 
			{	
				Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_rudder.mdl",
				Pos = Vector(-52, -0.45,15 ), --Pos = Vector(-9.5,20.5,7.5),
				Ang = Angle( 12,0,0 )
			};
			
			
	Ailerons = {
			{
			Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_aileron_l.mdl",
			Pos = Vector( -20.5, 20, 8 ), --Pos = Vector(-10,47,0),
			Ang = Angle( 0,10,0 )
			};
			{
			Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_aileron_r.mdl",
			Pos = Vector( -20.5, -20, 8	), --Pos = Vector(-10,-47,0),
			Ang = Angle(0,-10,0)
			};


		};
	Flaps = {
			{
			Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_flap_r.mdl",
			Pos = Vector(-16,-6,11 ), --Pos = Vector(-11,14,-2),
			Ang = Angle( 5,-15,11 )
			};
			{
			Mdl = "models/hoffa/neuroplanes/british/harrier/harrier_flap_l.mdl",
			Pos = Vector( -16,6,11  ), --Pos = Vector(-11,-14,-2),
			Ang = Angle( 5,15,-11 )
			};
			
		};
}
ENT.OverrideWeldStrenght = 90000000




ENT.ArmamentDamageSystem = true 
ENT.Armament = {
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos = Vector( -15, -31, 4 ), 							-- Pos, Hard point location on the plane fuselage.
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
						PrintName = "Air-to-Air",
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos = Vector( -15, 31, 4 ), 							-- Pos, Hard point location on the plane fuselage.
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
						PrintName = "Air-to-Air",
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos = Vector( -11, -25, 5 ), 							-- Pos, Hard point location on the plane fuselage.
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
						PrintName = "Air-to-Air",
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos = Vector( -11, 25, 5 ), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -7, -15, 6 ), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( -7, 15, 6 ), 							-- Pos, Hard point location on the plane fuselage.
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
ENT.Model 			= "models/hoffa/neuroplanes/british/harrier/harrier_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/british/harrier/harrier_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/british/harrier/harrier_wing_l.mdl", 
						"models/hoffa/neuroplanes/british/harrier/harrier_wing_r.mdl" }
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailAttachedToWings = true 
ENT.TailPos			= Vector( 0, 0, 0 )
ENT.WingPositions 	= { Vector(0,0,0),Vector(0,0,0) }
						
ENT.PropellerAttachedToWings = false 
ENT.PropellerPos 	= { Vector( 10, -0, 7 )  }
ENT.PropellerFireOffset = 2

--- Physics                                                                          
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 10	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 11000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 9500 	-- how fast we drop speed
ENT.RudderMultiplier = 9 			-- how much we turn 
ENT.PitchValue = 7					-- how fast we rise / dive
ENT.AutoRollYawFactor = 170			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 74		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 255			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 1524			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 11					-- Propeller Phys Obj Mass
ENT.BankForce = 1200					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 2.5
ENT.PitchForceDivider = 4.9
ENT.YawForceDivider = 2

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics
ENT.VTOL = true 
ENT.VTOLTailLiftMultiplier = 0.68
ENT.VTOLLiftSpeed = 0.00851 -- 1.0 = full effect, 0.0 = no effect.
ENT.VTOLSteerForce = .35 -- default .15 
-- ENT.NoTailLift = true 



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
ENT.MinigunPos = {  Vector( -5, 4, 4.5 ) } --, Vector( 16, 2.5, 2.35 ),Vector( 16, -2.5, 2.35 ) }
ENT.PrimaryMaxShots = 25

-- End of weapons
ENT.StartupSound = ""

-- Visuals
ENT.CameraDistance = 165
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 24.5, 0, 12.5 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 2 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = 1

ENT.ExhaustPos = { 
Vector( -1, 9, 7 ),
Vector( -14, 8, 7 ),
Vector( -1, -9, 7 ),
Vector( -14, -8, 7 )
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
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 55
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		-- 
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
		
		self:GetPhysicsObject():AddAngleVelocity( Vector(  0,0,5 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
		
		-- if( self.EngineStarted && self.VTOL && self.) then 
			
			-- self:GetPhysicsObject():AddAngleVelocity( Vector( 0,-600 ,  0 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
		
		
		-- end 
		-- 
	
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

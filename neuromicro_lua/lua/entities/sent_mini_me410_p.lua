ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "ME-410 \'The Dragoneel\'"
ENT.Author	= "Hoffa / Killstr3aKs"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.PropellerAttachedToWings = true

ENT.FatRecoil = true
ENT.RecoilForce = -600000 --- Units/s force
ENT.RecoilAngle = 17.05 -- Degrees up on pitch axis
ENT.RecoilDuraiton = 0.059 -- Seconds

ENT.InitialHealth = 600
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/german/me_410_elevators.mdl", 
			Pos = Vector(-65.7,0,7 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/german/me_410_rudder.mdl",
			Pos = Vector(-63.6,0,16.25),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/me_410_aileron_l.mdl",
			Pos = Vector(-6,49,3),
			Ang = Angle( 0,-10,6 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/me_410_aileron_r.mdl",
			Pos = Vector(-6,-49,3),
			Ang = Angle( 0,10,-6 )
			};
		};
		
	Flaps = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/me_410_flap_l.mdl",
			Pos = Vector(-11.7,14.5,-1.1),
			Ang = Angle( 0,-7.8,5.2 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/me_410_flap_r.mdl",
			Pos = Vector(-11.7,-14.5,-1.1),
			Ang = Angle( 0,7.8,-5.2)
			};
		};
	
}
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 35, 9.5, 2.65 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Compass = {
			Pos = Vector( 35, 10.5, 0 ),
			Ang = Angle(),
			Scale = 0.01
		};		
		EngineTemp = {
			Pos = Vector( 35, 9.5, -2.5 ),
			Ang = Angle(),
			Scale = 0.01
		};
		VSpeed = {
			Pos = Vector( 35, 7.85, 0.0 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Clock = {
			Pos = Vector( 35, -3, 0.50 ),
			Ang = Angle(),
			Scale = 0.01
		};		
		Airspeed = {
			Pos = Vector( 35, -3, 3.15 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Altimeter = {
			Pos = Vector( 35, -5, 2 ),
			Ang = Angle(0,-15,0),
			Scale = 0.015
		};
		Throttle = {
			Pos = Vector( 27, -2, 1.25),
			Ang = Angle(0,7,-80),
			Scale = 0.02
		};

	}
-- PrintTable( ENT.ControlSurfaces )
-- print("WTF?")
ENT.Model 			= "models/killstr3aks/neuroplanes/german/me_410_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/german/me_410_tail_anim.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/german/me_410_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/german/me_410_wing_r.mdl" }
ENT.WingWheelModels = {"models/killstr3aks/neuroplanes/german/me_410_wheel.mdl", "models/killstr3aks/neuroplanes/german/me_410_wheel.mdl"}						
ENT.TailWheel = "models/killstr3aks/neuroplanes/german/me_410_twheel.mdl"

-- ENT.ForceWeldTailToWings = true

ENT.OverrideWeldStrenght = 1 * 65000 -- make our welds tougher sine the phys wheels adds extra weight and drag on the wings.
ENT.PropellerModels 	= {"models/killstr3aks/neuroplanes/german/me_410_propeller.mdl", "models/killstr3aks/neuroplanes/german/me_410_propeller.mdl"}
ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= {Vector( 0, 20.5, 0 ), Vector( 0, -20.5, 0 )}
-- ENT.PropellerFireOffset = 32
		

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 30	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 3500 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 3100 	-- how fast we drop speed
ENT.RudderMultiplier = 3 			-- how much we turn 
ENT.PitchValue = 2.5					-- how fast we rise / dive
ENT.AutoRollYawFactor = 170			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 600  -- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 340			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 580			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce = 450					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 2.5
ENT.PitchForceDivider = 1.25
ENT.YawForceDivider = 0.525

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 0.12 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 2.20 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 30 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 

-- ENT.HasAnimatedParts = true

-- Weapons
ENT.PhysicalAmmo = true
ENT.NoSecondaryWeapons = false

ENT.TracerScale1 = 0.2
ENT.TracerScale2 = 0.3
ENT.ImpactScale = 2
ENT.GlowProxyScale = 2.0

ENT.BurstDuration = 0.08
ENT.NoLockon = true
ENT.PrimaryCooldown = 3
ENT.MuzzleOffset = 25
ENT.Muzzle = "ChopperMuzzleFlash"
ENT.MinDamage = 1800
ENT.MaxDamage = 2300
ENT.Radius = 52
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/75mm_shot.wav" )
ENT.ContigiousFiringLoop = false

ENT.MinigunSound = "wt/guns/75mm_shot.wav" 
ENT.MinigunPos = {  Vector( 3.4, 0, 1.5 )  }

-- End of weapons

-- Visuals
ENT.CameraDistance = 110
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 8, 0, 10 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = ENT.PropellerPos
ENT.JetExhaust = true 

-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/me410_engine.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/me410_engine.wav"}
ENT.Armament = {

					{ 
						PrintName = "SC500",
						Mdl = "models/killstr3aks/neuroplanes/bombs/sc500.mdl" ,
						Pos = Vector( 0, 0, -5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						Color = Color( 0,0,0,0 ),
						LaunchSound = "wt/misc/bomb_drop.wav"
					}; 	
				};
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 1600
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() self:CivAir_DefaultInit()
	
	-- PrintTable( self.Wings[1]:GetSequenceList() )
	-- PrintTable( self.Wings[2]:GetSequenceList() )
	-- PrintTable( self.Tail:GetSequenceList() )
	
	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
		
		self:GetPhysicsObject():AddAngleVelocity( Vector( 14.76, -2.375, -.75 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

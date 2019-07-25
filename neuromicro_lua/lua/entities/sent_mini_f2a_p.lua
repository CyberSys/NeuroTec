ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "F2A Buffalo"
ENT.Author	= "Hoffa / Killstr3aKs"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 300
	
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/american/F2A_Buffalo_elevators.mdl", 
			Pos = Vector(-33,0,1 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/american/F2A_Buffalo_rudder.mdl",
			Pos = Vector(-30.9,0,3.6),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/american/F2A_Buffalo_aileron_l.mdl",
			Pos = Vector(-1.7,29.8,1.6),
			Ang = Angle( 0,-7,5.5 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/american/F2A_Buffalo_aileron_r.mdl",
			Pos = Vector(-1.7,-29.7,1.6),
			Ang = Angle( 0,7,-5.5 )
			};
		};
	Flaps = {
			{
			Mdl = "models/killstr3aks/neuroplanes/american/F2A_Buffalo_flap_l.mdl",
			Pos = Vector(-5,12.6,-.7),
			Ang = Angle( 0,-6,7 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/american/F2A_Buffalo_flap_r.mdl",
			Pos = Vector(-5,-12.6,-.7),
			Ang = Angle( 0,6,-7)
			};
		};

} 
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 10, 2.75, 3.4 ),
			Ang = Angle(),
			Scale = .01
		};	
		EngineTemp = {
			Pos = Vector( 10, 2.75, 0.4 ),
			Ang = Angle(),
			Scale = .01
		};
		Compass = {
			Pos = Vector( 10, 5.5, 3 ),
			Ang = Angle(),
			Scale = .01
		};
		Airspeed = {
			Pos = Vector( 10, -.25, 3.1 ),
			Ang = Angle(),
			Scale = .01
		};
		Clock = {
			Pos = Vector( 10, 5.5, 0 ),
			Ang = Angle(), 
			Scale = .01
		};
		Throttle = {
			Pos = Vector( 10, -2, 1.1 ),
			Ang = Angle(),
			Scale = .015
		};
		VSpeed = {
			Pos = Vector( 10, 10, 1 ),
			Ang = Angle(),
			Scale = .01
		};
		Altimeter = {
			Pos = Vector( 10, 0, 0 ),
			Ang = Angle(),
			Scale = .01
		}		
	}
ENT.Model 			= "models/killstr3aks/neuroplanes/american/F2A_Buffalo_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/american/F2A_Buffalo_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/american/F2A_Buffalo_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/american/F2A_Buffalo_wing_r.mdl" }
ENT.WingWheelModels = {"models/killstr3aks/neuroplanes/american/F2A_Buffalo_wheel_l.mdl", "models/killstr3aks/neuroplanes/american/F2A_Buffalo_wheel_l.mdl"}
ENT.PropellerModel 	= "models/killstr3aks/neuroplanes/american/F2A_Buffalo_propeller.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 3500 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 3500 	-- how fast we drop speed
ENT.RudderMultiplier = 16 			-- how much we turn 
ENT.PitchValue = 4					-- how fast we rise / dive
ENT.AutoRollYawFactor = 40			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 95		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 95		    -- tail lift coefficient
ENT.MaxVelocity = 1.9 * 540			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.235					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 150					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce = 780					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
-- ENT.BankForceDivider = 0.5
ENT.PitchForceDivider = 1.75
ENT.YawForceDivider = 0.65

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 4.5 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 170 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.PhysicalAmmo = false
-- ENT.NoSecondaryWeapons = true
ENT.BurstSize = 4
ENT.RoundsPerSecond = 2
ENT.BurstDuration = 0.08

ENT.NoLockon = true
ENT.PrimaryCooldown = 0.01
ENT.MuzzleOffset = 25
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.MinDamage = 15
ENT.MaxDamage = 30
ENT.Radius = 25
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/m2_loop.wav" )
ENT.ContigiousFiringLoop = true -- 

ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( -20, -2, 6 ),Vector( -20, 2, 6 ), Vector( -25, 15, 0 ), Vector( -25, -15, 0 )  }
ENT.PrimaryMaxShots = 40

-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( -6, 0, 7.9 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 10,3,-5 ), Vector( 10, -3, -5 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine08_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine08_1750rpm.wav"}

if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 1512
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		
		-- constraint.Weld( ent, game.GetWorld(), 0,0, false )
		
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() self:CivAir_DefaultInit() 
		
		 -- self.Wings[1]:SetSequence( 0 )
		-- local sequence = self.Wings[1]:LookupSequence( "idle" )
		-- self.Wings[1]:SetSequence( sequence )
		-- print( self.Wings[1]:SequenceDuration(0) )
		
		-- self.Wings[1].InvalidateBoneCache()
	
	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think()

		-- self.Wings[1]:SetPoseParameter( "idle",math.random(0,90) )	

	end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) end
	
end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

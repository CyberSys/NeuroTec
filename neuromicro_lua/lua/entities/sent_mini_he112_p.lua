ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Heinkel He 112"
ENT.Author	= "Hoffa / Killstr3aKs"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 200
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/german/HE112_elevators.mdl", 
			Pos = Vector(-35.7,0,1.8 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/german/HE112_rudder.mdl",
			Pos = Vector(-35.5,0,4.2),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/HE112_aileron_l.mdl",
			Pos = Vector(3,28.4,-1.4),
			Ang = Angle( 0,-16,10 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/HE112_aileron_r.mdl",
			Pos = Vector(3,-28.4,-1.4),
			Ang = Angle( 0,16,-10 )
			};
		};
		
	Flaps = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/HE112_flap_l.mdl",
			Pos = Vector(0.15,14.3,-4),
			Ang = Angle( 0,-8,9 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/HE112_flap_r.mdl",
			Pos = Vector(0.15,-14.3,-4),
			Ang = Angle( 0,8,-9)
			};
		};
	
}
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 35, 8, -4 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Compass = {
			Pos = Vector( 35, 14.5, -11 ),
			Ang = Angle(),
			Scale = 0.025
		};
		VSpeed = {
			Pos = Vector( 35, 1.5, -4 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Clock = {
			Pos = Vector( 35, -6, -9.50 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Altimeter = {
			Pos = Vector( 35, 14.5, -4 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Airspeed = {
			Pos = Vector( 35, 8, -11 ),
			Ang = Angle(),
			Scale = 0.025
		};		
		EngineTemp = {
			Pos = Vector( 35, 1.5, -11 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Throttle = {
			Pos = Vector( 35, -3, -10.5 ),
			Ang = Angle(),
			Scale = 0.04
		};
	}
-- PrintTable( ENT.ControlSurfaces )
-- print("WTF?")
ENT.Model 			= "models/killstr3aks/neuroplanes/german/HE112_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/german/HE112_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/german/HE112_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/german/HE112_wing_r.mdl" }
ENT.PropellerModel 	= "models/killstr3aks/neuroplanes/german/HE112_propeller.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 8000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 4500 	-- how fast we drop speed
ENT.RudderMultiplier = 10 			-- how much we turn 
ENT.PitchValue = 3.99					-- how fast we rise / dive
ENT.AutoRollYawFactor = 170			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 60		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 34			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 560			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce = 500					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 1.5
ENT.PitchForceDivider = 1.2
ENT.YawForceDivider = 0.625

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
ENT.PhysicalAmmo = false
-- ENT.NoSecondaryWeapons = true
ENT.BurstSize = 6
ENT.RoundsPerSecond = 2
ENT.BurstDuration = 0.08

ENT.NoLockon = true
ENT.PrimaryCooldown = 0.01
ENT.MuzzleOffset = 85
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.MinDamage = 5
ENT.MaxDamage = 15
ENT.Radius = 5
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/mg17_loop.wav" )
ENT.ContigiousFiringLoop = true

ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( -25, -3, 0 ),Vector( -25, 3, 0 )  }
ENT.PrimaryMaxShots = 30

-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 2, 0, 5.8 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 10,4,0 ), Vector( 10, -4, 0 )
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine11_1000rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine11_1000rpm.wav"}
ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT.TracerScale1  = 0.051
ENT.TracerScale2 = 0.051
ENT.TracerGlowProxy = 0.7 
ENT._2ndRecoilAngle = 1.5 
ENT._2ndRecoilDuration = 10 
ENT._2ndRecoilForce = -500000


ENT.Armament = {

					{ 
						PrintName = "MG-FF",
						Mdl = "models/items/AR2_Grenade.mdl" ,
						Pos = Vector( 30, 20, -1), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Shell",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.05, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
					}; 
					{ 
						PrintName = "MG-FF",
						Mdl = "models/items/AR2_Grenade.mdl" ,
						Pos = Vector( 30, -20, -1), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Shell",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.05, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
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
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() self:CivAir_DefaultInit() end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() self:NextThink(0) end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime )  self:MicroPhysics( phys, deltatime ) 
		
		self:GetPhysicsObject():AddAngleVelocity( Vector( -6, -0.5, -2 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

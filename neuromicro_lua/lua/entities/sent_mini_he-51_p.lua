ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Heinkel He 51"
ENT.Author	= "Hoffa / Killstr3aKs / daylight106"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.AutoStable = true 

ENT.InitialHealth = 150				
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/german/he_51_elevators.mdl", 
			Pos = Vector(-41,0,2.75 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/german/he_51_rudder.mdl",
			Pos = Vector(-42.5,0,3.5),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/he_51_aileron_1l.mdl",
			Pos = Vector(-3,31.5,9.9),
			Ang = Angle( 0,-6,2 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/he_51_aileron_1r.mdl",
			Pos = Vector(-3,-31.5,9.9),
			Ang = Angle( 0,6,-2 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/he_51_aileron_2l.mdl",
			Pos = Vector(-6,21,-2.75),
			Ang = Angle( 0,0,0 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/he_51_aileron_2r.mdl",
			Pos = Vector(-6,-21,-2.75),
			Ang = Angle( 0,0,0 )
			};
		};

} 
local offs = Vector(0,0,3.5)
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 15, 3.75, 2.75 ) - offs ,
			Ang = Angle(),
			Scale = 0.01
		};
		Compass = {
			Pos = Vector( 35, -10.5, -8 ) - offs ,
			Ang = Angle(),
			Scale = 0.02
		};
		VSpeed = {
			Pos = Vector( 35, 2.5, -3.5 ) - offs ,
			Ang = Angle(),
			Scale = 0.02
		};
		Clock = {
			Pos = Vector( 35, 25, -10.0 ) - offs ,
			Ang = Angle(),
			Scale = 0.02
		};
		Altimeter = {
			Pos = Vector( 35, 20, -8 ) - offs ,
			Ang = Angle(),
			Scale = 0.02
		};
		Airspeed = {
			Pos = Vector( 35, 15.5, -4.5 ) - offs ,
			Ang = Angle(),
			Scale = 0.025
		};		
		EngineTemp = {
			Pos = Vector( 35, -2.5, -4.5 ) - offs ,
			Ang = Angle(),
			Scale = 0.02
		};
		Throttle = {
			Pos = Vector( 35, -7.5, -6 ) - offs ,
			Ang = Angle(),
			Scale = 0.02
		};
	}
ENT.Model 			= "models/killstr3aks/neuroplanes/german/he_51_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/german/he_51_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/german/he_51_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/german/he_51_wing_r.mdl" }
ENT.PropellerModel 	= "models/killstr3aks/neuroplanes/german/he_51_propeller.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 40	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 7000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 2500 	-- how fast we drop speed
ENT.RudderMultiplier = 6 			-- how much we turn 
ENT.PitchValue = 5.4					-- how fast we rise / dive
ENT.AutoRollYawFactor = 210			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 16        -- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 60		    -- tail lift coefficient
ENT.MaxVelocity = 1.9 * 440			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 7.235					-- momentum damping
ENT.AngDamping = 7.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce = 330					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2350				-- Wheel weight
-- ENT.BankForceDivider = 0.5
ENT.PitchForceDivider = 5.75
ENT.YawForceDivider = 0.85

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 4.5 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
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
ENT.MinDamage = 5
ENT.MaxDamage =15
ENT.Radius = 10
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/mg17_loop.wav" )
ENT.ContigiousFiringLoop = true -- 

ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( -20, -2, 6 ),Vector( -20, 2, 6 )  }
ENT.PrimaryMaxShots = 20

-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( -7.5, 0, 7.5 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 10,6,-2 ), Vector( 10, -6, -2 ),
Vector( 11,6,-2 ), Vector( 11, -6, -2 ),
Vector( 15,6,-2 ), Vector( 15, -6, -2 )}

ENT.StallPattern = VectorRand()*5 + Vector( -10, 0, 0 )

ENT.WheelMass = 2260
ENT.WheelPos = { Vector( 6, -2, -14 ),Vector( 6, 2, -14 )  }
ENT.WheelModels = {"models/killstr3aks/neuroplanes/russian/I5_wheel_r.mdl",
					"models/killstr3aks/neuroplanes/russian/I5_wheel_l.mdl"}
ENT.EngineSounds = {
	"wt/engines/zlinn_02_rear_1500rpm_onload.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/zlinn_02_rear_1500rpm_onload.wav"}
-- ENT.Armament = {

					-- { 
						-- PrintName = "Big Evil Bomb",
						-- Mdl = "models/killstr3aks/neuroplanes/german/micro_100kg_bomb.mdl" ,
						-- Pos = Vector( 0, 0, -5), 							-- Pos, Hard point location on the plane fuselage.
						-- Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						-- Type = "Bomb",						-- Type, used when creating the object
						-- BurstSize = 1,
						-- Cooldown = 2, 										-- Cooldown between weapons
						-- isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						-- Class = "sent_mini_bomb",
						-- LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					-- }; 	
				-- };
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 18
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
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) 
	
		self:MicroPhysics( phys, deltatime )
		
		-- if( self:GetVelocity():Length() > self.MaxVelocity / 2 ) then
				-- Vector( Roll, Pitch, Yaw )
			self:GetPhysicsObject():AddAngleVelocity( Vector( 0, -9, -1.5 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
		-- end
		
	end
	
end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

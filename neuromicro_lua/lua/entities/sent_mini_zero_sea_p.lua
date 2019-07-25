ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Nakajima A6M2-N"
ENT.Author	= "Hoffa / Killstr3aKs / Sillirion"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 250
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/japanese/a6m_zero_elevators.mdl", 
			Pos = Vector(-64,0,1 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/japanese/a6m_zero_rudder.mdl",
			Pos = Vector(-67.6,0,2.35),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/japanese/a6m_zero_aileron_l.mdl",
			Pos = Vector(2.5,.3,-4.4),
			Ang = Angle( 0,-8,4.3 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/japanese/a6m_zero_aileron_r.mdl",
			Pos = Vector(2.5,-.3,-4.4),
			Ang = Angle( 0,8,-4.3 )
			};
		};
}
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 18, 3.75, 2+4 ),
			Ang = Angle(),
			Scale = .005
		};
		Compass = {
			Pos = Vector( 18, 0.0, 2+4 ),
			Ang = Angle(),
			Scale = .005
		};
		Airspeed = {
			Pos = Vector( 18, 2.5, 2+4 ),
			Ang = Angle(),
			Scale = .005
		};
		Clock = {
			Pos = Vector( 18, 2.5, 2+2.75 ),
			Ang = Angle(),
			Scale = .005
		};
		Throttle = {
			Pos = Vector( 18, 1.7, 2+4.5 ),
			Ang = Angle(),
			Scale = .009
		};
		VSpeed = {
			Pos = Vector( 18, 3.75, 2+2.75 ),
			Ang = Angle(),
			Scale = .005
		};		
		EngineTemp = {
			Pos = Vector( 18, 4.65, 2+2.4 ),
			Ang = Angle(0,0,0),
			Scale = .004
		};		
		FuelCounter = {
			Pos = Vector( 18, 4.65, 2+3.4),
			Ang = Angle(0,0,0),
			Scale = .004
		};
		Altimeter = {
			Pos = Vector( 18, 0.0, 2+2.75 ),
			Ang = Angle(),
			Scale = .005
		}		
	}
ENT.Model 			= "models/killstr3aks/neuroplanes/japanese/a6m_zero_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/japanese/a6m_zero_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/japanese/a6m_zero_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/japanese/a6m_zero_wing_r.mdl" }
ENT.PropellerModel 	= "models/killstr3aks/neuroplanes/japanese/a6m_zero_propeller.mdl"

ENT.TailPos			= Vector( 33, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32

ENT.PontoonPos = { Vector(5,-25,-67),Vector(5,1,-68.5),Vector(5,25,-67) }
ENT.PontoonAngles = { Angle( 0,0,0),Angle( 0,0,0), Angle(0,0,0) }
ENT.PontoonModels = {"models/sillirion/neuroplanes/floatty_sides.mdl", "models/sillirion/neuroplanes/Floatty_middle.mdl","models/sillirion/neuroplanes/floatty_sides.mdl" }
ENT.PontoonBuoyancy = 5010.0 
ENT.PontoonMass = 500

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 6500 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 3500 	-- how fast we drop speed
ENT.RudderMultiplier = 20 			-- how much we turn 
ENT.PitchValue = 25.2715					-- how fast we rise / dive
ENT.AutoRollYawFactor = 40			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 60		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 30			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 570			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce = 200					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = .75
ENT.PitchForceDivider = 8
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
ENT.MouseBankForce = 1 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
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
ENT.MuzzleOffset = 85
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.MinDamage = 5
ENT.MaxDamage = 15
ENT.Radius = 10
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/type97_gun.wav" )
ENT.ContigiousFiringLoop = true

ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( -5, -2, 4 ),Vector( -5, 2, 4 )  }
ENT.PrimaryMaxShots = 30

-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 9, 0, 7.9 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 25,6,-2 ), Vector( 25, -6, -2 )
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine_b25_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine_b25_1750rpm.wav"}
ENT.ArmamentDamageSystem = true 
ENT.Armament = {
					{ 
						PrintName = "Torpedophile",
						Mdl = "models/neuronaval/killstr3aks/mini_torpedo_naval.mdl" ,
						Pos = Vector( 7, 15, -5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Damage = 3500,
						Radius = 60,
						Class = "sent_mini_torpedo",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 		
					{ 
						PrintName = "Torpedophile",
						Mdl = "models/neuronaval/killstr3aks/mini_torpedo_naval.mdl" ,
						Pos = Vector( 7, -15, -5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Damage = 3500,
						Radius = 60,
						Class = "sent_mini_torpedo",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 	
				};
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 55
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
		
		for i=1,#self.Pontoons do 
			
			if( IsValid( self.Pontoons[i] ) ) then 
				
				self.Pontoons[i]:SetSubMaterial( 0, "phoenix_storms/gear" )
				self.Pontoons[i]:SetColor( Color( 255,255,255,255)) 
			end 
		
		end 
		
	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

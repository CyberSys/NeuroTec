ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Polikarpov I-15bis"
ENT.Author	= "Hoffa / Killstr3aKs"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.AutoStable = true 

ENT.InitialHealth = 125			
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/russian/I15bis_elevators.mdl", 
			Pos = Vector(-30.3,0,5.25),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/russian/I15bis_rudder.mdl",
			Pos = Vector(-29.7,0,2.45),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/russian/I15bis_aileron_l.mdl",
			Pos = Vector(-2,23,9.8),
			Ang = Angle( 5,0,3.6 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/russian/I15bis_aileron_r.mdl",
			Pos = Vector(-2,-23,9.8),
			Ang = Angle( 5,-0,-3.6 )
			};
		};

} 

ENT.Model 			= "models/killstr3aks/neuroplanes/russian/I15bis_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/russian/I15bis_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/russian/I15bis_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/russian/I15bis_wing_r.mdl" }
-- ENT.PropellerModel 	= 
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl","models/killstr3aks/neuroplanes/russian/I15_propeller.mdl", "models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= { Vector( 6,21, -7 ), Vector( 0, 0, 0 ), Vector( 6,-21, -7 ) }
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 40	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 7000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 2000 	-- how fast we drop speed
ENT.RudderMultiplier = 6 			-- how much we turn 
ENT.PitchValue = 6.97					-- how fast we rise / dive
ENT.AutoRollYawFactor = 300			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 46        -- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 55		    -- tail lift coefficient
ENT.MaxVelocity = 1.9 * 480			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 7.235					-- momentum damping
ENT.AngDamping = 7.84					-- angular momentum damping
ENT.PropForce = 150					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce = 330					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 3800				-- Wheel weight
-- ENT.BankForceDivider = 0.5
ENT.PitchForceDivider = 4.75
ENT.YawForceDivider = 0.8225

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
ENT.BurstSize = 8
ENT.RoundsPerSecond = 2
ENT.BurstDuration = 0.08

ENT.NoLockon = true
ENT.PrimaryCooldown = 0.01
ENT.MuzzleOffset = 25
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.MinDamage = 5
ENT.MaxDamage = 10
ENT.Radius = 10
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/mg_8mm_mg34_loop.wav" )
ENT.ContigiousFiringLoop = true -- 

ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( -25, -6, 0 ),Vector( -25, 6, 0 ), Vector( -25, 2, 4 ), Vector( -25, -2, 4 )   }
ENT.PrimaryMaxShots = 20

-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( -10, 0, 7.7 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { Vector( -8, 20, -7.7 ), Vector( -8, -20, -7.7 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = 1
ENT.ExhaustDieTime = 1

ENT.StallPattern = VectorRand()*5 + Vector( -10, 0, 0 )

ENT.WheelMass = 3800
ENT.WheelPos = { Vector( 6.5, 0, -12.5 ),Vector( 6.5, 0, -12.5 )  }
ENT.WheelModels = {"models/killstr3aks/neuroplanes/russian/I15_wheel_r.mdl",
					"models/killstr3aks/neuroplanes/russian/I15_wheel_l.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine10_1800rpm.wav",
	"wt/engines/jet_engine_rpm66.wav",
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
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 16
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
		
		if( IsValid( self.Propellers[1] ) ) then 
			
			self.Propellers[1]:SetNoDraw( true )
			
		end 
		
		if( IsValid( self.Propellers[3] ) ) then 
			
			self.Propellers[3]:SetNoDraw( true )
			
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
	function ENT:PhysicsSimulate( phys, deltatime ) 
	
		self:MicroPhysics( phys, deltatime )
		
		-- if( self:GetVelocity():Length() > self.MaxVelocity / 2 ) then
				-- Vector( Roll, Pitch, Yaw )
			self:GetPhysicsObject():AddAngleVelocity( Vector( 0, -8.5, 0 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
		-- end
		
	end
	
end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

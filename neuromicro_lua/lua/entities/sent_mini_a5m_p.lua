ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Mitsubishi A5M"
ENT.Author	= "Hoffa / Killstr3aKs"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 170
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/japanese/A5M_elevators.mdl", 
			Pos = Vector(-38.2,0,-2.4 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/japanese/A5M_rudder.mdl",
			Pos = Vector(-38.3,0,2.5),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/japanese/A5M_aileron_l.mdl",
			Pos = Vector(-3.5,29,-5.5),
			Ang = Angle( 0,-12,10 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/japanese/A5M_aileron_r.mdl",
			Pos = Vector(-3.5,-29,-5.5),
			Ang = Angle( 0,12,-10 )
			};
		};
	Flaps = {
		{
		Mdl = "models/killstr3aks/neuroplanes/japanese/A5M_flap_1l.mdl",
		Pos = Vector(-4.5,13,-8.8),
		Ang = Angle( 0,0,12 )
		};
		{
		Mdl = "models/killstr3aks/neuroplanes/japanese/A5M_flap_1r.mdl",
		Pos = Vector(-4.5,-13.3,-8.8),
		Ang = Angle( 0,0,-12)
		};
	};
}

ENT.Model 			= "models/killstr3aks/neuroplanes/japanese/A5M_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/japanese/A5M_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/japanese/A5M_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/japanese/A5M_wing_r.mdl" }
ENT.PropellerModel 	= "models/killstr3aks/neuroplanes/japanese/A5M_propeller.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, -2 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize =4500 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 4500 	-- how fast we drop speed
ENT.RudderMultiplier = 3 			-- how much we turn 
ENT.PitchValue = 4.6715					-- how fast we rise / dive
ENT.AutoRollYawFactor = 50			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = -190		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 15			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 570			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 5					-- Propeller Phys Obj Mass
ENT.BankForce = 550					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.YawForceDivider = 0.625
ENT.PitchForceDivider = 4.625

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 6.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 30 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
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
ENT.MinDamage = 15
ENT.MaxDamage = 30
ENT.Radius = 10
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/type97_gun.wav" )
ENT.ContigiousFiringLoop = true
ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( -25, -2, 2 ),Vector( -25, 2, 2 )  }
ENT.PrimaryMaxShots = 30

-- End of weapons

-- Visuals
ENT.CameraDistance = 130
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( -1, 0, 3.5 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 10,4,-2 ), Vector( 10, -4, -2 )
}
ENT.WheelPos = { Vector( 6, -19, -15 ),Vector( 6, 19, -15 )  }
ENT.WheelModels = {"models/killstr3aks/neuroplanes/japanese/A5M_wheel_l.mdl","models/killstr3aks/neuroplanes/japanese/A5M_wheel_r.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine_b25_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine_b25_1750rpm.wav"}
ENT.Armament = {

					{ 
						PrintName = "Big Evil Bomb",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_100kg_bomb.mdl" ,
						Pos = Vector( 0, 0, -7), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 	
				};
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
	function ENT:Initialize() self:CivAir_DefaultInit() end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime )
	
		if( IsValid( self.Pilot ) && !self.Destroyed && self.CurVelocity ) then
			
			if( self:GetVelocity():Length() > self.MaxVelocity / 4 ) then
			
				self:GetPhysicsObject():AddAngleVelocity( Vector( -2.8, -9, -3 ) * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
				
			end
			
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

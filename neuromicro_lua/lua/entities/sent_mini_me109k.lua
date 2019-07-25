ENT.Type = "vehicle" 
ENT.Base = "base_anim"
ENT.PrintName	= "Messerschmitt BF-109K"
ENT.Author	= "Radek"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 350
ENT.ControlSurfaces  = {
	Elevator = {
			{
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_elevator_l.mdl", 
			Pos = Vector(-24.5,5.8,3.5 ),
			Ang = Angle( 0,0,0 )
			};
			{
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_elevator_r.mdl",
			Pos = Vector( -25,-5.5,3.7 ),
			Ang = Angle( 0,0,0 )
			};
		};
	Rudder = {	
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_rudder.mdl",
			Pos = Vector(-25.4,0.4,3.57),
			Ang = Angle( 5,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_aileron_l.mdl",
			Pos = Vector(3,28.5,-0.1),
			Ang = Angle( 0,-8,7 )
			};
			{
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_aileron_r.mdl",
			Pos = Vector(1.7,-29.3,-0.1),
			Ang = Angle( 0,6,-7.5 )
			};
		};
		
	Flaps = {
			{
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_flap_l.mdl",
			Pos = Vector(0.7,12.4,-1.7),
			Ang = Angle( 0,-8,5 )
			};
			{
			Mdl = "models/radek/neuroplanes/ger/me-109K/me109k_flap_r.mdl",
			Pos = Vector(-0.1,-12.6,-2.3),
			Ang = Angle( 0,6,-6)
			};
		};
	
}

ENT.Model 			= "models/radek/neuroplanes/ger/me-109K/me109k_body.mdl"
ENT.TailModel 		= "models/radek/neuroplanes/ger/me-109K/me109k_tail.mdl"
ENT.WingModels 		= { "models/radek/neuroplanes/ger/me-109K/me109k_wing_l.mdl", 
						"models/radek/neuroplanes/ger/me-109K/me109k_wing_r.mdl" }
ENT.PropellerModel 	= "models/aftokinito/neuroplanes/german/bf-109g-14_prop.mdl"
ENT.IsShitPlane = false --bruh are you foken serious 

ENT.TailPos			= Vector( -12.4, 0, 1.9)
ENT.WingPositions 	= {  Vector( 3,3.2,-2.2 ), 
						Vector( 3.6,-4.5,-2.27 ) }
ENT.PropellerPos 	= Vector( -13.7, -1, 1.7 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 55	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 5 				--unused atm
ENT.ThrottleIncrementSize = 6000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 2000 	-- how fast we drop speed
ENT.RudderMultiplier = 3 			-- how much we turn 
ENT.PitchValue = 2.7					-- how fast we rise / dive
ENT.AutoRollYawFactor = 10			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 290		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 45			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 700			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 6						-- momentum damping
ENT.AngDamping = 3					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 20					-- Propeller Phys Obj Mass
ENT.BankForce = 1300					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 6.4
-- ENT.PitchForceDivider = 2.5
-- ENT.YawForceDivider = 2.1

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 3.9 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 3.7 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 1000 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 1400 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 
ENT.PitchForceDivider = 15.75
ENT.YawForceDivider = 1.4925
-- ENT.BankForceDivider


-- Weapons -- initial data, this gets overridden by the MinigunData table
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
ENT.MaxDamage = 35
ENT.Radius = 5
ENT.AmmoType = "sent_mgun_bullet"
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/ho103_loop.wav" ) --wt/guns/mg_8mm_mg34_loop.wav
ENT.ContigiousFiringLoop = true

ENT.MinigunSound = "wt/guns/fw_guns.wav"
ENT.MinigunPos = {  Vector( -13, -4, 3 ),Vector( -13, 1.5, 3 )  }
ENT.PrimaryMaxShots = 30

				
ENT.TracerScale1 = 0.1
ENT.TracerScale2 = 0.1
ENT.ImpactScale = 1.0
ENT.PrimaryMaxShots = 30
-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 0.5, -0.5, 6.5 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 23,4,-2 ), Vector( 23, -4, -2 ),
Vector( 25,4,-2 ), Vector( 25, -4, -2 ),
Vector( 28,4,-2 ), Vector( 28, -4, -2 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine_cockpit_open_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine_cockpit_open_1750rpm.wav"}
ENT.Armament = {

					{ 
						PrintName = "Big Evil Bomb",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_100kg_bomb.mdl",
						Pos = Vector( 0, 0, -4.5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 8, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 
{ 
						PrintName = "MG-FF",
						Mdl = "models/items/AR2_Grenade.mdl" ,
						Pos = Vector( 28, -1, 0), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Shell",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.1, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
					};  						
				};
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 524
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
		
		self:GetPhysicsObject():AddAngleVelocity( Vector( 66,0,8 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

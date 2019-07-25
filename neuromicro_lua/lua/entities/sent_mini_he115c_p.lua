ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Heinkel He-115 C"
ENT.Author	= "Hoffa / J-Son"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.PropellerAttachedToWings = true 

ENT.InitialHealth = 500
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/hoffa/neuroplanes/german/he115/he115_elevator.mdl", 
			Pos = Vector(-57.5,0,6.5 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/hoffa/neuroplanes/german/he115/he115_rudder.mdl",
			Pos = Vector(-61.15,0,9.35),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/hoffa/neuroplanes/german/he115/he115_aileron_l.mdl",
			Pos = Vector(1.45,47.5,3.65),
			Ang = Angle( 10,-6.8,7 )
			};
			{
			Mdl = "models/hoffa/neuroplanes/german/he115/he115_aileron_r.mdl",
			Pos = Vector(3.45,-59.8,5.65),
			Ang = Angle( 10,4,-5 )
			};
		};
		
	Flaps = {
			{
			Mdl = "models/hoffa/neuroplanes/german/he115/he115_flap_l.mdl",
			Pos = Vector(2,19.5,1.35),
			Ang = Angle( 5,-0.3,4.3)
			};
			{
			Mdl = "models/hoffa/neuroplanes/german/he115/he115_flap_r.mdl",
			Pos = Vector(2,-28.7,2.5),
			Ang = Angle( 0,1,-5)
			};
		};
	
}

-- PrintTable( ENT.ControlSurfaces )
-- print("WTF?")
ENT.Model 			= "models/hoffa/neuroplanes/german/he115/he115_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/german/he115/he115_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/german/he115/he115_wing_l.mdl", 
						"models/hoffa/neuroplanes/german/he115/he115_wing_r.mdl" }
ENT.PropellerModels 	= { "models/killstr3aks/neuroplanes/american/f2a_buffalo_propeller.mdl",  "models/killstr3aks/neuroplanes/american/f2a_buffalo_propeller.mdl"}
ENT.PropellerPos = { Vector( 24, 18, 4.5 ), Vector( 24, -18, 4.5 ) }
ENT.PontoonPos = { Vector( 18.75,-18,-17),Vector(21.5,17,-17), Vector( -50,0,-70 ) }
ENT.PontoonAngles = { Angle( 0,0,0),Angle( 0,0,0), Angle( 0,0,0 ) }
ENT.PontoonModels = {"models/hoffa/neuroplanes/german/he115/he115_pontoon_1.mdl", "models/hoffa/neuroplanes/german/he115/he115_pontoon_2.mdl", "models/sillirion/neuroplanes/floatty_middle.mdl" }
ENT.PontoonBuoyancy = 400.0 
ENT.PontoonMass = 250
  
ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
-- ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32
-- ENT.OverrideWeldStrenght = 5000000
--- Physics
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 15	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 4000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 2500 	-- how fast we drop speed
ENT.RudderMultiplier = 2 			-- how much we turn 
ENT.PitchValue = 2.25					-- how fast we rise / dive
ENT.AutoRollYawFactor = 25			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 60/1.8		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 72/1.8			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 590			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 100					-- Propeller Phys Obj Mass
ENT.BankForce =  820					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 7.5
ENT.PitchForceDivider = 10.2
ENT.YawForceDivider = 1.625
ENT.PontoonedSterringForce = 2.0
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
ENT.MinDamage = 15
ENT.MaxDamage = 65
ENT.Radius = 5
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/mg_8mm_mg34_loop.wav" )
ENT.ContigiousFiringLoop = true

ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 1, -56, 5 ),Vector( 1, 56, 5 )  }
ENT.PrimaryMaxShots = 30

-- End of weapons

-- Visuals
ENT.CameraDistance = 190
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 40.75, 0, 7.5 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
 Vector( 20, 18, 5 ), Vector( 20, -18, 5 )
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/me410_engine.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/me410_engine.wav"}
ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT.TracerScale1  = 0.1
ENT.TracerScale2 = 0.1
ENT.TracerGlowProxy = 1 
ENT._2ndRecoilAngle = 1.05 
ENT._2ndRecoilDuration = 10 
ENT._2ndRecoilForce = -500000


ENT.Armament = {

					{ 
						PrintName = "Pretty Mean Cannon",
						Mdl = "models/items/AR2_Grenade.mdl" ,
						Pos = Vector( 65, 0, -1), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Shell",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.25, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
					}; 	
					{ 
						PrintName = "Torpedophile",
						Mdl = "models/neuronaval/killstr3aks/mini_torpedo_planes.mdl" ,
						Pos = Vector( 15, -3, -3), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 15, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Damage = 3500,
						Radius = 60,
						Class = "sent_mini_torpedo",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 	
					{ 
						PrintName = "Torpedophile",
						Mdl = "models/neuronaval/killstr3aks/mini_torpedo_planes.mdl" ,
						Pos = Vector( 15, 3, -3), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 15, 										-- Cooldown between weapons
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
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 16
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		-- constraint.Weld( ent, game.GetWorld() ,0,0,0,false,false )
		
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() self:CivAir_DefaultInit()	
		
		self.Pontoons[3]:SetNoDraw( true )
		-- constraint.NoCollide( self.Wings[1],self.Wings[2] )
		-- constraint.NoCollide( self.Pontoons[2], self.Wings[1] )
		-- constraint.NoCollide( self.Pontoons[1], self.Wings[2] )
		
		timer.Simple( 0.1, function() self.Pontoons[3] = nil  end ) 
		
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
		
		self:GetPhysicsObject():AddAngleVelocity( Vector( -25, -9.5, -24 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

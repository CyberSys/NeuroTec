ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "JU-87B2 Stuka"
ENT.Author	= "Hoffa / Killstr3aks / Daylight106"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.ContigiousFiringLoop = true

ENT.InitialHealth = 325
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/german/stuka_elevators.mdl", 
			Pos = Vector(-39,0,4 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/german/stuka_rudder.mdl",
			Pos = Vector(-40,0,-1),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/stuka_aileron_1l.mdl",
			Pos = Vector(-10,0,-6),
			Ang = Angle( 0,-20,10.3 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/stuka_aileron_1r.mdl",
			Pos = Vector(-10,0,-6),
			Ang = Angle( 0,20,-10.3 )
			};
		};
	Flaps = {
			{
			Mdl = "models/killstr3aks/neuroplanes/german/stuka_aileron_2l.mdl",
			Pos = Vector(-10,0,-6),
			Ang = Angle( 0,-20,10.3 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/german/stuka_aileron_2r.mdl",
			Pos = Vector(-10,0,-6),
			Ang = Angle( 0,20,-10.3 )
			};
		};

} 
ENT.Model 			= "models/killstr3aks/neuroplanes/german/stuka_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/german/stuka_tail.mdl"
ENT.WingModels 		= { "models/killstr3aks/neuroplanes/german/stuka_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/german/stuka_wing_r.mdl" }
ENT.PropellerModel 	= "models/killstr3aks/neuroplanes/german/stuka_propeller.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 5	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 4 				-- unused atm
ENT.ThrottleIncrementSize = 3000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 3000 	-- how fast we drop speed
ENT.RudderMultiplier = 3 			-- how much we turn 
ENT.PitchValue = 7.71					-- how fast we rise / dive
ENT.AutoRollYawFactor = 40			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 18000		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 55			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 600			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 4						-- momentum damping
ENT.AngDamping = 6					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 10					-- Propeller Phys Obj Mass
ENT.BankForce = 500					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics
ENT.PitchForceDivider = 1.95
ENT.YawForceDivider = 0.2725
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 35, 8, -9.5 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Compass = {
			Pos = Vector( 35, 14.5, -16 ),
			Ang = Angle(),
			Scale = 0.025
		};		
		FuelCounter = {
			Pos = Vector( 35, 21, -16 ),
			Ang = Angle(),
			Scale = 0.025
		};
		VSpeed = {
			Pos = Vector( 35, 1.5, -9.5 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Clock = {
			Pos = Vector( 35, -5.75, -8.350 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Altimeter = {
			Pos = Vector( 35, 14.5, -9.5 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Airspeed = {
			Pos = Vector( 35, 8, -16 ),
			Ang = Angle(),
			Scale = 0.025
		};		
		EngineTemp = {
			Pos = Vector( 35, 1.5, -16 ),
			Ang = Angle(),
			Scale = 0.025
		};
		Throttle = {
			Pos = Vector( 35, -3, -10.5 ),
			Ang = Angle(),
			Scale = 0.04
		};
	}
-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 
-- ENT.HasPilotSeat = true

-- Weapons
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.PhysicalAmmo = false
-- ENT.NoSecondaryWeapons = true
ENT.NoLockon = true
ENT.BurstSize = 8
ENT.RoundsPerSecond = 1
ENT.BurstDuration = 0.051

ENT.PrimaryCooldown = 0.145
ENT.MuzzleOffset = 85
ENT.MinDamage = 25
ENT.MaxDamage = 45
ENT.Radius = 72
ENT.AmmoType = "sent_mgun_bullet"  
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/m1919_loop_left.wav" )
ENT.MinigunSound = "wt/guns/m1919_loop_left.wav"
ENT.MinigunPos = { Vector( -5, -2, 4 ),Vector( -5, 2, 4 )  }

-- End of weapons

-- Visuals
ENT.CameraDistance = 120
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 6, -.1, 6.3 )
ENT.PassengerPos = Vector( 0, -.1,  6.3 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 25,6,-2 ), Vector( 25, -6, -2 ),
Vector( 27,6,-2 ), Vector( 27, -6, -2 ),
Vector( 30,6,-2 ), Vector( 30, -6, -2 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine_cockpit_open_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine_cockpit_open_1750rpm.wav"}
ENT.Armament = {

					{ 
						PrintName = "Big Evil Bomb",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_100kg_bomb.mdl" ,
						Pos = Vector( 0, 0, -5), 							-- Pos, Hard point location on the plane fuselage.
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
	function ENT:Initialize() 
		
		self:CivAir_DefaultInit() 
			
		self.Siren = CreateSound( self, "wt/misc/stuka_siren.wav" )
		-- self.SirenVolume = 0
		
	end
	
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
	
		if( IsValid( self.Pilot ) && !self.Destroyed ) then
			
			-- if( self:GetVelocity():Length() > self.MaxVelocity / 4 ) then
				-- Vector( Roll, Pitch, Yaw )
				
				self:GetPhysicsObject():AddAngleVelocity( Vector( 2.5, 0, 2.2 ) * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) )
				
				
			-- end
		
			-- if( self.CurVelocity && self.CurVelocity >= self.MaxVelocity ) then
			
				-- self.SirenVolume = math.Approach( self.SirenVolume, 100.0, 2 )
				-- self.Siren:ChangeVolume( self.SirenVolume, .1 )
				if( self.CurVelocity > 0.55 * self.MaxVelocity && self:GetAngles().p > 45 ) then
				
					self.Siren:PlayEx( 511, 100 )
				
				else
					
					self.Siren:FadeOut( 1, 3 )
				
				end
				
			-- else
			
				-- self.SirenVolume = math.Approach( self.SirenVolume, 0.0, 2.02 )
				
			
			-- end
			
			-- print( self.SirenVolume )
			
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
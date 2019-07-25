ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Boeing B-29"
ENT.Author	= "Hoffa / Killstr3aKs"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.OverrideWeldStrenght = 95000

ENT.InitialHealth = 800
ENT.Armament = {

					{ 
						PrintName = "Big Evil Bomb",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_500kg_bomb.mdl" ,
						Pos = Vector( 0, 0, -10), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								-- Ang, object angle
						Type = "Fragment",						-- Type, used when creating the object
						BurstSize = 10,
						Cooldown = 15, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					},
					{ 
						PrintName = "Micro Nuke",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_500kg_bomb.mdl" ,
						Pos = Vector( 0, 0, -10), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 2,
						Cooldown = 30, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_micro_nuke",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 	
					
				};

ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 75, 10.5+.5, 2.8 ),
			Ang = Angle(),
			Scale = 0.011
		};
		Compass = {
			Pos = Vector( 75, 7.7+.5, 2.8 ),
			Ang = Angle(),
			Scale = 0.011
		};
		VSpeed = {
			Pos = Vector( 75, 5.5, 2.8 ),
			Ang = Angle(),
			Scale = 0.011
		};
		Clock = {
			Pos = Vector( 80, 17, -7.0 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Altimeter = {
			Pos = Vector( 80, 1, -7.5 ),
			Ang = Angle(),
			Scale = 0.02
		}
	}
ENT.Model 			= "models/killstr3aks/neuroplanes/american/B-29_body.mdl"
ENT.TailModel 		= "models/killstr3aks/neuroplanes/american/B-29_tail.mdl"

ENT.WingModels 		= { "models/killstr3aks/neuroplanes/american/B-29_wing_l.mdl", 
						"models/killstr3aks/neuroplanes/american/B-29_wing_r.mdl" }

ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/killstr3aks/neuroplanes/american/b-29_elevators.mdl", 
			Pos = Vector(-148,0,8.5 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
			Mdl = "models/killstr3aks/neuroplanes/american/b-29_rudder.mdl",
			Pos = Vector(-148,0,0),
			Ang = Angle( 0,0,0 )
			};
	Ailerons = {
			{
			Mdl = "models/killstr3aks/neuroplanes/american/b-29_aileron_1l.mdl",
			Pos = Vector(-34,0,-3.8),
			Ang = Angle( 0,0,4.3 )
			};
			{
			Mdl = "models/killstr3aks/neuroplanes/american/b-29_aileron_1r.mdl",
			Pos = Vector(-34,0,-3.8),
			Ang = Angle( 0,0,-4.3 )
			};
		};

} 



						
ENT.PropellerModels 	= { 
"models/killstr3aks/neuroplanes/american/B-29_propeller.mdl",
"models/killstr3aks/neuroplanes/american/B-29_propeller.mdl",
"models/killstr3aks/neuroplanes/american/B-29_propeller.mdl",
"models/killstr3aks/neuroplanes/american/B-29_propeller.mdl"}

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= {
						
						Vector( 4.95, 35.5, 1.4 ),
						Vector( 0, 80.3, 4 ),
						Vector( 4.95, -35.5, 1.4 ),
						Vector( 0, -80.3, 4 )
						}
ENT.PropellerFireOffset = 32
ENT.PropellerAttachedToWings = true


--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 100	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 75 				--unused atm
ENT.ThrottleIncrementSize = 5000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 1000 	-- how fast we drop speed
ENT.RudderMultiplier = 5 			-- how much we turn 
ENT.PitchValue = 7					-- how fast we rise / dive
ENT.AutoRollYawFactor = 50			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 56		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 1000			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 570			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 8						-- momentum damping
ENT.AngDamping = 5					-- angular momentum damping
ENT.PropForce = 200					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 10					-- Propeller Phys Obj Mass
ENT.BankForce = 120					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
ENT.NA_IsCivilian = true
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 15 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
-- ENT.PhysicalAmmo = false
-- ENT.NoSecondaryWeapons = false
-- ENT.NoLockon = true
-- ENT.PrimaryCooldown = 0.1
-- ENT.LastPrimaryAttack = CurTime() * 999999

ENT.MicroTurretSound = "IL-2/gun_17_22.mp3"
ENT.MicroTurretDelay = 0.01
ENT.MicroTurretMuzzle = "micro_impact_he_plane"
ENT.MicroTurretPhysRounds = false


ENT.Muzzle = "AirboatMuzzleFlash"
ENT.PhysicalAmmo = false
ENT.NoSecondaryWeapons = false
ENT.NoLockon = true
ENT.PrimaryCooldown = 10000.01
ENT.LastPrimaryAttack = CurTime() * 999999
ENT.NoMgun = true

ENT.MuzzleOffset = 85
ENT.MinDamage = 15
ENT.MaxDamage = 25
ENT.Radius = 72
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "IL-2/gun_17_22.mp3" )
ENT.MinigunSound = "IL-2/gun_17_22.mp3"
ENT.MinigunPos = { Vector( 62, 3, -2 ),Vector( 62, -0, -2 ) }

-- End of weapons

-- Visuals
ENT.CameraDistance = 300
ENT.CameraUp = 0
ENT.TinySmoke = false
ENT.CockpitPosition = Vector( 60.5, 6, 7.5 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
ENT.PropellerModel 	= "models/props_junk/PopCan01a.mdl"
-- ENT.HideProp = true
-- ENT.NoPropeller = true
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = ENT.PropellerPos 
ENT.JetExhaust = true 
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine13_1750rpm.wav" }
	
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 1500
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		-- constraint.Weld( game.GetWorld(), ent, 0,0,0, true )
		
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
	function ENT:SecondaryAttack( wep, id )		if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
	
		if( IsValid( self.Pilot ) && !self.Destroyed ) then
			
			-- if( self:GetVelocity():Length() > self.MaxVelocity / 4 ) then
				-- Vector( Roll, Pitch, Yaw )
				self:GetPhysicsObject():AddAngleVelocity( Vector( 25, 0, 0.25 ) ) 
				
			-- end
		
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end

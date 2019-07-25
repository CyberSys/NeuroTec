ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Kyushu J7W \"Shinden\""
ENT.Author	= "Hoffa / Aftokinito"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 250

ENT.Model 			= "models/aftokinito/neuroplanes/japanese/j7w1_body.mdl"
ENT.TailModel 		= "models/aftokinito/neuroplanes/japanese/j7w1_nose.mdl"
ENT.WingModels 		= { "models/aftokinito/neuroplanes/japanese/j7w1_wing_l.mdl", 
						"models/aftokinito/neuroplanes/japanese/j7w1_wing_r.mdl" }
ENT.PropellerModel 	= "models/aftokinito/neuroplanes/japanese/j7w1_prop.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector(-40.5,0,1.85)
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 5000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 1500 	-- how fast we drop speed
ENT.RudderMultiplier = 7 			-- how much we turn 
ENT.PitchValue = 12					-- how fast we rise / dive
ENT.AutoRollYawFactor = 40			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 28.4		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 100			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 580			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5						-- momentum damping
ENT.AngDamping = 5					-- angular momentum damping
ENT.PropForce = -100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 10					-- Propeller Phys Obj Mass
ENT.BankForce = 455					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics
ENT.PitchForceDivider = 1.75
ENT.YawForceDivider = 0.3725

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 30 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.PhysicalAmmo = true
ENT.NoSecondaryWeapons = true
-- ENT.BurstSize = 20
-- ENT.RoundsPerSecond = 50
-- ENT.BurstDuration = 0.01

ENT.TracerScale1 = 0.05
ENT.TracerScale2 = 0.05
ENT.ImpactScale = 1
ENT.TracerGlowProxy = 1

ENT.NoLockon = true
ENT.PrimaryCooldown = 0.1
ENT.MinDamage = 15
ENT.MaxDamage = 25
ENT.Radius = 13
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/aa12mm_fire_loop.wav" )
ENT.ContigiousFiringLoop = true

ENT.MinigunSound = "wt/guns/aa12mm_fire_loop.wav"
ENT.MinigunPos = { Vector( 5, 2, -2 ),Vector(5, -2, -2 ), Vector( 5, -1, 3 ),Vector( 5, 1, 3 )  }
ENT.PrimaryMaxShots = 35
-- End of weapons

-- Visuals
ENT.CameraDistance = 150
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 5, 0, 12 )
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
	"wt/engines/engine12_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine12_1750rpm.wav"}
ENT.Armament = {

				{ 
					PrintName = "Big Evil Bomb",
					Mdl = "models/items/AR2_Grenade.mdl" ,
					Pos = Vector( 0, 25, -15), 							-- Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
					Type = "Bomb",						-- Type, used when creating the object
					BurstSize = 1,
					Cooldown = 2, 										-- Cooldown between weapons
					isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_mini_bomb",
					Color = Color( 0,0,0,0 ),
					LaunchSound = "vehicles/crane/crane_magnet_release.wav"
				}; 	
				{ 
					PrintName = "Big Evil Bomb",
					Mdl = "models/items/AR2_Grenade.mdl" ,
					Pos = Vector( 0, -25, -15), 							-- Pos, Hard point location on the plane fuselage.
					Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
					Type = "Bomb",						-- Type, used when creating the object
					BurstSize = 1,
					Cooldown = 2, 										-- Cooldown between weapons
					isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
					Class = "sent_mini_bomb",
					Color = Color( 0,0,0,0 ),
					LaunchSound = "vehicles/crane/crane_magnet_release.wav"
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
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	return end
	function ENT:PhysicsSimulate( phys, deltatime ) 
	
		self:MicroPhysics( phys, deltatime ) 
		self:JetAir_Think() 
		
		if( IsValid( self.Pilot ) && !self.Destroyed && self.CurVelocity ) then
			
			if( self:GetVelocity():Length() > self.MaxVelocity / 4 ) then
			
				self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0,2.5 ) * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
				
			end
			
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
